apt-get update
apt-get install -y iproute2
apt-get install iperf
apt -y install openssh-server openssh-client
apt-get -y install pdsh
apt-get install ninja-build
apt-get install libaio-dev

# if you setup anaconda, maybe you can backup your bashrc here for convenience
cp -r /export/home/devops/backup_bashrc /root/.bashrc

ssh-keygen -q -t rsa -N '' <<< $'\ny' >/dev/null 2>&1
service ssh restart

