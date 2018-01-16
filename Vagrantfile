Vagrant.configure("2") do |config|
	config.vm.define "lampstack" do |v|
		v.vm.provider "docker" do |d|
			d.build_dir = "."
			d.has_ssh = true
		end
		v.ssh.port=22
		v.ssh.username = 'root'
		v.ssh.private_key_path="/home/cr0c0/.ssh/id_rsa.pub"
		v.vm.provision "shell", inline: "echo hello"
	end
	

	#config.vm.provision "ansible" do |ansible|
	#	ansible.playbook = "playbook.yml"
	#end	
end
