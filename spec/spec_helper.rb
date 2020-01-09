ENV['RACK_ENV'] = 'test'

#add capybara setup
require 'capybara/rspec'
require 'capybara'
require 'capybara\dsl'
require 'app.rb'
Capybara.app = Takeaway

#add simple cov setup to rspec setup file=>>
require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::Console])
SimpleCov.start

require 'rspec'

RSpec.configure do |config|

 # Use color not only in STDOUT but also in pagers and files
 config.tty = true

 # Use the specified formatter
 config.formatter = :documentation

 config.after(:suite) do
   puts
 end
end
