FROM swift:3.1

RUN apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y install libpq-dev pkg-config && \
  mkdir -p /var/www/todo-moonshot

WORKDIR /var/www/todo-moonshot

ADD Package.swift Package.swift
RUN swift package fetch

ADD Sources Sources
RUN swift build --configuration release

EXPOSE 8088

ENTRYPOINT ["./.build/release/todo-moonshot"]


