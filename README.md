<!-- BEGIN_TF_DOCS -->
# Terraform Intersight Policies - VSAN
Manages Intersight VSAN Policies

Location in GUI:
`Policies` » `Create Policy` » `VSAN`

## Example

### main.tf
```hcl
module "vsan" {
  source  = "terraform-cisco-modules/policies-vsan/intersight"
  version = ">= 1.0.1"

  description  = "default VSAN Policy."
  name         = "default"
  organization = "default"
  vsan_list = [
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
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}
```

## Environment Variables

Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with value of [your-api-key]
- Add variable secretkey with value of [your-secret-file-content]

### Linux
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkey=`cat <secret-key-file-location>`
```

### Windows
```bash
$env:TF_VAR_apikey="<your-api-key>"
$env:TF_VAR_secretkey="<secret-key-file-location>""
```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.32 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.32 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description for the Policy. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy. | `string` | `"default"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `string` | `"default"` | no |
| <a name="input_profiles"></a> [profiles](#input\_profiles) | List of UCS Domain Profile Moids to Assign to the Policy. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Tag Attributes to Assign to the Policy. | `list(map(string))` | `[]` | no |
| <a name="input_uplink_trunking"></a> [uplink\_trunking](#input\_uplink\_trunking) | Enable or Disable Trunking on all of configured FC uplink ports. | `bool` | `false` | no |
| <a name="input_vsan_list"></a> [vsan\_list](#input\_vsan\_list) | * default\_zoning: (optional) - Enables or Disables the default zoning state.<br>  - Enabled - Admin configured Enabled State.<br>  - Disabled: (default) - Admin configured Disabled State.<br>* fc\_zone\_sharing\_mode: (optional) - Logical grouping mode for fc ports.  Not used at this time.<br>* fcoe\_vlan\_id: (required) -  FCoE VLAN Identifier to Assign to the VSAN Policy.<br>* name: (optional) - Name for VSAN(s).<br>* vsan\_id:  (required) -  VSAN Identifier to Assign to the VSAN Policy.<br>* vsan\_scope - Used to indicate whether the VSAN Id is defined for storage or uplink or both traffics in FI.<br>  - Uplink: (default) - Vsan associated with uplink network.<br>  - Storage - Vsan associated with storage network.<br>  - Common - Vsan that is common for uplink and storage network. | <pre>list(object({<br>    default_zoning       = optional(string, "Disabled")<br>    fc_zone_sharing_mode = optional(string, "")<br>    fcoe_vlan_id         = optional(number, null)<br>    name                 = optional(string, "")<br>    vsan_id              = number<br>    vsan_scope           = optional(string, "Uplink")<br>  }))</pre> | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_moid"></a> [moid](#output\_moid) | VSAN Policy Managed Object ID (moid). |
| <a name="output_vsan_moids"></a> [vsan\_moids](#output\_vsan\_moids) | VSAN Policy - Add VSANs Managed Object ID (moid). |
## Resources

| Name | Type |
|------|------|
| [intersight_fabric_fc_network_policy.vsan](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/fabric_fc_network_policy) | resource |
| [intersight_fabric_vsan.vsans](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/fabric_vsan) | resource |
| [intersight_fabric_switch_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/fabric_switch_profile) | data source |
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |
<!-- END_TF_DOCS -->