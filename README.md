## petergebala/docker_rails

Basic structure of Dockerfile for rails app.
[Docker repository page] (https://registry.hub.docker.com/u/petergebala/docker_rails).

#### It does:

- create user deployer
- install ruby via rvm
- add files to container and runs bundle install

#### Instalation

1. Download Dockerfile to your rails application (main dir) or run: `docker pull petergebala/docker_rails`
2. Modify what you need ex: ruby version
3. Build container: `docker build -t petergebala/docker_rails .`
4. Build other containers if you need ex: postgres
5. Attach to container and link other containers if you need to: `docker run -i -t petergebala/docker_rails /bin/bash -l`. 
   Inside container do what you need like run server, execute rake tasks, run tests. In repository modify the code which is sync with container.
