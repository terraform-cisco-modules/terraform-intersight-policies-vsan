#____________________________________________________________
#
# Collect the moid of the VSAN Policy as an Output
#____________________________________________________________

output "moid" {
  description = "VSAN Policy Managed Object ID (moid)."
  value       = intersight_fabric_fc_network_policy.vsan_policy.moid
}

#____________________________________________________________
#
# Collect the moid of the VSAN Policy - Add VSANs as Outputs
#____________________________________________________________

output "vsan_moids" {
  description = "VSAN Policy - Add VSANs Managed Object ID (moid)."
  value       = { for v in sort(keys(intersight_fabric_vsan.vsans)) : v => intersight_fabric_vsan.vsans[v].moid }
}
