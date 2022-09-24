#____________________________________________________________
#
# UCS Domain VSAN Policy Variables Section.
#____________________________________________________________

variable "description" {
  default     = ""
  description = "Description for the Policy."
  type        = string
}

variable "name" {
  default     = "default"
  description = "Name for the Policy."
  type        = string
}

variable "organization" {
  default     = "default"
  description = "Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/."
  type        = string
}

variable "profiles" {
  default     = []
  description = "List of UCS Domain Profile Moids to Assign to the Policy."
  type        = list(string)
}

variable "tags" {
  default     = []
  description = "List of Tag Attributes to Assign to the Policy."
  type        = list(map(string))
}

variable "uplink_trunking" {
  default     = false
  description = "Enable or Disable Trunking on all of configured FC uplink ports."
  type        = bool
}

#____________________________________________________________
#
# VSAN Policy -> Add VSAN Variables Section.
#____________________________________________________________

variable "vsan_list" {
  default     = []
  description = <<-EOT
    * default_zoning: (optional) - Enables or Disables the default zoning state.
      - Enabled - Admin configured Enabled State.
      - Disabled: (default) - Admin configured Disabled State.
    * fc_zone_sharing_mode: (optional) - Logical grouping mode for fc ports.  Not used at this time.
    * fcoe_vlan_id: (required) -  FCoE VLAN Identifier to Assign to the VSAN Policy.
    * name: (optional) - Name for VSAN(s).
    * vsan_id:  (required) -  VSAN Identifier to Assign to the VSAN Policy.
    * vsan_scope - Used to indicate whether the VSAN Id is defined for storage or uplink or both traffics in FI.
      - Uplink: (default) - Vsan associated with uplink network.
      - Storage - Vsan associated with storage network.
      - Common - Vsan that is common for uplink and storage network.
  EOT
  type = list(object({
    default_zoning       = optional(string, "Disabled")
    fc_zone_sharing_mode = optional(string, "")
    fcoe_vlan_id         = optional(number, null)
    name                 = optional(string, "")
    vsan_id              = number
    vsan_scope           = optional(string, "Uplink")
  }))
}
