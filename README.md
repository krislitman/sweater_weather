# Sweater Weather

Rails API Application

## Table of Contents

  - [Author](#author)
  - [Getting Started](#getting-started)
  - [Runing the tests](#running-the-tests)
  - [Built With](#built-with)
  - [Versioning](#versioning)

## Author

  - **Kris Litman**<br>
    [GitHub](https://github.com/krislitman)<br>
    [LinkedIn](https://www.linkedin.com/in/kris-litman/)

## Getting Started

### Installing

These instructions will get you up and running with a copy of the project on
your local machine for development and testing purposes.

1. Fork and Clone this repo
2. Install gem packages: `bundle install`
3. Run `rails db:{drop,create,migrate,seed}` -- (you may see errors from pg_restore that you can ignore)
4. Run rails s to start the rails server
5. Enter the endpoints into Postman to see JSON responses!

## Overview

### Database Schema
  
### Endpoints

##### Retrieve weather for a city!
`GET localhost:3000/api/v1/forecast`
<ul><li>Enter a city and state with a `location` query parameter</li></ul>

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
