###### Welcome to the public space of the Research Support Group at the University of Alberta

## HPC carpenrty 4, 
#### What to do when you run into problems. 
#### Interactive use, first steps in debugging, tunning, and profiling.

The intent of this workshop is to follow HPC carpentry pedagogy and continue on from where the HPC carpentry typically ends.
Using HPC resources is a challenging topic to a new user and best practices or what to do when a new user runs into problems get cut. This is made worse when the participant does not have a good foundation using the Unix operating system environment.  This results in being participants getting being able to use a cluster until they run into the first problem. 



### This document will include instructions on how to do the demos that go allong with the presentation 
### This includes most of the value to the workshop particpant. 

1. Log into the Cluster have yor workshop participants do the same and open 3 seperate windows.
 `ssh user98@training.uofa.c3.ca -X`
1. Have the class run script to capture all the imput and output in the workshop. Mention the utility of using this program for support requests. 
`script hpc4-worskshop.txt`
1. Look at the node types on this cluster 
`sinfo  -o "%N %m"`
 
