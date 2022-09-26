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
