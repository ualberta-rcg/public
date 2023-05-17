# For Redhat/Centos
sudo yum -y install https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm
sudo yum -y install cvmfs cvmfs-config-default cvmfs-config-computecanada cvmfs-auto-setup

# For Ubuntu/Debian
wegt https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
sudo dpkg -i cvmfs-release-latest_all.deb
sudo apt-get update
sudo apt-get install cvmfs

# For Fedora
sudo dnf install https://ecsft.cern.ch/dist/cvmfs/cvmfs-2.10.1/cvmfs-2.10.1-1.fc34.x86_64.rpm https://ecsft.cern.ch/dist/cvmfs/cvmfs-config/cvmfs-config-default-latest.noarch.rpm


sudo bash -c 'cat > /etc/cvmfs/default.local' << EOF
CVMFS_REPOSITORIES="cvmfs-config.computecanada.ca,soft.computecanada.ca" 
CVMFS_STRICT_MOUNT="yes"
CVMFS_QUOTA_LIMIT=10000 # Adjust this value according to the storage space on the VM
CVMFS_HTTP_PROXY="http://cvmfs-cache.arbutus.cloud.computecanada.ca:3128;DIRECT"
EOF
