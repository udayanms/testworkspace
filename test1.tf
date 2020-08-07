locals {

   repo_name = "my-workspace-name"
}

provider "tfe" {
  alias    = "tfe1"
  hostname = var.tf_hostname
  token    = var.token
  version  = "~> 0.15.0"
}

# Configure the GitHub Provider
provider "github" {
  alias        = "github1"
  token        = var.github_token
  organization = var.github_organization
}

# Add a user to the organization
resource "github_repository" "git_repo" {
  name         = local.repo_name
  description  = "My awesome codebase"
  provider     = github.github1
#  private = true

#  template {
#    owner = "github"
#    repository = "terraform-module-template"
#  }
}

resource "tfe_workspace" "test" {
  name         = "my-workspace-name"
  organization = "TFEDemo"
  provider     = tfe.tfe1
}
