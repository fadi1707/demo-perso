### Demo Repo

#### This repo contains 3 Elements
1. At root level spring-boot `serving-web-content` project ( [tutorial](https://spring.io/guides/gs/serving-web-content/) ) 
    - Maven project - build using `mvn clean package`
    - Dockerfile - Packaging this project in Image  
    - Jenkinsfile - CI/CD for this project  

2. deployment folder 
    - containing ansible(v2.9) playbook and 2 roles to deploy the serving-web-content 
      project docker image to a server

3. Jenkins-Master folder - empty
    - Jenkins master configurations files and playbooks to spin up Jenkins Master
    
#### Status
1. serving-web-content project is building successfully.
2. The serving-web-content Project Image is also builds correctly and tested locally. 
3. Jenkinsfile was tested in a previous environment which has been compromised

* Jenkinsfile needs to allow 

Currently, the original Jenkins master is not safe to run the build 
 
#### Your mission, should  you choose to accept it
1. Create a new Jenkins master as a docker image
    - Script & playbooks & files should be reused for  
      deployment in a different environment
    - You get paid ***extra*** for automating Jenkins plugins and 
      configuration for installation (ansible/bash preferred 
      but can be any other script you're familiar with)
2. Run the Jenkinsfile 
    - Connect the Jenkins to a git VCS (i.e. GitHub/bitbucket/gitlab 
      all has free account capacity) 
    - Use webhook for each commit push (no polling) 
    - Use jenkins credentials when needed (someone always hacking)
3. SMTP - ***Optional***
    - Enable smtp mailing for post stage

##### Resources:
***In the Jenkins-Master folder***
1. jkey - the private key for servers connect with default ec2 user
2. ips - list of ips to use with the key one for Jenkins and one for deployment

###### Notice!!
> Since there are problems with running docker in docker - [you can read about it here](https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/)
> Use the following host mounts in your docker configuration 
> (it’s simpler than jenkins.io installation guide)
> 
```yaml
  - /var/run/docker.sock:/var/run/docker.sock
  - /usr/local/bin/docker:/usr/local/bin/docker
```
> Make sure the runtime user and group has docker socket permissions 


### Delivery
#### Send us back a zip with your changes and a readme with all prerequisites and action/scripts needed to redeploy it on a clean env
### The environment will self-destruct at ...
