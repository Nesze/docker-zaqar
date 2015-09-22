FROM fedora 

WORKDIR /root 
RUN echo "fastestmirror=true" >> /etc/dnf/dnf.conf
RUN dnf -v -y install gcc python-devel python-pip libxml2-devel libxslt-devel git
RUN mkdir ~/.zaqar && git clone https://git.openstack.org/openstack/zaqar.git
RUN pip install pymongo tox && cd zaqar && tox -e genconfig && cp etc/zaqar.conf.sample ~/.zaqar/zaqar.conf && cp etc/logging.conf.sample ~/.zaqar/logging.conf
RUN pip install -e zaqar

ADD zaqar.config zaqar/zaqar.config
ADD run.sh zaqar/run.sh

WORKDIR /root/zaqar
CMD ./run.sh $MONGO
