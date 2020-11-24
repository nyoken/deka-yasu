# ベースとなるDocker Imageをruby:2.7に指定
FROM ruby:2.7.0
# nodejs、postgresql-client、yarn、chromium-driverのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y vim nodejs postgresql-client yarn chromium-driver
# Docker内にmyappディレクトリを作成し、Dockerfileでのコマンド実行時の基準にmyappを指定
RUN mkdir /app
WORKDIR /app
# Docker内のmyappディレクトリにホストのGemfile、Gemfile.lockをコピーし、Gemを読み込んでアプリ全体もコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /app
# 特定のserver.pidファイルが存在するときにサーバーが再起動しないようにする問題を修正
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
