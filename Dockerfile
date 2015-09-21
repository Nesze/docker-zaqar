FROM fedora 

WORKDIR /root 
RUN echo "fastestmirror=true" >> /etc/dnf/dnf.conf
RUN dnf -v -y install gcc python-devel python-pip libxml2-devel libxslt-devel git
RUN mkdir ~/.zaqar && git clone https://git.openstack.org/openstack/zaqar.git
RUN pip install tox && cd zaqar && tox -e genconfig && cp etc/zaqar.conf.sample ~/.zaqar/zaqar.conf && cp etc/logging.conf.sample ~/.zaqar/logging.conf
RUN cd zaqar && pip install -e .
RUN pip install pymongo

ADD zaqar.config zaqar/zaqar-custom.config

EXPOSE 8888

CMD cd zaqar && zaqar-server -v --config-file zaqar-custom.config
