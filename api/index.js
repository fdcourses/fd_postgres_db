const axios = require('axios').default;

const httpClient = axios.create({
  baseURL: 'https://randomuser.me/api'
});

module.exports.loadUsers = async () => {
  const {data : {results}} = await httpClient.get('/?results=100&seed=test&page=1');
  return results;
}