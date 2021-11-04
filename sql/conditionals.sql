SELECT (
  CASE
    WHEN 2+2 = 4 THEN 'нормальная математика'
    WHEN 2+2 = 5 THEN 'интересная математика'
    ELSE '???'
  END
)

SELECT id, "firstName", "lastName", CASE
  WHEN "isMale" THEN 'Male'
  ELSE 'Female'
END AS "gender", "isMale"
FROM users;


SELECT id, "firstName", "lastName", (
  CASE "isMale"
    WHEN true THEN 'Male'
    WHEN false THEN 'Female'
  END
  )AS "gender", "isMale"
FROM users;


/*
CASE 
*/

-- показать сезоны рождения
SELECT CASE
  WHEN extract(month from birthday) BETWEEN 3 AND 5 THEN 'Весна'
  WHEN extract(month from birthday) BETWEEN 6 AND 8 THEN 'Лето'
  WHEN extract(month from birthday) BETWEEN 9 AND 11 THEN 'Осень'
  ELSE 'Зима'm=
END as season, birthday, id, email
FROM users;

/*
у каждого телефона укажите его сегмент
бюджет - до 10 тыщ
средний - от 10 до 20
флагманы - от 20 и выше
*/
SELECT id, brand, model, CASE 
  WHEN price < 10000 THEN 'budget'
  WHEN price BETWEEN 10000 AND 20000 THEN 'middle'
  ELSE 'flagman'
END ,price
FROM phones;
-- для телефонов вынуть их с столбцом производитель в котом может 
--былть значение Apple или не Apple
SELECT CASE 
  WHEN brand LIKE 'iphone' THEN 'Apple'
  ELSE 'not Apple'
END as производитель, *
FROM phones;