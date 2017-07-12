FROM node:8
MAINTAINER Jeff Dickey <jeff@heroku.com>

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN apt-get -y update && \
  apt-get install -y --no-install-recommends \
  apt-utils \
  ocaml libelf-dev \
  ruby ruby-dev \
  python-pip python-dev build-essential \
  p7zip-full \
  locales \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN locale-gen

RUN pip install --upgrade pip && \
      pip install --upgrade virtualenv && \
      pip install --upgrade awscli && \
      gem install devcenter

RUN wget https://cli-assets.heroku.com/osslsigncode-1.7.1.tar.gz && \
    tar -xvzf osslsigncode-1.7.1.tar.gz && \
    cd osslsigncode-1.7.1 && \
    ./configure && \
    make && \
    make install

RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/n/nsis/nsis-common_2.51-1_all.deb && \
    dpkg -i nsis-common_2.51-1_all.deb

RUN aws configure set preview.cloudfront true

ENV PATH="${PATH}:./node_modules/.bin"

CMD bash
