FROM ubuntu:18.04

RUN apt-get update && apt-get install -y curl
#install nodejs
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - 
RUN apt-get install -y nodejs

# allow running "sudo .." in ubuntu user
RUN apt-get update && apt-get install -y sudo
# sudo without pass
RUN echo '5greplay ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#add 
RUN useradd -rm -d /home/5greplay -s /bin/bash -g root -G sudo -u 1000 5greplay

# Switch to 'montimage' user
USER 5greplay
WORKDIR /home/5greplay


RUN sudo npm -g config set user root
RUN sudo npm install -g terminalizer


RUN mkdir /home/5greplay/.terminalizer
COPY config.yml /home/5greplay/.terminalizer

#active bash color
ENV TERM xterm-256color

# does not work: somehow PS1 is overriden
ENV PS1 '${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@montimage\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
RUN echo "PS1='$PS1'" >> /home/5greplay/.bashrc

# remember 2 commands to start and replay a record
RUN echo 'terminalizer play demo\nterminalizer record demo' >> /home/5greplay/.bash_history

# Start the process
CMD ["bash", "-l"]

