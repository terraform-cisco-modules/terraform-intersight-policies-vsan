module "main" {
  source       = "../.."
  description  = "${var.name} VSAN Policy."
  name         = var.name
  organization = "terratest"
  vsans = [
    {
      vsan_id = 100
    }
  ]
}

output "vsan" {
  value = module.main.vsans["100"]
}