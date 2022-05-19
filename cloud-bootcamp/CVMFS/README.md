

There are different approaches to enable CVMFS on a cloud, either by adding a Customzation Script when launching a VM, or install & configure directly on a running VM, or even apply it to your own cloud image(s). 

* Here is the script for different OS flavors:

  -- For CentOS/Redhat: ![CVMFS Customization Script](https://github.com/ualberta-rcg/public/blob/master/cloud-bootcamp/CVMFS/custom_script)

  -- For Fedora: (TBD) 

  -- For Ubuntu/Debian:(TBD) 

  -- For SLES/OpenSUSE: (TBD) 

  -- For Windows: (TBD) 


* To enable CVMFS via Openstack Dashboard:

![Alt Install_CVMFS_on_your_VM](https://user-images.githubusercontent.com/73720293/97760381-a80ae600-1ac8-11eb-904f-5861c93d6bd8.png)



* To enable it on a running VM

Just simply run the script on your VM it will perform all the setup steps for you.  


* Once it's installed and configured, you can test CVMFS with running:

```
  $ ls /cvmfs/soft.computecanada.ca
config  custom  easybuild  gentoo  new_repository  nix
```

or list any other repositories you added to CVMFS_REPOSITORIES variable. 


* Now, you can run the following command to enable software modules from CVMFS:

`$ source /cvmfs/soft.computecanada.ca/config/profile/bash.sh`

More details please refer to: https://docs.computecanada.ca/wiki/Accessing_CVMFS

* To check what software/libraries you can use, run:

`$ module avail`

* You will see a long list of software and libraries (which are called modules), then you can load a certain module by running, e.g., 

`$ module load blast/2.2.26`

* The following LMOD cache enabling settings can be used to accelerate the module loadings.

```
 $ export RSNT_ENABLE_LMOD_CACHE=yes
 $ module update
```



