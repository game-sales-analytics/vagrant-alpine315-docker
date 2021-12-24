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
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  source_path  = "generic/alpine315"
  provider     = "virtualbox"
  box_version  = "3.6.2"
  checksum     = "sha512:5fdbe9827d26a70dd618d070ddb009b5652ef18a82cb97bd19b9878a911cce745ebc3e085d09dd281e36967d3a5a4ae730c428db25c3eb9577993ec241a48a26"
  output_dir   = "build"
  add_force    = false
  add_clean    = true
  insert_key   = true
}

build {
  name = "alpine315-docker"

  sources = [
    "sources.vagrant.xeptore-alpine315-docker"
  ]

  provisioner "shell" {
    execute_command     = "echo 'vagrant' | sudo -S /bin/sh -c '{{.Path}}'"
    timeout             = "10m"
    start_retry_timeout = "5m"
    expect_disconnect   = false
    scripts = [
      "./scripts/00-apk.sh",
    ]
  }

  provisioner "shell" {
    timeout             = "10m"
    start_retry_timeout = "5m"
    expect_disconnect   = true
    inline = [
      "echo 'vagrant' | sudo -S reboot",
    ]
  }

  provisioner "shell" {
    execute_command     = "echo 'vagrant' | sudo -S /bin/sh -c '{{.Path}}'"
    timeout             = "10m"
    pause_before        = "20s"
    start_retry_timeout = "5m"
    expect_disconnect   = false
    scripts = [
      "./scripts/01-rc.sh",
    ]
  }

  provisioner "shell" {
    timeout             = "10m"
    start_retry_timeout = "5m"
    expect_disconnect   = true
    inline = [
      "echo 'vagrant' | sudo -S reboot",
    ]
  }

  provisioner "shell" {
    execute_command     = "echo 'vagrant' | sudo -S /bin/sh -c '{{.Path}}'"
    timeout             = "10m"
    pause_before        = "20s"
    start_retry_timeout = "5m"
    expect_disconnect   = false
    scripts = [
      "./scripts/02-cleanup.sh",
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
