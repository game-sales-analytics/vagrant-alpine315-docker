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

source "virtualbox-iso" "xeptore-alpine315-docker" {
  guest_os_type        = "Linux_64"
  iso_url              = "https://dl-cdn.alpinelinux.org/alpine/v3.15/releases/x86_64/alpine-virt-3.15.0-x86_64.iso"
  iso_checksum         = "sha512:df2c74ad9362411db259407a24d1f4e48df2b16fd53cc194cc6b9e666ed4741d37057fa34cb3f8e3e0710133f6a3d6ccff6b5e690fb511a51ef7cca2bc323b7e"
  ssh_timeout          = "3600s"
  shutdown_command     = "/sbin/poweroff"
  disk_size            = 10000
  nested_virt          = false
  guest_additions_mode = "disable"
  output_directory     = "./build"
  vm_name              = "xeptore-alpine315-docker"
  headless             = false
  cpus                 = 4
  memory               = 4096
  boot_wait            = "40s"
  http_directory       = "http"
  communicator         = "ssh"
  ssh_username         = "root"
  ssh_password         = "vagrant"
  vrdp_bind_address    = "127.0.0.1"
  vrdp_port_min        = 11000
  vrdp_port_max        = 12000
  boot_command = [
    "root<enter><wait>",
    "ifconfig eth0 up<enter><wait>",
    "udhcpc -i eth0<enter><wait>",
    "sed -i -e \"/rc-service/d\" /sbin/setup-sshd<enter><wait>",
    "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/answers<enter><wait>",
    "source answers<enter><wait>",
    "printf \"vagrant\\nvagrant\\ny\\n\" | sh /sbin/setup-alpine -f /root/answers && ",
    "mount /dev/sda2 /mnt && ",
    "echo 'PasswordAuthentication yes' >> /mnt/etc/ssh/sshd_config && ",
    "echo 'PermitRootLogin yes' >> /mnt/etc/ssh/sshd_config && ",
    "chroot /mnt apk add openntpd && chroot /mnt rc-update add openntpd default && reboot<enter><wait50>"
  ]
}

build {
  name = "alpine315-docker"

  sources = [
    "sources.virtualbox-iso.xeptore-alpine315-docker"
  ]

  provisioner "shell" {
    execute_command     = "/bin/sh '{{.Path}}'"
    timeout             = "120m"
    start_retry_timeout = "15m"
    expect_disconnect   = true
    scripts = [
      "scripts/00-network.sh",
      "scripts/01-apk.sh",
    ]
  }

  provisioner "shell" {
    timeout = "120m"
    scripts = [
      "scripts/02-hostname.sh",
      "scripts/03-lsb.sh",
      "scripts/04-floppy.sh",
      "scripts/05-vagrant.sh",
      "scripts/06-sshd.sh",
      "scripts/06-docker.sh",
      "scripts/07-cache.sh",
      "scripts/08-cleanup.sh",
    ]
    execute_command     = "{{.Vars}} /bin/sh '{{.Path}}'"
    pause_before        = "120s"
    start_retry_timeout = "15m"
    expect_disconnect   = true
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    compression_level = 9
    provider_override = "virtualbox"
    output = "alpine315-docker.box"
    vagrantfile_template = "vagrantfile.tpl"
  }

  post-processor "vagrant-cloud" {
    access_token        = "${var.cloud_token}"
    box_tag             = "xeptore/alpine315-docker"
    version             = "${var.version}"
    version_description = "${var.version_description}"
  }

  post-processor "checksum" {
    checksum_types = ["sha512"]
    output         = "packer_{{.BuildName}}.checksum"
  }
}
