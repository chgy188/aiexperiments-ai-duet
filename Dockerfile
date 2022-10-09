FROM ubuntu:14.04
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1655A0AB68576280
RUN apt-get update && apt-get install -y \
    pkg-config \
    libpng-dev \
    libjpeg8-dev \
    libfreetype6-dev \
    libblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    gfortran \
    python \
    python-dev \
    python-pip \
    curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - && \
    apt-get install -y nodejs

RUN pip install --upgrade pip
RUN pip install tensorflow
COPY ./server/requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

COPY . /src/

WORKDIR /src/static/
RUN npm install && npm run build

WORKDIR /src/server/

EXPOSE 8080
ENTRYPOINT python server.py
