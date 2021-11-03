const _ = require('lodash');

module.exports.mapUsers = (users) => {
  return users
    .map(
      ({ name: { first, last }, email, gender, dob: { date } }) =>
        `('${first}','${last}','${email}','${gender === 'male'}','${date}','${(
          Math.random() + 1
        ).toFixed(2)}', '${_.random(40, 150)}')`
    )
    .join(',');
};

const PHONES_BRANDS = [
  'Samsung',
  'Nokia',
  'Huawei',
  'Xiaomi',
  'IPhone',
  'Honor',
  'Siemens',
  'Motorola',
  'Google'
];

const PHONE_MODELS = [
  'Pixel',
  'Alpha',
  'Pro',
  'Note',
  'Plus',
  'Pro plus',
  'Galaxy',
  'Ultra',
  'Thin',
  'Ultrathin',
];

const generatePhone = (key) => ({
  brand: PHONES_BRANDS[_.random(0, PHONES_BRANDS.length - 1, false)],
  model: `${
    Math.random() > 0.6
      ? `model`
      : PHONE_MODELS[_.random(0, PHONE_MODELS.length - 1)]
  } ${_.random(0, 1000, false)}-${key}`,
  price: _.random(1500, 40000, false),
  quantity: _.random(100, 2500, false),
});

module.exports.generatePhones = (length = 50) =>
  new Array(length).fill(null).map((_, i) => generatePhone(i));
