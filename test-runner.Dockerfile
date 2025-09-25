FROM ruby:3.3

WORKDIR /tests

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

COPY . .

CMD ["tail", "-f", "/dev/null"]
