variable "cloud_token" {
  type      = string
  sensitive = true
  default   = "${env("VAGRANT_CLOUD_TOKEN")}"
}

variable "version" {
  type = string
}

variable "version_description" {
  type = string
}

source "vagrant" "xeptore-alpine315-docker" {
  communicator = "ssh"
  source_path  = "generic/alpine315"
  provider     = "virtualbox"
  box_version  = "3.6.0"
  output_dir   = "build"
  add_force    = false
  insert_key   = true
}

build {
  name = "alpine315-docker"

  sources = [
    "sources.vagrant.xeptore-alpine315-docker"
  ]

  provisioner "shell" {
    inline = [
      "sudo apk add docker",
      "rc-update add docker default",
    ]
  }

  post-processors {
    post-processor "artifice" {
      files = [
        "./build/package.box",
      ]
    }

    post-processor "vagrant-cloud" {
      access_token        = "${var.cloud_token}"
      box_tag             = "xeptore/alpine315-docker"
      version             = "${var.version}"
      version_description = "${var.version_description}"
    }

    post-processor "checksum" {
      checksum_types = ["sha512"]
      output         = "build.checksum"
    }
  }
}
