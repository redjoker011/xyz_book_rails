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
