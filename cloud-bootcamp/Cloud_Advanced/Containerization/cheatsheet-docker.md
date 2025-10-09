0. Install docker and set up non-root user:

   - On Linux, for Redhat/Centos/Fedora/Almalinux/Rockylinux:
     ```
     sudo yum-config-manager   --add-repo   https://download.docker.com/linux/centos/docker-ce.repo
     sudo yum -y install docker-ce
     
     sudo systemctl enable docker
     sudo systemctl start docker
     ```

   - To run docker as a non-root user
     ```
     sudo usermod -aG docker $USER
     logout
     ```
     (and then login again)

   - On other OSes/flavors, refer to: https://docs.docker.com/engine/install/

0. An example of a Dockerfile
   ```
   # Use the official lightweight Nginx image
   FROM nginx:latest

   # Copy a custom HTML file to the web root
   #COPY index.html /usr/share/nginx/html/

   # Expose port 80
   EXPOSE 80

   # Start Nginx
   CMD ["nginx", "-g", "daemon off;"]

   ```
   #To use the Dockerfile, e.g.:

   #docker  build  -t  IMAGE:tag   dir_Dockerfile
   ```
   docker  build  -t  myweb:1.0  .
   docker run -d -p 80:80 myweb:1.0
   curl localhost:80
   ```

3. Docker common operations:
   ```
   1) Basics
   # Run a container directly
     docker run hello-world
   
   # Show running containers
     docker ps
   
   # Show all containers including exited ones
     docker ps -a
     
   # Download an image
     docker pull busybox
   # List downloaded images
     docker images
   
   # Run a container and a command, based on the downloaded image
     docker run busybox echo "Hello from inside busybox"
     docker run busybox sleep 300 &
     
   # Interactively run a container
     docker run -it busybox sh
       #from the container shell, run:
       hostname
       whoami
       ls
       uptime
       du -sh
       exit
       
   # Rename a container
     docker rename $CONTAINER new_name
   
   # Start/stop a container
     docker stop $CONTAINER_ID Or $CONTAINER_NAME
     docker start $CONTAINER_ID Or $CONTAINER_NAME
     
   # Remove a container
     docker ps -a
     docker rm $CONTAINER_ID
   
   # Remove all exited containers 
     docker rm $(docker ps -a -q -f status=exited)
     #Or,
     docker container prune
     
   # Remove an image
     docker rmi $IMAGE
     
   2) Web services with Docker
   # Search an image from docker repository
     docker search nginx
   
   # Run nginx container interactively
     docker run -it nginx
     # Type Ctrl-C to exit
   
   # Run nginx in daemon mode and generate ports automatically
     docker run -d -P --name myweb nginx
     docker port myweb
     curl http://localhost:[PORT#], e.g, curl http://localhost:32768
   
   # Specify a port 
     docker run -d -p 8080:80 --name myweb2 nginx
     docker port myweb2
     curl http://localhost:8080
   
   
   3) Transfer files between host and containers
   # Copy a file from the host to a contianer, e.g:
      docker cp /etc/redhat-release myweb:/tmp
      docker exec myweb ls /tmp
      OR,
      docker exec -it myweb sh
      ls /tmp

      Vice versa, 
      docker cp myweb:/etc/motd .
      cat ./motd
      
   4) Migrate a container from one host to another
    # Method A, Export/Import a container
      # Export a container to a tar ball
       docker export myweb > /tmp/myweb-ei.tar
       ls /tmp/myweb-ei.tar

       # Transfer the image tar ball to the destination host, e.g.,
         ##scp /tmp/myweb-ei.tar DEST_HOST:/path/to/somewhere
   
       # Then, create an image by importing from the tar ball
       cat /tmp/myweb-ei.tar | docker import - myweb-ei:v1  # v1 is an tag (or version#) to be added to the image

       # Create a container from the image
       docker run -d -P --name myweb-ei myweb-ei:v1 sleep 300 &
   
       # Run a shell and check the processes running in the container. 
       docker exec -it myweb-ei sh
         # (Here we need to install ps, see below) 
         apt update
         apt install procps
         ps -ef

    # Method B, Save/Load an image
       # Stop a container and save/commit the changes to an image
       docker stop myweb
       docker commit myweb myweb:v1
   
       # Save an image into tar ball file
       docker save -o /tmp/myweb-sl.tar myweb

       # Transfer the image tar ball to the destination host, e.g.,
         ##scp /tmp/myweb-sl.tar DEST_HOST:/path/to/somewhere
   
       # On the destination host, load an image from the saved tarball, 
       docker load -i /tmp/myweb-sl.tar  #load an image from a tar ball
       docker run -d -P --name myweb-sl myweb:v1
       docker port myweb-sl
       curl http://localhost:<port>
   
       # Run a shell and check the processes running in the container. 
       docker exec -it myweb-sl sh
         # (Here we need to install ps, see below) 
         apt update
         apt install procps
         ps -ef
   (Now we can see the difference between mehtod A and B. )
       
   5) Customize and upload an image to the DockerHub
      #If image is not loaded yet
      docker search IMAGE_NAME
      docker pull CONTAINER IMAGE_NAME:TAG
   
      #If image is loaded
      docker images|grep IMAGE_NAME
      
      #Run a container from the image
      docker run -d -P --name CONTAINER IMAGE_NAME:TAG
   
      #Run into the shell with full privilege
      docker exec -it -u root --privileged CONTAINER bash

   
      #Do some changes from inside the contianer, and then,

   
      #Stop the container
      docker stop CONTAINER
   
      #Commit the change with adding a note
      docker commit -m "Enabled something or added something..." CONTAINER REPO_NAME/IMAGE_NAME:NEW_TAG
      
      #Login to docker hub (register at first from hub.docker.com if haven't yet)
      docker login
   
      #Push the image:tag to a repo
      docker push REPO_NAME/IMAGE_NAME:NEW_TAG
 
 


   ```
   


