#PUNTO B:     
ip address show
ssh-keygen
cat ~/.ssh/id_rsa.pub

#PEGAMOS LA SSH EN EL HOST
vim .ssh/id_rsa.pub
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYTzv+qEIhnhgi9QxrKVqf9EfmV5TSxT1iLfTU3w2E3ZqY+aUhvNjUGGQO1mstSckUfz6gDNmokyiHFCxBmaiXW250L1bnC+jeBEO5bhqpK9vn4pAPs/OyFuJeCUL7011mjEftOwpB1X+obuDlEz4YAfpnoHRE3RnzC0hPVwCFHMsmTmKWUlYJivsbTAf0xP4UbSKskcngqyO90kWUR/qBfWeeodEDfxv6s0pEIEjTkKYOFsIRCHzcrbhWjA31JIrPIQSLa1if+SJHnMItbnMqdTbQh5gOO/zXYP5FTwBntsI/W7AQdVjesHA/iAojGC1jm8uutseE244UCI3thvX7K+L3eOtcAFl3knpdJXsYgdmkMxOy8di1Kjv9x12qsjOdGzQPQiFW38RixKExjXOZHAmhwLm9T/4zpYc40kHyMJEQ153QixY8kya0nX/THeIETNPSrFbYfY4QZ/3eriKdcYecHKFjuwW1vCcYsxNXq4Vidi2yFUSYlDI7pCFJRb8= vagrant@vm2doParcialAyso" >> .ssh/authorized_keys

#NOS CONECTAMOS DESDE AMN
ssh vagrant@192.168.56.9
git clone https://github.com/upszot/UTN-FRA_SO_Ansible.git
cd ejemplo_02
vim inventory
	[testing]


	desarrollo]
	192.168.56.9

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
sudo apt list --installed |grep apache
