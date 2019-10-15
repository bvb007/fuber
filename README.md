# Fuber

## Install

### Clone the repository

```shell
git clone https://github.com/bvb007/fuber.git
cd project
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.5.1`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.5.1
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundle)
Using [Rspec](https://rspec.info/)
Using [Mongodb](https://www.mongodb.com/)

Generate the mongodb config
```shell
rails g mongoid:config
```

```shell
bundle install
```

## Serve

```shell
rails s
```

## Test

```shell
bundle exec rspec
```
## API DOC

### Booking a cab
This API will look for available cabs and get the nearest cab based on location and color preferences. 

### Request

```http
POST /api/v1/book-cab
```

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `user_location` | `Array` | **Required**. Users location in [latitude, longitude] |
| `preferred_color` | `String` | **Optional**. Users preferred color |

### Response

```javascript
{
  "status" : string <success/failure>,
  "message" : string <success or failure message>,
  "data"    : { "cab_id" : string <booked cabs id>, "cab_location" : array <booked cabs location> }
}
```
### Ending the trip
This API end the trip and mark the cab for riding again.

### Request

```http
POST /api/v1/end-ride
```

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `cab_id` | `String` | **Required**. Id of cab whose trip is being ended |
| `ending_location` | `Array` | **Required**. Location at which trip has ended [latitude, logitude] |

### Response

```javascript
{
  "status" : string <success/failure>,
  "message" : string <success or failure message>
}
```
