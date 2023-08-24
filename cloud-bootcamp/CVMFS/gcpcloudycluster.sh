#!/bin/bash

# For Redhat/Centos
sudo yum -y install https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm
sudo yum -y install cvmfs cvmfs-config-default cvmfs-auto-setup

# For Ubuntu/Debian
#wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
#sudo dpkg -i cvmfs-release-latest_all.deb
#sudo apt-get update
#sudo apt-get -y install cvmfs

# For Fedora
#sudo dnf install https://ecsft.cern.ch/dist/cvmfs/cvmfs-2.10.1/cvmfs-2.10.1-1.fc34.x86_64.rpm https://ecsft.cern.ch/dist/cvmfs/cvmfs-config/cvmfs-config-default-latest.noarch.rpm

# And then create a local configuration file
sudo bash -c 'cat > /etc/cvmfs/default.local' << EOF
CVMFS_SERVER_URL="http://cvmfs-stratum-one.cern.ch/cvmfs/@fqrn@;http://cernvmfs.gridpp.rl.ac.uk/cvmf
s/@fqrn@;http://cvmfs.racf.bnl.gov/cvmfs/@fqrn@;http://cvmfs.fnal.gov/cvmfs/@fqrn@"                 
CVMFS_STRICT_MOUNT="yes"                                                                            
CVMFS_QUOTA_LIMIT=25000               
CVMFS_HTTP_PROXY="http://34.72.148.8:3128;DIRECT"                                                             
CVMFS_NFILES='256000'                                                                               
CVMFS_REPOSITORIES='sft.cern.ch,grid.cern.ch,soft.computecanada.ca,restricted.computecanada.ca'                                    
CVMFS_HIDE_MAGIC_XATTRS='yes'  

EOF

sudo cvmfs_config setup
