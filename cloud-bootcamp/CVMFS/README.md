

1, Script of the CVMFS client installation (Linux OS oriented)
  [CVMFS Customization Script](https://github.com/ualberta-rcg/public/blob/master/cloud-bootcamp/CVMFS/basic_setup.sh)
  
2, Once the client is installed and configured, you can test CVMFS with running:

```
  $ ls /cvmfs/soft.computecanada.ca
config  custom  easybuild  gentoo  new_repository  nix
```
(or list any other repositories you added to CVMFS_REPOSITORIES variable)


3, Now, you can run the following commands to enable software modules from CVMFS:

* If you don't have the environment module installed yet,
* On Redhat/CentOS: 

`$ sudo yum -y install environment-modules`

* Or on Ubuntu/Debian: 

`$ sudo apt-get update; apt-get -y install environment-modules`

* And then source the setup script:

!!! Important: Switch to a regular user account to run the following script (As it's disabled to run modules as root for security concerns)

`$ source /cvmfs/soft.computecanada.ca/config/profile/bash.sh`

* More details please refer to: https://docs.computecanada.ca/wiki/Accessing_CVMFS

4, To check what software/libraries you can use, run:

`$ module avail`

5, You will see a long list of software and libraries (which are called modules), then you can load a certain module by running, e.g., 

`$ module load blast/2.2.26`

`$ module list`

6, The following LMOD cache enabling settings can be used to accelerate the module loadings.

```
 $ export RSNT_ENABLE_LMOD_CACHE=yes
 $ module update
```

7, Some software may not have been modulized, such as some AI/ML ones. To access those software, here is an example of how to access them (e.g. PyTorch):
```
#Load python first if doesn't exist
module load StdEnv/2020
module load python/3.9.6
python3 -m venv myenv
source myenv/bin/activate
avail_wheels

#Install PyTorch with pip
pip install --no-index torch torchvision torchtext torchaudio
```
(For more details, refer to: https://docs.alliancecan.ca/wiki/PyTorch)

8, Hint: for a cloud VM, you can also enable it via the Dashboard during the VM creation:
  ![Alt Install_CVMFS_on_your_VM](https://user-images.githubusercontent.com/73720293/97760381-a80ae600-1ac8-11eb-904f-5861c93d6bd8.png)

