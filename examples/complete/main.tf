module "vsan_policy" {
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
