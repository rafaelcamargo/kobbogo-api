# Kobbogo API
> An experimental API to dig deeper with Ruby on Rails.

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/rafaelcamargo/kobbogo-api/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/rafaelcamargo/kobbogo-api/tree/master)

## Contributing

1. Install *Ruby 3.x or greater* - Prefer to install Ruby with [Ruby Version Manager](https://rvm.io/).

2. Clone the repo:
``` bash
git git@github.com:rafaelcamargo/kobbogo-api.git
```

3. Go to the project directory
``` bash
cd kobbogo-api
```

4. Install the project dependencies
``` bash
bundle install
```

5. Create and setup databases - *[PostgreSQL](https://www.postgresql.org/) 14.x (server 9.x)* or greater:
``` bash
rails db:create
rails db:migrate
```

6. Serve the API:
``` bash
rails s
```

The API will be running on `http://localhost:3000`.

## Usage

### User Collection

The *User* collection has a single endpoint. The endpoint requires *username* and a *password* to create an user:

| Method | URI    | Request Body | Response Status | Response Body |
|--------|--------|--------------|-----------------|---------------|
| **POST**   | `/users` | {<br>&nbsp;&nbsp;username: String,<br>&nbsp;&nbsp;password: String<br>} | [201](https://www.httpstatuses.org/201) *(Created)* | |

### User Authentication

Authentication has a single endpoint. The endpoint requires user's credentials (*username/password*) and responds with a body containing a *token*, its *expiration date* (i.e. "06-19-2022 21:44"), and *username*:

| Method | URI    | Request Body | Response Status | Response Body |
|--------|--------|--------------|-----------------|---------------|
| **POST**   | `/auth` | {<br>&nbsp;&nbsp;username: String,<br>&nbsp;&nbsp;password: String<br>} | [201](https://www.httpstatuses.org/201) *(Created)* | {<br>&nbsp;&nbsp;token: String,<br>&nbsp;&nbsp;exp: Date,<br>&nbsp;&nbsp;username: String<br>} |

### Todo Collection

The *Todo* collection has three endpoints. All these endpoints need an Authentication token to be sent via request header. The header key must have the name *Authorization* and its value must be the token returned by the endpoint `/auth`.

#### Create

This endpoint requires a *description* to create a todo.

| Method | URI    | Request Body | Response Status | Response Body |
|--------|--------|--------------|-----------------|---------------|
| **POST**   | `/todos` | {<br>&nbsp;&nbsp;description: String,<br>} | [201](https://www.httpstatuses.org/201) *(Created)* | {<br>&nbsp;&nbsp;id: UUID,<br>&nbsp;&nbsp;description: String,<br>&nbsp;&nbsp;created_at: Date,<br>&nbsp;&nbsp;updated_at: Date,<br>} |

#### Retrieve

This endpoint does not requires anything.

| Method | URI    | Request Body | Response Status | Response Body |
|--------|--------|--------------|-----------------|---------------|
| **GET**   | `/todos` |  | [200](https://www.httpstatuses.org/200) *(Ok)* | [{<br>&nbsp;&nbsp;id: UUID,<br>&nbsp;&nbsp;description: String,<br>&nbsp;&nbsp;created_at: Date,<br>&nbsp;&nbsp;updated_at: Date,<br>}] |

#### Delete

This endpoint requires a todo id to be passed on the URI.

| Method | URI    | Request Body | Response Status | Response Body |
|--------|--------|--------------|-----------------|---------------|
| **DELETE**   | `/todos/:id` |  | [200](https://www.httpstatuses.org/200) *(Ok)* | |

## Tests

Ensure that all code that you have added is covered with [automated tests](https://rspec.info/):
``` bash
bundle exec rspec
```
