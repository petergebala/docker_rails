FROM ubuntu
MAINTAINER Piotr Gębala <piotrek.gebala@gmail.com>

# Update system
RUN apt-get update
RUN apt-get -y upgrade

# Install required libraries
RUN apt-get install -y \
            build-essential \
            git \
            curl \
            zsh \
            vim

RUN chsh -s /bin/zsh

# Install newest ruby via RVM
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -c -l 'source /etc/profile.d/rvm.sh'
RUN /bin/bash -c -l 'rvm requirements'
RUN /bin/bash -c -l 'rvm install ruby-2.1.2'
RUN /bin/bash -c -l 'gem install bundler'
