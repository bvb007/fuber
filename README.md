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
