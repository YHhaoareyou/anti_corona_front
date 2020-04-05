# Anti-Corona Front

[Website link](http://anti-corona-front.herokuapp.com)  
A simple platform for people to share information of disease prevention supplies they want to exchange as well as contact information to people in the same country.  
Users can make posts of what supplies they need, what supplies they can offer, time and place to exchange.  
Users can also filter and look for posts suiting their demand, and obtain contact information of whom they want to exchange with.

### Motivation

Due to the worldwide severe situation caused by COVID-19, there must be people lack of or hoarding too many supplies such as masks or sanitizer.  
Hope this website can help the supplies be distributes more fairly to those in need, and keep people in connection with each other.  

### Language support (the only languages I understand)
Languages automatically switches according to user's location.  
* Japanese for Japan
* Traditional Chinese for Taiwan, Hong Kong and Macao
* Simplified Chinese for China
* English for the rest of the world

### Where is the site deployed?

Heroku with ClearDB addon as the database

### Dependencies

* Ruby 2.7.0
* Bundler 2.1.4
* Rails 6.0.2.2
* mysql 5.7

### Setup

1. Get the dependencies installed
2. Clone this repository
3. Run `bundle install`
4. Run `bundle exec rake db:schema:load` to create the database and tables
5. Run `bundle exec rails s`
