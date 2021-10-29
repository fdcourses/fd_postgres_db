const { Client } = require('pg');
const { loadUsers } = require('./api');
const config = require('./configs/db.json');

const client = new Client(config);

async function start() {
  await client.connect();

  await client.query(`CREATE TABLE IF NOT EXISTS "users"(
    id serial PRIMARY KEY,
    first_name varchar(64) NOT NULL CHECK(first_name != ''),
    last_name varchar(64) NOT NULL CHECK(last_name != ''),
    email varchar(256) NOT NULL UNIQUE,
    birthday date NOT NULL,
    height numeric (3, 2) CHECK (
      height > 0.2
      AND height < 3
    ),
    is_male boolean,
    CONSTRAINT "CHECK_EMAIL_NOT_EMPTY" CHECK (email != '')
  );`);

  const users = await loadUsers();
  const result = await client.query(`
    INSERT INTO users (
      first_name, 
      last_name, 
      email, 
      birthday,
      height, 
      is_male)
    VALUES 
    ${mapUsers(users)};
  `);

  await client.end();
}

function mapUsers(usersArr) {
  return usersArr
    .map(
      ({ gender, name: { first, last }, email, dob: { date } }) =>
        `('${first}', '${last}', '${email}', '${date}', ${Math.random() + 1}, ${
          gender === 'male'
        })`
    )
    .join(',');
}

start();
