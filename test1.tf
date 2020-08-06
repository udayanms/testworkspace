provider "tfe" {
  hostname = "${var.hostname}"
 token    = "${var.token}"
  version  = "~> 0.15.0"
}

resource "tfe_workspace" "test" {
  name         = "my-workspace-name"
  organization = "TFE-LZ"
}
