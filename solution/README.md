# Csvserver application dockerization Assignment

## Prerequisites.

  - Read Docker orientation and setup[Dockergetstarted ](https://docs.docker.com/get-started/ ).

  - Read Docker build and run your image[Buildimage ]( https://docs.docker.com/get-started/part2/).

  - Read Get started with Docker Compose[Dockercompose](https://docs.docker.com/compose/gettingstarted/ ).

  - shellscripting tutorials [shellscripting](https://www.tutorialspoint.com/unix/shell_scripting.htm ).

## Dockerinstallation on your machine:
 
  - Install docker on your machine by using this url [click here](https://docs.docker.com/desktop/install/linux-install/).

  -  After completion of the docker installation follow the below steps for the dockerization of csvserver application.

## Clone the repository

  - First of all you can download or clone the csvserver application to the above csvserver git url.

  - After downloading or cloning the repository you get a `main.zip file` unzip the file by using the below command.
  ~~~
    $ unzip main.zip file 
  ~~~

  - Then you have get a README.md file and `solution` folder,``` cd```  into the `solution` directory.

## PART I

### Pulling required images from dockerhub

  1. First pull the required image to the local repository  by using the below docker command
   ~~~
     docker pull <image name : tag >
   ~~~

  2. In this case we required a ```iammrchetan/csvserver:latest```docker image from docker hub so execute command shown in below

   ~~~
     docker pull iammrchetan/csvserver:latest 
   ~~~

  3. By executing the command```docker images``` you can see the available images in the docker local repository 

### Running a docker image 

  1. If want run a docker image you want execute the following command
   ~~~
     docker run <image name :tag> 
   ~~~

  2. The above command you have not mention any tag docker taking a latest default

  3. When you execute this command the docker daemon first checks the image in local repository,if it is not present in local repository.
 
  4. the demon goes to the dockerhub and pull the image into local repository automatically  and run the container.

  5. In the this case we have already pulled the `iammrchetan/csvserver:latest` image in our local repository.
     so you can execute the following command  shown in below.
 
   ~~~
     docker run iammrchetan/csvserver:latest
   ~~~
### Run in detached mode

  - In our case we have to run the container in detach/background mode so we have to use `-d` tag on docker run command.
   ~~~
     docker run -d iammrchetan/csvserver:latest
   ~~~

  - Tag `-d` runs the container in detached/background mode.

### List the containers

  1. You can check, if the container started or not and list the running containers by using the command 
   ~~~
     docker ps

     CONTAINER ID        IMAGE                        COMMAND                CREATED              STATUS              PORTS               NAMES
   ~~~

  2. It will shows the running containers in the docker engine.But our case container was gone to exited mode so not showed in this list.
 
  3. If you want to see all the available containers like stopped,paused ,and exited containers by adding the tag `-a` or(`--all`) to the above command.
   ~~~
     docker ps -a
   ~~~

  4. In our case `iammrchetan/csvserver:latest` The image created a container but it is not running.

  5. It is in the excited state  that's why it is not shown in the ```docker ps``` command.

  6. so we have to use another command ```docker ps -a``` it will shows the all containers in the docker engine. 

![image](https://github.com/anilgitpractice/docker_assig/assets/97168620/4316dd0f-5486-455e-a575-e93971c6e53b)

### Docker logs

  -  `iammrchetan/csvserver:latest` The image created a container but is in an exited state. So we have to know the reason for this error

  -  If we want find out the reason/error by checking the logs by using the following docker command 
   ~~~
     docker logs <containerID>
   ~~~
![image](https://github.com/anilgitpractice/docker_assig/assets/97168620/7abcfb08-0daf-4806-8422-2acfc6e9275a)

  -  It is showing a reason for the error it requires a  input data from the host /source to the container.

  -  In our assignment we have to create the input data by using shellscript.

### Shellscripting

  1. In our task we have to create the input data to the container by using the `gencsv.sh` to write a script for generating a file named `inputFile`inside of this file to generate comma separated values with index and random numbers.
   ```
     $ cat inputFile
     1,2057
     2,2057
     3,2057
   ``` 

  2. For creating the gencsv.sh shell script first  create a file name gencsv.sh by using the
   ~~~
     $ touch gencsv.sh
     $ cat > gencsv.sh
     $ vi gencsv.sh
   ~~~

  3. After writing the shell script, run the shell script file by using the commands ```./gencsv.sh 2 8``` or ```sh gencsv.sh 2 8```

  4. It will generates the  inputFile and ten entries  comma separated values with index and random numbers

  5. Now you can give the source path to docker run command where the inputFile is generated and destination path it is shown in `error logs`. 
 
  6. After generating an inputFile, again run the container by passing the data using volumes tag `-v`using the command.
### Docker volumes

  -  Creates a new volume that containers can consume and store data in. If a name is not specified, Docker generates a random name [click here](https://docs.docker.com/engine/reference/commandline/volume_create/) more info.

  -  So you can pass the input data by using the volume tag`-v`into the docker run command.
   ~~~
     docker  run -d  -v source path:destination path <image name:tag>
   ~~~

  -  After running the docker run command shown in below. The container will running in background mode so you can execute the command `docker ps`.you can see the running container
  ``` 
   docker run -d -v ./inputFile:/csvserver/inputdata iammrchetan/csvserver:latest

  ```
![image](https://github.com/anilgitpractice/docker_assig/assets/97168620/bf8c0d92-7186-4ba2-9132-1ea8e5b5b848)

### Docker exec
  -  The `docker exec`command runs a new command in a running container. [click here](https://docs.docker.com/engine/reference/commandline/exec/). more info
 
  -  After running the container we have to Get shell access to the container and find the port. on which port  application is listening.

  -  If you want to execute the commands on a running container by using the following docker command 
   ~~~
     docker exec [OPTIONS] CONTAINER_ID command to pass 
   ~~~
 
  - In this `-it` means the interactive mode

  - Command to pass means which command to pass inside of a container 

  - In our case we used the following command to access the shell inside of a container 
   ~~~
    docker exec -it < container ID> /bin/bash
   ~~~
![image](https://github.com/anilgitpractice/docker_assig/assets/97168620/e8e0e220-c1b2-480c-a76e-9135fce965ae)

### Network Statistics Tool

  - Getting inside of a container you want to see the port on which the application is listing by using the linux command inside of a container tha is [click here](https://www.geeksforgeeks.org/netstat-command-linux/).more details.
   ```
    netstst -nltp
   ```

  - It will shows the active listing ports inside of a container  and process id and the state of the process 

  - In our case it showing `9300/tcp` port in the state is listing 

### Docker inspect

  - Docker inspect provides detailed information on constructs controlled by Docker

  - If you want to see the host port of a  container lets execute a docker command 
  ~~~
    docker inspect <container ID>
     
    docker inspect <imageID>
  ~~~

  - When we execute`docker inspect` command it render the results in the json arry 

  - You can check the  exposed port and host port in the network section 

  - In our task it shows this ports shown in below

![image](https://github.com/anilgitpractice/attempt1/assets/97168620/ea82f5d4-c568-497b-a9e6-7d61271f0926)

### Docker stop or remove a container

  - These commands used for stop running container and removes the container
 
  - Once we knowing about the ports stop/delete the container 
  ```
    docker stop <containerID>
    docker  rm < containerID>
  ```

### Publish a container's port(s) to the host
 
  - Port mapping used for creating a conection or exposing a container out side of the world

  - In this port mapping we are used `-p` tag and hostport and container port pass to the docker run command.
   ```
    docker run -p hostport:container port <image name:tag> 
   ```
  - By using the `netstat -nltp` command we are seend which application is  in a listing state inside of a container.

  - Now we have to expose our container to the outside world(web accessing) so we have to do port mapping.

  - In our task we observed two ports one is container port `9300/tcp` and host port `9393` So we have to mapping this ports in a docker run command by using the`-p` tag shown below.
  ~~~
   docker run -d -p 9393:9300 -v ./inputFile:/csvserver/inputdata iammrchetan/csvserver:latest
  ~~~

  - Now the container will be started. We have to access this in a web page. 

  - The application is accessible on the host at http://localhost:9393.

  - The output look like this 

![image](https://github.com/anilgitpractice/docker_assig/assets/97168620/dec8872e-1cc3-4861-b720-f7b1e6255468)

> It is successfully accessing the web and showing some data in the web page.

### Set environment variables

  - Our application requirements we have to set the  environmental variable to the container by executing the docker command.
 
  - So we have to pass environment variables to the docker run command by using the  **--env** or **-e environment variable name=value** 
   ~~~
    docker run -e environment_varible=false <image name:tag>
   ~~~

  - In our case they provide one environment variable named.`CSVSERVER_BORDER` to have the value of `Orange` So we have to execute docker run command like shown below
  ~~~
    docker run -d -p 9393:9300 -e CSVSERVER_BORDER=Orange -v ./inputFile:/csvserver/inputdata iammrchetan/csvserver:latest
  ~~~

  - In the web page we have seen a difference in welcome note should have an orange color border.

![image](https://github.com/anilgitpractice/docker_assig/assets/97168620/cdc788d2-ef5e-402d-85ee-7cc344f69388)

> So we successfully dockerized our csvserver application :whale:
 
---------

## PART II

> In this section writing a docker compose file for set up from Part I and running csvserver application.

## Docker compose

 - Compose is a tool for defining and running multi-container Docker applications.

 - With Compose, you use a YAML file to configure your application’s services.

 - Then, with a single command, you create and start all the services from your configuration.

 - More details about docker compose [click here](https://docs.docker.com/compose/gettingstarted/)

 - If you want know about the yaml formatting [click here](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html)

 - Docker compose installation [ click here](https://docs.docker.com/compose/install/linux/#install-using-the-repository).

### writing docker compose file for part I

 - First  create one file named `docker-compose.yml` with a yml extension, For csvserver application 
 
 - Write a docker compose file and pass arguments and values .

 - Define the services in the docker compose file it looks likes below.

  ```
 version: '2'
 services:
   csvserver:
     image: iammrchetan/csvserver:latest
     ports:
       - "9393:9300"
     volumes:
       - "./inputFile:/csvserver/inputdata"
     environment:
       - CSVSERVER_BORDER=Orange
   ```

  - Part I instructions are described in above `docker-compose.yml` file 

  - Now up/run the `dockercompose.yml` with `docker compose up`command with `-d` for running background mode it shown like below

  ```
  docker compose up -d
  ```
  - The application is accessible on the host at http://localhost:9393
                    
  - Use `docker compose down` command for stopping the container.


## Part III
 
 - In this section we are monitoring the csvserver by using the Prometheus.
 
### Prometheus
 
 - Prometheus is a free software application used for event monitoring and alerting. It records real-time metrics in a time series database built using a HTTP pull model, with flexible queries and real-time alerting
 
### Solution 
 
 - Delete any containers running from the last part.
 
 - For prometheus configuration [clickhere](https://prometheus.io/docs/prometheus/latest/getting_started/).
 
 - Create a `prometheus.yml` file and write the configuration for prometheus.
```
scrape_configs:
- job_name: 'prometheus'
  static_configs:
  - targets: ['localhost:9090']
- job_name: 'csvserver_records '
  static_configs:
  - targets: ['localhost:9393']
```

 - For `prometheus.yml` file [clickhere](https://github.com/anilgitpractice/docker_assig/blob/main/solution/prometheus.yml).
 
 - Add Prometheus container (`prom/prometheus:v2.22.0`) to the `docker-compose.yaml` form part II.
```
version: '2'
services:
  csvserver:
    image: iammrchetan/csvserver:latest
    ports:
      - "9393:9300"
    volumes:
      - ./inputFile:/csvserver/inputdata
    environment:
      - CSVSERVER_BORDER=Orange
  prometheus:
    image: prom/prometheus:v2.22.0
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
```

 - For the `docker compose.yml` file [clickhere](https://github.com/anilgitpractice/docker_assig/blob/main/solution/docker-compose.yml). 
 
 - Check the port by inspecting `prom/prometheus:v2.22.0` image by using `docker inspect prom/prometheus:v2.22.0` shown below
 
![image](https://github.com/anilgitpractice/attempt1/assets/97168620/6143c5b9-a2d9-43b0-a282-f79311138888)
 
 - Run the `docker compose up -d` command to up the `docker-compse.yml` file.

 - Check the status of the docker containers by using the `docker ps` command for listing the running containers.

 
> **Note** if you use vm's the localhost will be replaced by your vm's ip address . in this case my vm's ip is http://192.168.1.4 .while reading the document please remember this.
### Web accessing metrics data
 - Accessing csvserver metric data by using the http://localhost:9393/metrics  i used vm so i can use the vm ip address `http:192.168.1.4:9393/metrics`
in this case we are providing the csvserver port number for accessing the metric data 
 
![image](https://github.com/anilgitpractice/docker_assig/assets/97168620/97fa3d36-4d38-47ad-b093-84e317bab2e0)
 
### Accessing prometheus
 
 - Make sure that Prometheus is accessible at http://localhost:9090 on the host. in our case vm's ip address (http://192.168.1.4:9090)
 In this case we are using the prometheus port number.
 
 - Once the home page is accessed, type `csvserver_records` in the query box of Prometheus.
 
 - Click on Execute and then switch to the Graph tab.  
 
 - The Prometheus instance should be accessible at http://localhost:9090, (if we use vm the localhost can be replaced by vm's ip address)  and it should show a straight line graph with value 7(consider shrinking the time range to 5m).
 
![image](https://github.com/anilgitpractice/docker_assig/assets/97168620/73dfde95-c14a-4737-97ca-9a7aad4a48af)
 
 - The csvserver application dockerization assignment completed successfully :sweat_smile:

