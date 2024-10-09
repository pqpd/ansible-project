FROM ubuntu:24.04

RUN apt-get update && \
 apt-get install -y openssh-server && \
 apt-get install -y sudo && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/*

RUN usermod -aG sudo ubuntu

COPY test.pub /home/ubuntu/.ssh/authorized_keys
RUN mkdir /var/run/sshd

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
