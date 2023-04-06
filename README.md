# XYZ Book Application(WIP)

# Pre-requisites

- Ruby 2.7.6
- Rails 5.2.8.1
- SQLite3

# Installation

## ruby & bundle
    ```
      > ruby -v
      ruby 2.7.6p219

      > bundle install

      > rails s -p 3000 -b 0.0.0.0
    ```

## database
    ```
      # copy database.yml.example as database.yml
      > cp config/database.yml.example config/database.yml

      > rails db:create
      > rails db:migrate
      > rails db:seed
    ```

# Docker

  Run the command using docker compose to start the application
  
  ```
    > docker compose up
  ```

  Check the container name

  ```
    > docker ps
  ```

  Access the container and setup database(for fresh install only)

  ```
  > exec -it xyz_books_web-1 bash
  > rails db:create
  > rails db:migrate
  > rails db:seed
  ```

  You can access the application at `http://localhost:3000`


# API

## Available API's

### `/v1/books/{:id}`
  - Parameter
    - id -> Valid 13 Digit ISBN
  - Response
    - 200 -> Success Request
    - 400 -> Invalid ISBN
    - 404 -> ISBN Not Found
  - Sample
  ```
  > curl  "localhost:3000/api/v1/books/978-1-891830-85-3/" | jq
  {
    "id": 1,
    "title": "American Elf",
    "price": "1000.0",
    "publisher": "Paste Magazine",
    "authors": "Joel  HartseHannah P. Templer, Marguerite Z. Duras"
  }
  ```

### `/v1/books/{:id}/convert-isnb`
  - Parameter
    - id -> Valid 13 Digit ISBN
  - Response
    - 200 -> Success Request
    - 400 -> Invalid ISBN
  - Sample
  ```
  ❯ curl  "localhost:3000/api/v1/books/978-1-891830-85-3/convert-isbn" | jq
  {
    "isbn_ten": "1-891-83085-6",
    "isbn_thirteen": "978-1-891830-85-3"
  }
  ```
