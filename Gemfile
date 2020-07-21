source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

group :test do
  gem 'rspec', require: false
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end

group :development do
  gem 'rubocop', require: false
end
gem 'byebug', '~> 11.1', groups: %i[development test]
