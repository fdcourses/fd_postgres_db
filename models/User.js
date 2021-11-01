const { mapUsers } = require('../utils');

class User {
  static _client;
  static _tableName = 'users';

  static async bulkCreate (users) {
    const { rows } = await this._client.query(`
    INSERT INTO "${this._tableName}" (
      "firstName",
      "lastName",
      "email",
      "isMale",
      "birthday",
      "height",
      "weight"
    ) 
    VALUES ${mapUsers(users)}
    RETURNING *;`);
    return rows;
  }

  static async findAll () {
    const {rows} = await this._client.query(`SELECT * FROM users;`);

    return rows;
  }
}

module.exports = User;