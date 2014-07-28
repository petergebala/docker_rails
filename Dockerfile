FROM ubuntu
MAINTAINER Piotr Gębala <piotrek.gebala@gmail.com>

ENV RUBY_VERSION 2.1.2
ENV HOME /home/deployer

# Update system
RUN apt-get -y update
RUN apt-get -y upgrade

# Install required libraries
RUN apt-get install -y \
            build-essential \
            git \
            curl \
            zsh \
            vim \
            libpq-dev \
            openssh-server

# Create user with sudo access without password
RUN adduser deployer --home /home/deployer --shell /bin/zsh --disabled-password --gecos "" --ingroup sudo
RUN echo 'deployer ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN service sudo restart
RUN chmod 4755 /usr/bin/sudo

# Prepare for ssh
RUN mkdir /var/run/sshd
RUN echo 'root:toor' |chpasswd
RUN echo 'deployer:depl0yer' |chpasswd
ADD id_rsa.pub /home/deployer/.ssh/authorized_keys
RUN ssh-keygen -t rsa -N "" -f /home/deployer/.ssh/id_rsa

# Copy Gemfile
ADD Gemfile /home/deployer/app/
ADD Gemfile.lock /home/deployer/app/
RUN chown -R deployer:sudo /home/deployer/app/

# Switch user
USER deployer
WORKDIR /home/deployer/app

# Instal RVM with ruby 2.1.2
RUN /bin/bash -c -l "curl -sSL https://get.rvm.io | bash -s stable"
RUN /bin/bash -c -l 'source "/home/deployer/.rvm/scripts/rvm"'
RUN /bin/bash -c -l "rvm requirements"
RUN /bin/bash -c -l "rvm install ruby-$RUBY_VERSION"
RUN /bin/bash -c -l "gem install bundler"

# Install gems from Gemfile
RUN /bin/bash -c -l "bundle install"

# Copy rest of files
USER root
ADD . /home/deployer/app/
RUN chown -R deployer:sudo /home/deployer

EXPOSE 3000
EXPOSE 22

ADD start.sh /home/deployer/
RUN chmod +x /home/deployer/start.sh

CMD ["/home/deployer/start.sh"]
