sudo yum -y install https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm
sudo yum -y install cvmfs cvmfs-config-default cvmfs-config-computecanada cvmfs-auto-setup

# For Ubuntu/Debian
#sudo dpkg -i -y https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
#sudo dpkg -i -y cvmfs cvmfs-config-default cvmfs-config-computecanada cvmfs-auto-setup

sudo bash -c 'cat > /etc/cvmfs/default.local' << EOF
CVMFS_REPOSITORIES="cvmfs-config.computecanada.ca,soft.computecanada.ca" 
CVMFS_STRICT_MOUNT="yes"
CVMFS_QUOTA_LIMIT=10000 # Adjust this value according to the storage space on the VM
CVMFS_HTTP_PROXY="http://cvmfs-cache.arbutus.cloud.computecanada.ca:3128;DIRECT"  
