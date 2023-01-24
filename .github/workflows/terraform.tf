terraform {
  cloud {
    organization = "ah-ha-admin1"

    workspaces {
      name = "example-workspace"
    }
  }
}
