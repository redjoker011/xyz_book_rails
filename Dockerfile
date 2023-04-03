FROM ruby:2.7.6
RUN apt-get update -qq && apt-get install -y build-essential nodejs git vim && rm -rf /var/lib/apt/lists/*
WORKDIR /xyz_books

COPY Gemfile /xyz_books/Gemfile
COPY Gemfile.lock /xyz_books/Gemfile.lock

RUN bundle install

COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
