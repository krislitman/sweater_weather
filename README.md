# Sweater Weather

Rails API Application

![giphy](https://media.giphy.com/media/za5xikuRr0OzK/giphy.gif)

## Table of Contents

  - [Author](#author)
  - [Getting Started](#getting-started)
  - [Overview](#overview)
  - [Endpoints](#endpoints)
  - [Runing the tests](#running-the-tests)
  - [Built With](#built-with)
  - [Versioning](#versioning)
  - [Acknowledgements](#acknowledgements)

## Author

  - **Kris Litman**<br>
    [GitHub](https://github.com/krislitman)<br>
    [LinkedIn](https://www.linkedin.com/in/kris-litman/)

## Getting Started

### API Keys

Before getting started with installation, you will need to get an API key from both 
[MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/) 
and [OpenWeather One Call API](https://openweathermap.org/api/one-call-api). 
Please get your own copy and include them as environment variables with Figaro. 
Run `figaro install` to add the application.yml file to your copy of the application.

### Installing

These instructions will get you up and running with a copy of the project on
your local machine for development and testing purposes.

1. Fork and Clone this repo
2. Install gem packages: `bundle install`
3. Run `rails db:{drop,create,migrate,seed}` -- (you may see errors from pg_restore that you can ignore)
4. Run rails s to start the rails server
5. Enter endpoints (see below) into Postman to see JSON responses!

## Overview

### Database Schema
  
## Endpoints

##### Retrieve weather for a city!
**`GET localhost:3000/api/v1/forecast`**
<ul><li>Enter a city and state with a **location** query parameter, ex: 'Tampa,FL'</li></ul>
Example Response:

```{
    "data": {
        "id": "null",
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-04-24T12:08:35.000-04:00",
                "sunrise": "2021-04-24T06:55:42.000-04:00",
                "sunset": "2021-04-24T19:59:47.000-04:00",
                "temperature": 83.16,
                etc...
            }
        }...
```

##### Background Image for the City!
**`GET localhost:3000/api/v1/backgrounds`**
<ul><li>Enter a city and state with a **location** query parameter, ex: 'Denver,CO'</li></ul>

## Running the tests 

To run the full test suite you will need to run the command:
`bundle exec rspec`

## Built With

- Rails
- PostgreSQL
- RSpec
- Capybara
- Fast JsonAPI
- Faraday
- VCR
- Rubocop
- Simplecov

## Versions

- Ruby 2.5.3

- Rails 5.2.5

## Acknowledgements

- [Giphy](https://giphy.com/) - For the weather batman gif!
- [MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)
- [OpenWeather One Call API](https://openweathermap.org/api/one-call-api)
