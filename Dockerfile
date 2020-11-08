# ベースとなるDocker Imageをruby:2.7に指定
FROM ruby:2.7.0
# nodejs、postgresql-client、yarn、chromium-driverのインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn chromium-driver
# Docker内にmyappディレクトリを作成し、Dockerfileでのコマンド実行時の基準にmyappを指定
RUN mkdir /myapp
WORKDIR /myapp
# Docker内のmyappディレクトリにホストのGemfile、Gemfile.lockをコピーし、Gemを読み込んでアプリ全体もコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /myapp
# 特定のserver.pidファイルが存在するときにサーバーが再起動しないようにする問題を修正
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# コンテナ起動時に使用するポートを定義
EXPOSE 3000
# Docker起動時にデフォルトで実行されるコマンドを定義
CMD ["rails", "server", "-b", "0.0.0.0"]
