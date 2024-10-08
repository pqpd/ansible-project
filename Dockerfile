FROM ubuntu:24.04

RUN apt-get update && \
 apt-get install -y openssh-server && \
 apt-get install -y sudo

RUN echo 'ubuntu:1234' | chpasswd
RUN usermod -aG sudo ubuntu
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

COPY test.pub /home/ubuntu/.ssh/authorized_keys
RUN mkdir /var/run/sshd

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
