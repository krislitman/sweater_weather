# Sweater Weather

### Rails API Application

**Find the local forecast for your upcoming Road Trip!**

![giphy](https://media.giphy.com/media/za5xikuRr0OzK/giphy.gif)

## Table of Contents

  - [Author](#author)
  - [Getting Started](#getting-started)
  - [Endpoints](#endpoints)
  - [Runing the tests](#running-the-tests)
  - [Built With](#built-with)
  - [Versioning](#versions)
  - [Acknowledgements](#acknowledgements)

## Author

  - **Kris Litman**<br>
    [GitHub](https://github.com/krislitman)<br>
    [LinkedIn](https://www.linkedin.com/in/kris-litman/)

## Getting Started

### API Keys

Before getting started with installation, you will need to get an API key from
[MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/),
[OpenWeather One Call API](https://openweathermap.org/api/one-call-api),
and [Flickr API](https://www.flickr.com/services/developer/api/).
Please sign up to get your own copy and include them as environment variables with Figaro. 
Run `figaro install` to add your own application.yml file to the application.

### Postman Collection

View the Postman documentation here: [Postman Collection](https://documenter.getpostman.com/view/14824308/TzJybFVw)

### Installing

These instructions will get you up and running with a copy of the project on
your local machine for development and testing purposes.

1. Fork and Clone this repo
2. Install gem packages: `bundle install`
3. Run `rails db:{drop,create,migrate,seed}` -- (you may see errors from pg_restore that you can ignore)
4. Run rails s to start the rails server
5. Enter endpoints (see below) into Postman to see JSON responses!

### Check for security vulnerabilities

Make sure you have run `bundle install` and that the Brakeman gem was successfully installed. 
To see a report run `brakeman -q`

## Endpoints

#### Retrieve weather for a city
**`GET localhost:3000/api/v1/forecast`**
<ul><li>Enter a city and state with a 'location' query parameter, ex: 'Tampa,FL'</li>
<li>Change the units of temperature by including a 'units' parameter, ex: 'metric'</li></ul>
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

#### Background Image for the City
**`GET localhost:3000/api/v1/backgrounds`**
<ul><li>Enter a city and state with a 'location' query parameter, ex: 'Denver,CO'</li></ul>
Example Response:

```{
    "data": {
        "id": "null",
        "type": "image",
        "attributes": {
            "image": {
                "location": "tampa,fl",
                "image_url": "example.com",
                "credit": {
                    "source": "flickr.com",
                    "owner": "hulk hogan"
                }
            }...
```

#### User Registration
**`POST localhost:3000/api/v1/users`**
<ul><li>You will need to send your parameters through the body of the request, ex:</li></ul>

```
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
Example Response:
```
{
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "test@example.com",
            "api_key": "your_api_key"
        }
    }
}
```

#### Login
**`POST localhost:3000/api/v1/sessions`**
<ul><li>You will need to send your parameters through the body of the request, ex:</li></ul>

```
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
}
```
Example Response:
```
{
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "test@example.com",
            "api_key": "your_api_key"
        }
    }
}
```
#### Road Trip
**`POST localhost:3000/api/v1/road_trip`**
<ul><li>You will need to send your parameters through the body of the request, ex:</li></ul>

```
Content-Type: application/json
Accept: application/json

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "your_api_key"
}
```
Example Response:
```
{
    "data": {
        "id": "null",
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Pueblo,CO",
            "travel_time": "01:44:22",
            "weather_at_eta": {
                "temperature": 81.3,
                "conditions": "clear sky"
            }
        }
    }
}
```
#### Destination Tech Salaries
**`GET localhost:3000/api/v1/salaries`**
<ul><li>Enter a city with a 'destination' query parameter for salaries in the tech industry, ex: 'miami'</li>
Example Response:

```
{
    "data": {
        "id": "null",
        "type": "salaries",
        "attributes": {
            "destination": "miami",
            "forecast": {
                "summary": "Broken Clouds",
                "temperature": 83.12
            },
            "salaries": [
                {
                    "title": "Data Scientist",
                    "min": "$72,490.04",
                    "max": "$105,784.61"
                }...
```

## Running the tests 

**Testing with RSpec**
To run the full test suite you will need to run the command:
`bundle exec rspec`

## Built With

- Rails
- PostgreSQL
- Postman
- RSpec
- Capybara
- Fast JSON API
- Faraday
- VCR
- Webmock
- Shoulda Matchers
- Timecop
- Simplecov
- Rubocop
- Brakeman

## Versions

- Ruby 2.5.3

- Rails 5.2.5

## Acknowledgements

- [Giphy](https://giphy.com/) - For the weather batman gif!

- [MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)

- [OpenWeather One Call API](https://openweathermap.org/api/one-call-api)

- [Flickr](https://www.flickr.com/services/developer/api/)

- [Teleport](https://developers.teleport.org/api/)
