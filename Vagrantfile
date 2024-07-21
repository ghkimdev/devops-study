# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "ubuntu/jammy64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "/vagrant/portfolio/data", "/download"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  
   config.vm.define "master01" do |master|
   	master.vm.box = "generic/rocky8"
   	master.vm.synced_folder "/vagrant/portfolio/data_master", "/download"

   	master.vm.network "private_network", ip: "192.168.56.10"
#   	master.vm.network "forwarded_port", guest: 22, host: 2220, auto_correct: true
  
	master.vm.hostname = "master01"
 	master.vm.provider "virtualbox" do |vb|
	  vb.memory = "4096"
 	  vb.cpus = 2
	end
	master.vm.provision "setup-hosts", :type => "shell", :path => "install/setup_hosts.sh"
	master.vm.provision "setup-dns", :type => "shell", :path => "install/setup_dns.sh"
	master.vm.provision "setup-locale", :type => "shell", :path => "install/setup_locale.sh"
   end

   config.vm.define "build01" do |build|
   	build.vm.box = "generic/rocky8"
   	build.vm.synced_folder "/vagrant/portfolio/data_build", "/download"

   	build.vm.network "private_network", ip: "192.168.56.11"
#   	build.vm.network "forwarded_port", guest: 22, host: 2221, auto_correct: true
  
	build.vm.hostname = "build01"
 	build.vm.provider "virtualbox" do |vb|
	  vb.memory = "8192"
 	  vb.cpus = 2
	end

	build.vm.provision "setup-hosts", :type => "shell", :path => "install/setup_hosts.sh"
	build.vm.provision "setup-dns", :type => "shell", :path => "install/setup_dns.sh"
	build.vm.provision "setup-locale", :type => "shell", :path => "install/setup_locale.sh"
   end

   config.vm.define "monitor01" do |monitor|
   	monitor.vm.box = "generic/rocky8"
   	monitor.vm.synced_folder "/vagrant/portfolio/data_monitor", "/download"

   	monitor.vm.network "private_network", ip: "192.168.56.12"
#   	monitor.vm.network "forwarded_port", guest: 22, host: 2223, auto_correct: true
  
 	monitor.vm.hostname = "monitor01" 
 	monitor.vm.provider "virtualbox" do |vb|
	  vb.memory = "6144"
 	  vb.cpus = 2
	end

	monitor.vm.provision "setup-hosts", :type => "shell", :path => "install/setup_hosts.sh"
	monitor.vm.provision "setup-dns", :type => "shell", :path => "install/setup_dns.sh"
	monitor.vm.provision "setup-locale", :type => "shell", :path => "install/setup_locale.sh"
   end

   config.vm.define "web01" do |web|
   	web.vm.box = "generic/rocky8"
   	web.vm.synced_folder "/vagrant/portfolio/data_web", "/download"

   	web.vm.network "private_network", ip: "192.168.56.13"
#   	web.vm.network "forwarded_port", guest: 22, host: 2224, auto_correct: true

 	web.vm.hostname = "web01" 
 	web.vm.provider "virtualbox" do |vb|
	  vb.memory = "2048"
 	  vb.cpus = 2
	end

	web.vm.provision "setup-hosts", :type => "shell", :path => "install/setup_hosts.sh"
	web.vm.provision "setup-dns", :type => "shell", :path => "install/setup_dns.sh"
	web.vm.provision "setup-locale", :type => "shell", :path => "install/setup_locale.sh"
   end

   config.vm.define "db01" do |db|
   	db.vm.box = "generic/rocky8"
   	db.vm.synced_folder "/vagrant/portfolio/data_db", "/download"

   	db.vm.network "private_network", ip: "192.168.56.14"
#   	web.vm.network "forwarded_port", guest: 22, host: 2225, auto_correct: true

 	db.vm.hostname = "db01" 
 	db.vm.provider "virtualbox" do |vb|
	  vb.memory = "2048"
 	  vb.cpus = 2
	end

	db.vm.provision "setup-hosts", :type => "shell", :path => "install/setup_hosts.sh"
	db.vm.provision "setup-dns", :type => "shell", :path => "install/setup_dns.sh"
	db.vm.provision "setup-locale", :type => "shell", :path => "install/setup_locale.sh"
   end
  #   config.vm.provider "virtualbox" do |vb|

  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  #   vb.cpus = 2
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
