# -*- mode: ruby -*-
# vi: set ft=ruby :

vagrant_root = File.dirname(__FILE__)
ENV['ANSIBLE_ROLES_PATH'] = "#{vagrant_root}/.."
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'libvirt'
ENV['VAGRANT_NO_PARALLEL'] = 'yes'
ENV['VAGRANT_LIBVIRT_OVMF_CODE'] = '/usr/share/edk2/ovmf/OVMF_CODE.fd'

Vagrant.configure("2") do |config|

  config.vm.define "mdt" do |config|
    config.vm.hostname         = "mdt"
    config.vm.box              = "peru/windows-server-2022-standard-x64-eval"
    config.vm.box_check_update = false
    config.vm.provider :libvirt do |libvirt|
      libvirt.qemu_use_session     = false
      libvirt.default_prefix       = ''
      libvirt.cpus                 = 2
      libvirt.memory               = 4 * 1024
      libvirt.machine_virtual_size = 80
    end
    config.vm.network :private_network,
      auto_config:            false,
      libvirt__network_name:  "mdt-isolated",
      libvirt__forward_mode:  "none",
      libvirt__dhcp_enabled:  false
    config.vm.provision "shell", inline: "Resize-Partition -DriveLetter C -Size (Get-PartitionSupportedSize -DriveLetter C).SizeMax"
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "tests/test.yml"
      ansible.verbose  = "v"
      ansible.host_vars = {
        "mdt" => {
          "ansible_connection"                   => "winrm",
          "ansible_winrm_transport"              => "basic",
          "ansible_winrm_server_cert_validation" => "ignore"
        }
      }
    end
  end

  # config.vm.define "mdt-client-legacy" do |config|
  #   config.vm.box              = "peru/windows-10-enterprise-x64-eval"
  #   config.vm.box_check_update = false
  #   config.vm.provision "shell", inline: "$env:firmware_type"
  #   config.vm.network :private_network,
  #     auto_config:            false,
  #     libvirt__network_name:  "mdt-isolated",
  #     libvirt__forward_mode:  "none",
  #     libvirt__dhcp_enabled:  false
  #   config.vm.provider :libvirt do |libvirt|
  #     libvirt.qemu_use_session = false
  #     libvirt.default_prefix   = ''
  #     libvirt.cpus             = 2
  #     libvirt.memory           = 4 * 1024
  #   end
  # end

  # config.vm.define "mdt-client-uefi" do |config|
  #   config.vm.box              = "gusztavvargadr/windows-11"
  #   config.vm.box_check_update = false
  #   config.vm.provision "shell", inline: "$env:firmware_type"
  #   config.vm.network :private_network,
  #     auto_config:            false,
  #     libvirt__network_name:  "mdt-isolated",
  #     libvirt__forward_mode:  "none",
  #     libvirt__dhcp_enabled:  false
  #   config.vm.provider :libvirt do |libvirt|
  #     libvirt.qemu_use_session = false
  #     libvirt.default_prefix   = ''
  #     libvirt.cpus             = 2
  #     libvirt.memory           = 4 * 1024
  #   end
  # end

end
