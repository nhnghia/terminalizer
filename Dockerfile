FROM node:latest

RUN npm install -g terminalizer

# allow running "sudo .." in node user
RUN apt-get update && apt-get install -y sudo
# sudo without pass
RUN echo '%node ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to 'montimage' user
USER node
WORKDIR /home/node

RUN mkdir /home/node/.terminalizer
COPY config.yml /home/node/.terminalizer

#active bash color
ENV TERM xterm-256color

# does not work: somehow PS1 is overriden
ENV PS1 '${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@montimage\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
RUN echo "PS1='$PS1'" >> /home/node/.bashrc

# remember 2 commands to start and replay a record
RUN echo 'terminalizer play demo\nterminalizer record demo' >> /home/node/.bash_history

# Start the process
CMD ["bash", "-l"]

