<!-- BEGIN_TF_DOCS -->
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)
[![Tests](https://github.com/terraform-cisco-modules/terraform-intersight-policies-vsan/actions/workflows/terratest.yml/badge.svg)](https://github.com/terraform-cisco-modules/terraform-intersight-policies-vsan/actions/workflows/terratest.yml)

# Terraform Intersight Policies - VSAN
Manages Intersight VSAN Policies

Location in GUI:
`Policies` » `Create Policy` » `VSAN`

## Easy IMM

[*Easy IMM - Comprehensive Example*](https://github.com/terraform-cisco-modules/easy-imm-comprehensive-example) - A comprehensive example for policies, pools, and profiles.

## Example

### main.tf
```hcl
module "vsan" {
  source  = "terraform-cisco-modules/policies-vsan/intersight"
  version = ">= 1.0.1"

  description  = "default VSAN Policy."
  name         = "default"
  organization = "default"
  vsans = [
    {
      vsan_id = 100
    }
  ]
}
```

### provider.tf
```hcl
terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
  required_version = ">=1.3.0"
}

provider "intersight" {
  apikey    = var.apikey
  endpoint  = var.endpoint
  secretkey = fileexists(var.secretkeyfile) ? file(var.secretkeyfile) : var.secretkey
}
```

### variables.tf
```hcl
variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}

variable "secretkey" {
  default     = ""
  description = "Intersight Secret Key Content."
  sensitive   = true
  type        = string
}

variable "secretkeyfile" {
  default     = "blah.txt"
  description = "Intersight Secret Key File Location."
  sensitive   = true
  type        = string
}
```

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with the value of [your-api-key]
- Add variable secretkey with the value of [your-secret-file-content]

### Linux and Windows
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkeyfile="<secret-key-file-location>"
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.32 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | >=1.0.32 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description for the Policy. | `string` | `""` | no |
| <a name="input_domain_profiles"></a> [domain\_profiles](#input\_domain\_profiles) | Map for Moid based Domain Profile Sources. | `any` | `{}` | no |
| <a name="input_moids"></a> [moids](#input\_moids) | Flag to Determine if pools and policies should be data sources or if they already defined as a moid. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy. | `string` | `"default"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `string` | `"default"` | no |
| <a name="input_profiles"></a> [profiles](#input\_profiles) | List of UCS Domain Switch Profile Names to Assign to the Policy. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Tag Attributes to Assign to the Policy. | `list(map(string))` | `[]` | no |
| <a name="input_uplink_trunking"></a> [uplink\_trunking](#input\_uplink\_trunking) | Enable or Disable Trunking on all of configured FC uplink ports. | `bool` | `false` | no |
| <a name="input_vsans"></a> [vsans](#input\_vsans) | * default\_zoning: (optional) - Enables or Disables the default zoning state.<br>  - Enabled - Admin configured Enabled State.<br>  - Disabled: (default) - Admin configured Disabled State.<br>* fc\_zone\_sharing\_mode: (optional) - Logical grouping mode for fc ports.  Not used at this time.<br>* fcoe\_vlan\_id: (required) -  FCoE VLAN Identifier to Assign to the VSAN Policy.<br>* name: (optional) - Name for VSAN(s).<br>* vsan\_id:  (required) -  VSAN Identifier to Assign to the VSAN Policy.<br>* vsan\_scope - Used to indicate whether the VSAN Id is defined for storage or uplink or both traffics in FI.<br>  - Uplink: (default) - Vsan associated with uplink network.<br>  - Storage - Vsan associated with storage network.<br>  - Common - Vsan that is common for uplink and storage network. | <pre>list(object({<br>    default_zoning       = optional(string, "Disabled")<br>    fc_zone_sharing_mode = optional(string, "")<br>    fcoe_vlan_id         = optional(number, null)<br>    name                 = optional(string, "")<br>    vsan_id              = number<br>    vsan_scope           = optional(string, "Uplink")<br>  }))</pre> | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_moid"></a> [moid](#output\_moid) | VSAN Policy Managed Object ID (moid). |
| <a name="output_vsans"></a> [vsans](#output\_vsans) | VSAN Policy - Add VSANs Managed Object ID (moid). |
## Resources

| Name | Type |
|------|------|
| [intersight_fabric_fc_network_policy.vsan](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/fabric_fc_network_policy) | resource |
| [intersight_fabric_vsan.vsans](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/fabric_vsan) | resource |
| [intersight_fabric_switch_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_switch_profile) | data source |
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |
<!-- END_TF_DOCS -->