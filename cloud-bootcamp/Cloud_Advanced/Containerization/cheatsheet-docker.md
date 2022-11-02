0. To install docker:

   - On Linux, for Redhat/Centos/Fedora:
     ```
     yum-config-manager   --add-repo   https://download.docker.com/linux/centos/docker-ce.repo
     yum -y install docker-ce
     
     systemctl start docker
     systemctl enable docker
     ```
   - On other OSes/flavors, refer to: https://docs.docker.com/engine/install/

1. Docker common operations:
   ```
   1) Basics
   # Run a container directly
     docker run hello-world
   # Show running containers
     docker ps
   # Show all containers including exited ones
     docker ps -a
     
   # Rename a container
     docker rename $CONTAINER new_name
    
   # Start/stop a container
     docker stop $CONTAINER_ID Or $CONTAINER_NAME

   # Download an image
     docker pull busybox
   # List downloaded images
     docker images
   
   # Run a container and a command, based on the downloaded image
     docker run busybox echo "Hello from inside busybox"
     
   # Interactively run a container
     docker run -it busybox sh
     ls
     uptime
     ls /bin
     exit
     
   # Remove a container
     docker ps -a
     docker rm $CONTAINER_ID
   # Remove all exited containers 
     docker rm $(docker ps -a -q -f status=exited)
     Or,
     docker container prune
     
   # Remove an image
     docker rmi $IMAGE
     
   2) Web services with Docker
   # Search an image from docker repository
     docker search nginx
   # Run nginx container interactively
     docker run --rm -it nginx
     exit
   # Run nginx in detached mode and generate ports automatically
     docker run -d -P --name mynginx nginx
     docker port mynginx
     curl http://localhost:49153
   # Specify a port 
     docker run -d -p 8080:80 --name mynginx2 nginx
     docker port mynginx2
     curl http://localhost:8080
   
   
   3) Transfer files between host and containers
   # Copy a file from the host to a contianer
      docker cp /etc/redhat-release $CONTAINER_ID:/tmp
      docker exec $CONTAINER_ID ls /tmp
      OR,
      docker exec -it 90b18f696187 sh
      ls /tmp

      Vice versa, 
      docker cp $CONTAINER_ID:/etc/motd .
      cat ./motd
      
   4) Move container from one host to another
    # Method A, Export/Import a container
      # Export a container to a tar ball
       docker export mynginx > /tmp/mynginx.tar
       ls /tmp/mynginx.tar

       docker stop mynginx2
       docker rm mynginx2

       # Create a container by importing from a tar ball
       cat /tmp/mynginx2.tar | docker import - mynginx2-imported:[tag]

    # Method B, Save/Load an image
       # Stop a container and save/commit the changes to an image
       docker stop mynginx
       docker commit mynginx mynginx:v1 
       # Save an image into tar ball file
       docker save -o /tmp/mynginx.tar mynginx

       # Load an image from the saved tarball
       docker load -i /tmp/mynginx.tar  #load an image from a tar ball
       docker run -d -P --name mynginx-imported mynginx:v1
       docker port mynginx-imported
       curl http://localhost:<port>
       
   5) Customize and upload an image
      #If image is not loaded yet
      docker search image_name
      docker pull myrepo/image_name:tag
      #If image is loaded
      docker images|grep image_name
      
      #Run a container from the image
      docker run -d -P --name container_name image_name:tag
      #Run into the shell with full privilege
      docker exec -it -u root --privileged container_name bash
      #Do some change from inside the contianer
      
      #Stop the container
      docker stop container_name
      #Commit the change with adding a note
      docker commit -m "Enabled lmod and cache" 1af465391e4a myrepo/image_name:newtag
      
      #Login to docker hub (register at first from hub.docker.com if haven't yet)
      docker login
      #Push the image:tag to a repo
      docker push myrepo/image_name:newtag
 
 


   ```
   


