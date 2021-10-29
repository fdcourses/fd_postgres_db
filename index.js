const {Client} = require('pg');
const {loadUsers} = require('./api');
const config = require('./configs/db.json');

const client = new Client(config);

async function start() {
  await client.connect();

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
      ({gender, name: {first, last}, email, dob: {date} }) =>
        `('${first}', '${last}', '${email}', '${date}', ${Math.random() + 1}, ${gender === "male"})`
    )
    .join(',');
}

start();