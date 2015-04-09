# PuppyLove App

This Application is built on Rails 4.1.8, Ruby version 2.1.3.  You can see this application live at puppyplaydate.co.

We used Rest Client and Nokogiri for webscraping for dog park information.  We created a rake task to perform this web scraping and seed the database.  The rake task can be completed with:
rake scrape:parks

The Application has a custom mapping feature to display these dog parks, it connects to Google Geocoder API, used the geocode gem, and Mapbox API.

The app also has a live messaging component.  We used EventMachine Websocket.  We're using em-websocket gem and thin.  Thin takes over as the http server instead of the Rails' default Webrick.  

For the test suite:
gem "capybara"
gem 'launchy'
gem 'rspec-rails'
gem 'spring'
gem 'pry'
gem 'better_errors'
gem 'binding_of_caller'
gem 'selenium-webdriver'

Run tests with rspec spec

The database is postgresql.

This app is currently deployed on an AWS EC2 Instance Ubuntu 14.04.
