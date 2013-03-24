Vagrant::Config.run do |config|
    config.vm.box     = "squeeze64puppet3"
    config.vm.box_url = "http://l4bs.slynett.com/vagrant/squeeze64-puppet3.box"
    
    config.vm.customize [ "modifyvm", :id, "--name", "ISPConfig testing" ]
    config.vm.customize [ "modifyvm", :id, "--memory", "1024", "--cpus", "2" ]

    config.vm.network :hostonly, "11.11.11.11"
    config.vm.host_name = "ispconfig.local"

    config.vm.share_folder "vagrant", "/vagrant", "."

    config.vm.provision :shell, :inline => "echo \"Europe/Paris\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "manifests"
        puppet.module_path    = "modules"
        puppet.manifest_file  = "base.pp"
    end
end
