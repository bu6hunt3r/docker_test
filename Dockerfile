FROM debian:latest
MAINTAINER bu6hunt3r

# Add ansible configuration
ADD playbooks/ /etc/ansible/playbooks/
ADD templates/ /etc/ansible/templates/
ADD var/ /etc/ansible/var/
ADD var/settings.yml /etc/ansible/var/settings.yml
ADD hosts /etc/ansible/hosts

WORKDIR /etc/ansible

# Install Ansible
RUN apt-get -y update &&  \
    apt-get -y upgrade &&  \
    apt-get -q -y --no-install-recommends install python-yaml \
               python-jinja2 python-httplib2 python-keyczar \
               python-paramiko python-setuptools \
               python-pkg-resources git python-pip &&  \
    mkdir -p /etc/ansible/ &&  \
    pip install ansible &&  \
    ansible-playbook /etc/ansible/playbooks/Mysql.yml -c local &&  \
    ansible-playbook /etc/ansible/playbooks/apache.yml -c local &&  \
    apt-get clean purge --auto-remove -y python2.6 python2.6-minimal &&  \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose port 22 and 80
EXPOSE 22 80

# Startup script to run mysql and apache
RUN echo "#!/bin/bash\n/etc/init.d/mysql start\n/etc/init.d/apache2 start\n/bin/bash" > /root/init.sh && \
    chmod 755 /root/init.sh

ENTRYPOINT ["/root/init.sh"]
