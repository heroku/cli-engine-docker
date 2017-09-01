FROM node:8.4

MAINTAINER Jeff Dickey

RUN apt-get -y update && \
  apt-get install -y --no-install-recommends \
  apt-utils \
  python-dev \
  && \
  curl https://bootstrap.pypa.io/get-pip.py | python && \
  pip install awscli --upgrade && \
  aws configure set preview.cloudfront true && \
  apt-get remove -y python-dev && \
  apt-get clean && apt-get -y autoremove && \
  rm -rf /var/lib/apt/lists/* ~/.cache

ENV PATH="${PATH}:./node_modules/.bin"

CMD bash
