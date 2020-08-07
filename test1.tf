locals {
   repo_name = "my-workspace-name"
   git_org = "udayanms"
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
  organization = local.github_organization 
}

# Add a user to the organization
resource "github_repository" "git_repo" {
  name         = local.repo_name
  description  = "My awesome codebase"
  provider     = github.github1
# private = true
# Valid templates would be Accuont Creation, Guard
#  template {
#    owner = "github"
#    repository = "terraform-module-template"
#  }
}

resource "tfe_workspace" "test" {
  name         = "my-workspace-name"
  organization = "TFEDemo"
  provider     = tfe.tfe1
  vcs_repo {
     identifier     = "${var.github_organization}/${local.repo_name}"
#     branch         = local.repo_name
     oauth_token_id = var.vcs_oauth_token_id
  }
}
