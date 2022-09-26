#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  for_each = {
    for v in [var.organization] : v => v if length(
      regexall("[[:xdigit:]]{24}", var.organization)
    ) == 0
  }
  name = each.value
}

#____________________________________________________________
#
# Intersight UCS Domain Profile(s) Data Source
# GUI Location: Profiles > UCS Domain Profiles > {Name}
#____________________________________________________________

data "intersight_fabric_switch_profile" "profiles" {
  for_each = { for v in var.profiles : v => v if length(regexall("[[:xdigit:]]{24}", v)) == 0 }
  name     = each.value
}

#__________________________________________________________________
#
# Intersight VSAN Policy
# GUI Location: Policies > Create Policy > VSAN
#__________________________________________________________________

resource "intersight_fabric_fc_network_policy" "vsan" {
  depends_on = [
    data.intersight_organization_organization.org_moid,
    data.intersight_fabric_switch_profile.profiles
  ]
  description     = var.description != "" ? var.description : "${var.name} VSAN Policy."
  enable_trunking = var.uplink_trunking
  name            = var.name
  organization {
    moid = length(
      regexall("[[:xdigit:]]{24}", var.organization)
      ) > 0 ? var.organization : data.intersight_organization_organization.org_moid[
      var.organization].results[0
    ].moid
    object_type = "organization.Organization"
  }
  dynamic "profiles" {
    for_each = { for v in var.profiles : v => v }
    content {
      moid = length(
        regexall("[[:xdigit:]]{24}", profiles.value)
      ) > 0 ? profiles.value : data.intersight_fabric_switch_profile.profiles[profiles.value].results[0].moid
      object_type = "fabric.SwitchProfile"
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

#__________________________________________________________________
#
# Intersight > {VSAN Policy} > Edit  > Add VSAN
# GUI Location: Policies > Create Policy > VSAN > Add VSAN
#__________________________________________________________________

locals {
  vsan_list = {
    for v in var.vsans : v.vsan_id => {
      default_zoning       = v.default_zoning
      fcoe_vlan_id         = coalesce(v.fcoe_vlan_id, v.vsan_id)
      fc_zone_sharing_mode = v.fc_zone_sharing_mode
      name                 = v.name
      vsan_id              = v.vsan_id
      vsan_scope           = v.vsan_scope
    }
  }
}

resource "intersight_fabric_vsan" "vsans" {
  depends_on = [
    intersight_fabric_fc_network_policy.vsan
  ]
  for_each             = local.vsan_list
  default_zoning       = each.value.default_zoning
  fcoe_vlan            = each.value.fcoe_vlan_id
  fc_zone_sharing_mode = each.value.fc_zone_sharing_mode
  name = length(compact([each.value.name])
    ) > 0 ? each.value.name : length(
    regexall("^[0-9]{4}$", each.value.vsan_id)
    ) > 0 ? "VSAN${each.value.vsan_id}" : length(
    regexall("^[0-9]{3}$", each.value.vsan_id)
    ) > 0 ? "VSAN0${each.value.vsan_id}" : length(
    regexall("^[0-9]{2}$", each.value.vsan_id)
  ) > 0 ? "VSAN00${each.value.vsan_id}" : "VSAN000${each.value.vsan_id}"
  vsan_id    = each.value.vsan_id
  vsan_scope = each.value.vsan_scope
  fc_network_policy {
    moid = intersight_fabric_fc_network_policy.vsan.moid
  }
}
