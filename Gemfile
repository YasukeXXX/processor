source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bcrypt'
gem 'coffee-rails', '~> 4.2'
gem 'haml-rails'
gem 'jbuilder', '~> 2.5'
gem 'listen', '>= 3.0.5', '< 3.2'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.1'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'sshkit', '1.9.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'factory_girl_rails', require: false        
  gem 'haml-lint', require: false
  gem 'pry-rails'
  gem 'rspec-rails'                                                                               
  gem 'rubocop', require: false 
  gem 'selenium-webdriver', '3.4.3'
  gem 'sqlite3'
end

group :development do
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
  gem 'erb2haml'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end 

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
