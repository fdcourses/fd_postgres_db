const {Client} = require('pg');

const config = {
  user: 'postgres',
  password: 'postgres',
  host: 'localhost',
  database: 'fd_db_dont_delete',
  port: 5432
}

const users =  [
  {
    firstName: 'Test',
    lastName: 'Testovich',
    email: 'test1@test.test',
    birthday: '2007/7/10',
    height: 1.90,
    isMale: true,
  },
  {
    firstName: 'fdgfdghg',
    lastName: 'dsfdgfdgfdgfds',
    email: 'test2@test.test',
    birthday: '1991/3/12',
    height: 1.25,
    isMale: false,
  },
  {
    firstName: 'lf;ndsfougasb',
    lastName: 'Testovdsfdsfich',
    email: 'test3@test.test',
    birthday: '1989/7/10',
    height: 1.73,
    isMale: true,
  },
];

const client = new Client(config);

const testUser = {
  firstName: 'Test',
  lastName : "Testovich",
  email: 'test@test.test',
  birthday: '1984/7/10',
  height: 1.68,
  isMale: true
}

async function start() {
  await client.connect();

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
      (user) =>
        `('${user.firstName}', '${user.lastName}', '${user.email}', '${user.birthday}', ${user.height}, ${user.isMale})`
    )
    .join(',');
}

start();