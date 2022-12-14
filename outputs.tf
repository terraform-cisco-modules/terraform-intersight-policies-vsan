#____________________________________________________________
#
# Collect the moid of the VSAN Policy as an Output
#____________________________________________________________

output "moid" {
  description = "VSAN Policy Managed Object ID (moid)."
  value       = intersight_fabric_fc_network_policy.vsan.moid
}

#____________________________________________________________
#
# Collect the moid of the VSAN Policy - Add VSANs as Outputs
#____________________________________________________________

output "vsans" {
  description = "VSAN Policy - Add VSANs Managed Object ID (moid)."
  value       = { for v in sort(keys(intersight_fabric_vsan.vsans)) : v => intersight_fabric_vsan.vsans[v].moid }
}
