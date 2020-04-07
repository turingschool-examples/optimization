# Optimization

This repo is intended to be used for Turing's [Intro to Optimization Lesson](https://backend.turing.io/module3/lessons/optimization)

## Set Up

1. Clone this repo
1. Run `bundle install` from the command line

### Database Setup

Since generating a large amount of sample data via a DB seed task takes
time, this branch includes a pre-built dataset in the form of a postgres
DB dump. This is a data format similar to what you might use to backup a
production postgres system.

A `pg_dump` is basically a direct snapshot of all the data contained in
the DB at a given time. As such it's much quicker for your local
postgres server to load all this data than it would be for you to
re-generate all the data via the seed task yourself.

If you would like to see how the seeds were created, you can look at the `db/seeds.rb` file. Warning: manually running the seeds task will take several minutes to complete and is not recommended. Instead, load the sample data by running:

```bash
rails sample_data:load
```

If you would like to skip importing the data, you can create your database the more traditional way:

```bash
rails db:create
rails db:migrate
```
