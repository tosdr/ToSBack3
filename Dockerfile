FROM debian:stretch-slim

RUN apt-get update

RUN apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev git-core

RUN apt-get install -y bash vim libssl-dev sqlite3 libsqlite3-dev default-libmysqlclient-dev curl wget

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv

RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc

RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc

RUN apt-get install -y bundler nodejs

RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

COPY . /root/tosback3
COPY run.sh /root

WORKDIR /root

RUN git clone https://github.com/tosdr/tosback2.git

WORKDIR /root/tosback3

RUN bundle install

