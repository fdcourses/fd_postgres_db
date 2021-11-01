const axios = require('axios').default;
const queryString = require('query-string');

const {baseURL, get: {users: usersGetObj}} = require('../configs/api.json');

const httpClient = axios.create({
  baseURL
});

module.exports.loadUsers = async (options = {}) => {
  const queryParams ={
    ...usersGetObj,
    ...options
  }

  const {data : {results: users}} = await httpClient.get(`?${queryString.stringify(queryParams)}`);
  return users;
}