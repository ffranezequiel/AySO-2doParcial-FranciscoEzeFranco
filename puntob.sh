#PUNTO B:     
ip address show
ssh-keygen
cat ~/.ssh/id_rsa.pub

#PEGAMOS LA SSH EN EL HOST
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDaU6F1bd/TqE8Oz4xpPpmMRsDlZjBmtbAwM52N9zaKXyhr6ZsIobMVReVE5qc5nbeIi02POpvKqESj/Mmsbr4NubM1ewiMcEMh3qShwY15uTgszJU/MUmrLItRE2dOpR/tCsz5BW0jZkT/Og6Bw/0IhXOfk7f7rzshE2W2YowxaMe1o/X2VmRNpwPyihLDzamzmDqzeYPNhuOsFcbZvIucknsrbO3PO0TAMQiTJR7f5h1m3ZSP1y3eGw08r3KGIF+EwQ06F198k4cqvqEO+/rXCOtCrFRBW65si428m2ld+eCa5krSnxHTRgbDgYdexIf6PXl2ZyIvYdhTse7r2j2QafBxDHwEdYhAMDh3UUZp3msq4kA5jpBjFmj3t7alZElM6hGMrkj/nrTivgjev2vAR9k9Lj55VPs+bx4mR8naA0gOKBKLx8e+6DZvAGpdRpEh9kgBxSKn65Zsr0DZaVrCykHi2jvOdJMU/eKeDGEK2oVY1pPvlv6oRS6JMK5q6CE= vagrant@vm2doParcialAyso
#NOS CONECTAMOS DESDE AMN
ssh vagrant@192.168.56.9
git clone https://github.com/upszot/UTN-FRA_SO_Ansible.git
cd ejemplo_02
vim inventory
        [testing]


	desarrollo]
	192.168.56.2

	[produccion]

vim playbook.yml
	---
- hosts:
    - all
  tasks:
    - name: "Set WEB_SERVICE dependiendo de la distro"
      set_fact:
        WEB_SERVICE: "{% if   ansible_facts['os_family']  == 'Debian' %}apache2
                      {% elif ansible_facts['os_family'] == 'RedHat'  %}httpd
                      {% endif %}"

    - name: "Muestro nombre del servicio:"
      debug:
        msg: "nombre: {{ WEB_SERVICE }}"

    - name: "Run the equivalent of 'apt update' as a separate step"
      become: yes
      ansible.builtin.apt:
        update_cache: yes
      when: ansible_facts['os_family'] == "Debian"

    - name: "Instalando apache "
      become: yes
      package:
        name: "{{ item }}"
        state: present
      with_items:
        - "{{ WEB_SERVICE }}"


ansible-playbook -i inventory playbook.yml
ssh vagrant@192.168.56.2
sudo apt list --installed |grep apache
