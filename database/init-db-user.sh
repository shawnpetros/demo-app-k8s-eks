#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE USER docker;
  CREATE DATABASE docker;
  GRANT ALL PRIVILEGES ON DATABASE docker TO docker;
  CREATE TABLE account(
    user_id serial PRIMARY KEY,
    username VARCHAR (50) UNIQUE NOT NULL,
    password VARCHAR (50) NOT NULL,
    email VARCHAR (355) UNIQUE NOT NULL,
    created_on TIMESTAMP DEFAULT Now()
  );
  INSERT INTO account(username, password, email)
  VALUES
    ('bob dole', 'b0b1', 'bob@bobs-code.com'),
    ('jill baker', 'p@ssw0rd', 'jill@jillsbakery.com'),
    ('jack beanstalk', 'gr33n', 'jack@giantproduce.com'),
    ('mark webber', 'gr!ll!n', 'mark@webber-grills.com');
EOSQL