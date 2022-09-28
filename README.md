# README

<h1 align="center">Sweater Weather</h1>

<!-- TABLE OF CONTENTS -->
  <details>
  <summary>Table of Contents</summary>
  <ol>
    </li>
    <li><a href="#project-overview">Project Overview</a></li>
    <li><a href="#built-with">Built With</a></li>
    <li><a href="#setup">Setup</a></li>
    <li><a href="#api-endpoints">API Endpoints</a></li>
  </ol>
</details>

<!-- PROJECT OVERVIEW -->
## Project Overview
Sweater-Weather is part of a Service-Oriented Architecture (SOA) application for the back-end that exposes several API endpoints. The data exposed shows forecasts for a certain area, and also allows you to find the weather at your end destination that is accurate to your time of arrival. A front-end client can hit multiple endpoints, and get a JSON response from these endpointds. Two different third party APIs were consumed to build the endpoints and return formatted data. 

<!-- Built With -->
## Built With
[<img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white"/>](https://www.ruby-lang.org/en/) **Version 2.7.4**<br>
[<img src="https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white"/>](https://rubyonrails.org/) **Version 5.2.8**<br>

<!-- Setup -->
## Setup
To set up the project on your local machine, complete the following steps:<br>

1. Make sure you have the correct versions of both Ruby(2.7.4 or later) and Rails(5.2.8 or later) by running `ruby -v` and `rails -v` from your command line.
2. Register for a free API key [here](https://developer.mapquest.com/documentation/geocoding-api/) and [here](https://openweathermap.org/api/one-call-api).
3. Clone the repo:
```git clone git@github.com:gwen-marina/sweater-weather.git``` &mdash; for SSH
4. Install the following gems using `bundle install`:
```ruby
#global
gem 'bcrypt', '~> 3.1.7'
gem 'figaro'
gem 'faraday'

#section
group :development, :test
  gem 'rspec-rails'
  gem 'pry'
  gem 'shoulda-matchers'
  gem 'simplecov'

#section
group :test
  gem 'webmock'
  gem 'vcr'
```
5. Configure the API key by first running `bundle exec figaro install` in your command line and then configure your API key in your `application.yml` file:
```ruby
mapquest_api_key: your_key_here
open_weather_api_key: your_key_here
```

<!-- API Endpoints -->
## API Endpoints
GET /api/v1/forecast?location={insert location here i.e vail,az}
This endpoint returns the current weather, hourly weather, and daily weather (for the next 5 days)

*It is recommended to use Postman for these endpoints:[<img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white"/>](https://www.postman.com/product/what-is-postman/)<br>

To call these endpoints in Postman, click on “Body”, select “raw”, which will show a dropdown that says “Text” in it, choose “JSON” from the list and enter the parameters as shown:

<p> GET /api/v1/forecast?location </p>
<img width="844" alt="location" src="https://raw.githubusercontent.com/gwen-marina/sweater-weather/main/read_me_images/location.png">

<p> POST /api/v1/users </p>
<img width="844" alt="users" src="https://raw.githubusercontent.com/gwen-marina/sweater-weather/main/read_me_images/user.png">

<p> POST /api/v1/sessions </p>
<img width="847" alt="sessions" src="https://raw.githubusercontent.com/gwen-marina/sweater-weather/main/read_me_images/sessions.png">

<p> POST /api/v1/roadtrip </p>
<p> *In order to use this endpoint, a POST request must first be sent to users in order to create a user and obtain an api_key </p>
<img width="847" alt="roadtrip" src="https://raw.githubusercontent.com/gwen-marina/sweater-weather/main/read_me_images/roadtrip.png">