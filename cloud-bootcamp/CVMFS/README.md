

There are different approaches to enable CVMFS on a cloud VM, either by adding a Customzation Script when launching a VM, or install & configure directly on a running VM, or even apply it to your own cloud image(s). 

* Here is the script for RedHat/CentOS flavor (please change `yum` command accordingly for other flavors, such as `apt-get` for Ubuntu/Debian):
  [CVMFS Customization Script](https://github.com/ualberta-rcg/public/blob/master/cloud-bootcamp/CVMFS/basic_setup.sh)
  

* You can either run the script after the VM is deployed or enable it via the Dashboard during a VM creation:
  ![Alt Install_CVMFS_on_your_VM](https://user-images.githubusercontent.com/73720293/97760381-a80ae600-1ac8-11eb-904f-5861c93d6bd8.png)


* Once it's installed and configured, you can test CVMFS with running:

```
  $ ls /cvmfs/soft.computecanada.ca
config  custom  easybuild  gentoo  new_repository  nix
```
(or list any other repositories you added to CVMFS_REPOSITORIES variable)


* Now, you can run the following command to enable software modules from CVMFS:

If you don't have the environment module installed yet,
On Redhat/CentOS: 

`$ yum -y install environment-modules`

Or on Ubuntu/Debian: 

`$ apt-get update; apt-get -y install environment-modules`

And then source the setup script:

`$ source /cvmfs/soft.computecanada.ca/config/profile/bash.sh`

More details please refer to: https://docs.computecanada.ca/wiki/Accessing_CVMFS

* To check what software/libraries you can use, run:

`$ module avail`

* You will see a long list of software and libraries (which are called modules), then you can load a certain module by running, e.g., 

`$ module load blast/2.2.26`

`$ module list`

* The following LMOD cache enabling settings can be used to accelerate the module loadings.

```
 $ export RSNT_ENABLE_LMOD_CACHE=yes
 $ module update
```

* To access AI/ML software that are not modulized, here is an example of the setup:
```
module load StdEnv/2020
module load python/3.9.6
python3 -m venv myenv
source myenv/bin/activate
avail_wheels
pip install --no-index torch torchvision torchtext torchaudio
```
(For more details, refer to: https://docs.alliancecan.ca/wiki/PyTorch)

