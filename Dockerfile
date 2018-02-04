FROM ubuntu:latest

RUN apt-get update \ 
	&& apt-get upgrade -y -qq \
	&& apt-get install -y \
	python \
	locales \
	python-dev \ 
	openssl \
	apt-utils \
	build-essential \
	fakeroot \
	dpkg-dev \
	libcurl4-openssl-dev \
	python-setuptools \
	python-requests \
	python-pycurl \
	python-crypto \
	python-imaging \
	python-pyxmpp \
	python-jinja2 \
	python-thrift \
	python-feedparser \
	python-beautifulsoup \
	python-pip \
	tesseract-ocr \
	python-beaker \
	python-simplejson \
	python-openssl \
	wget \
	unrar \
	gocr \
	python-django \
	git \
	wget \
	rhino \
	gosu \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 
	
RUN wget -q https://bootstrap.pypa.io/get-pip.py \
	&& python get-pip.py \
	&& pip install Send2Trash \
	&& pip install pycrypto

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV PYCURL_SSL_LIBRARY openssl

RUN git clone https://github.com/pyload/pyload.git /opt/pyload \
        && cd /opt/pyload \
        && git checkout stable \
        && echo "/opt/pyload/pyload-config" > /opt/pyload/module/config/configdir

ADD pyload-config/ /tmp/pyload-config
ADD run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 8000
VOLUME "/opt/pyload/pyload-config"
VOLUME "/opt/pyload/Downloads"

CMD ["/run.sh"]