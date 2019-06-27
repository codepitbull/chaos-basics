NODE_1_IP = "192.168.6.2"
NODE_2_IP = "192.168.6.3"
NODE_3_IP = "192.168.6.4"

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.synced_folder "shared/", "/shared"
  config.ssh.insert_key = false
  
  config.vm.define "m1" do |m1|
    m1.vm.box = "sagepe/stretch"
    m1.vm.network "private_network", ip: NODE_1_IP
    m1.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.extra_vars = {
        node_ip: NODE_1_IP
      }
    end
  end

  config.vm.define "m2" do |m2|
    m2.vm.box = "sagepe/stretch"
    m2.vm.network "private_network", ip: NODE_2_IP
    m2.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.extra_vars = {
        master_ip: NODE_1_IP,
        node_ip: NODE_2_IP
      }
    end
  end

  config.vm.define "m3" do |m3|
    m3.vm.box = "sagepe/stretch"
    m3.vm.network "private_network", ip: NODE_3_IP
    m3.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
      ansible.extra_vars = {
        master_ip: NODE_1_IP,
        node_ip: NODE_3_IP
      }
    end
  end

end
