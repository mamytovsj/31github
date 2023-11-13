/* Добавление новой колонки в таблицу сотрудников об информации города проживания */
ALTER TABLE employees add column city VARCHAR(200) DEFAULT NULL;


/* Изменение пустых значений колонки city */
UPDATE employees
   SET city = 'Bishkek'
 WHERE id IN (1, 4, 5, 8, 13);

UPDATE employees
   SET city = 'Osh'
 WHERE id IN (3, 7, 10, 15);

UPDATE employees
   SET city = 'Tokyo'
 WHERE id IN (6, 11, 12, 14);

UPDATE employees
   SET city = 'Dublin'
 WHERE id IN (9, 16);


/* Удаление колонки city из таблицы сотрудников */
ALTER TABLE employees DROP COLUMN city;


/* Создание новой таблицы с городами */
CREATE TABLE cities (
c_id INTEGER PRIMARY KEY AUTOINCREMENT,
title VARCHAR(200) NOT NULL, 
population INTEGER NOT NULL
);


/* Заполнение данными новой таблицы с городами */
INSERT INTO cities (title, population) VALUES 
('Bishkek', 2000000),
('Osh', 1000000),
('Tokyo', 80000000),
('Dublin', 25000000),
('Pekin', 95000000); 


/* Добавление новой колонки в таблицу сотрудников - living_city_id с внешним ключом на таблицу cities */
ALTER TABLE employees ADD living_city_id INTEGER DEFAULT NULL
REFERENCES cities (c_id) ON DELETE NO ACTION;


/* Изменение пустых значений колонки city */
UPDATE employees
   SET living_city_id = 1
 WHERE id IN (4, 5, 8, 13);

UPDATE employees
   SET living_city_id = 2
 WHERE id IN (3, 7, 10, 15);

UPDATE employees
   SET living_city_id = 3
 WHERE id IN (6, 11, 12, 14);

UPDATE employees
   SET living_city_id = 4
 WHERE id IN (9, 16);


/* Соединение таблиц - INNER JOIN (выборка только пересекающихся) */
SELECT e.*,
       c.title
  FROM employees AS e
       INNER JOIN
       cities AS c ON e.living_city_id = c.c_id;


/* Соединение таблиц - LEFT JOIN (выборка всех записей из левой таблицы) */
SELECT e.*,
       c.title
  FROM employees AS e
       LEFT JOIN
       cities AS c ON e.living_city_id = c.c_id;


/* Соединение таблиц - RIGHT JOIN (выборка всех записей из правой таблицы) */
SELECT e.*,
       c.title
  FROM employees AS e
       RIGHT JOIN
       cities AS c ON e.living_city_id = c.c_id;
    

/* Соединение таблиц - FULL JOIN (выборка всех записей в обеих таблица даже непересекающихся) */
SELECT e.*,
       c.title,
       c.population
  FROM employees AS e
       LEFT OUTER JOIN
       cities AS c ON e.living_city_id = c.c_id
UNION ALL
SELECT e.*,
       c.title,
       c.population
  FROM cities AS c
       LEFT OUTER JOIN
       employees AS e ON c.c_id = e.living_city_id
 WHERE e.living_city_id IS NULL;


 /* Создание новой таблицы с информацией о паспортных данных сотрудников */
CREATE TABLE passport_info (
    employee_id     INTEGER       NOT NULL
                                  REFERENCES employees (id) ON DELETE NO ACTION,
    passport_number VARCHAR (40)  NOT NULL,
    issue_date      DATE          NOT NULL,
    issue_place     VARCHAR (100) NOT NULL
);


/* Заполнение новой таблицы с городами данными*/
INSERT INTO passport_info (employee_id, passport_number, issue_date, issue_place) VALUES 
(1, 'AN87654', '2000-01-08', 'MKK 50-51'),
(3, 'AN21354', '2001-08-08', 'MKK 50-51'),
(4, 'AN11114', '2000-06-11', 'MKK 50-51'),
(5, 'AN86764', '2022-03-01', 'MKK 50-51'),
(6, 'AN87600', '2021-01-08', 'MKK 50-51'),
(7, 'AN00004', '2011-02-06', 'MKK 50-51'),
(8, 'AN34654', '2012-01-06', 'MKK 50-51'),
(9, 'AN88884', '2013-08-11', 'MKK 52-51'),
(10, 'AN86554', '2000-11-09', 'MKK 50-51'),
(11, 'AN44454', '2009-01-01', 'MKK 50-51'),
(12, 'AN57655', '2000-06-09', 'MKK 52-53'),
(13, 'AN53354', '2003-11-01', 'MKK 50-51'),
(14, 'AN87444', '2004-08-09', 'MKK 50-51'),
(15, 'AN34554', '2009-01-01', 'MKK 50-51'),
(16, 'AN81114', '2001-11-01', 'MKK 50-51'); 

 /* Создание новой таблицы с фильмами */
CREATE TABLE films (
    f_id  INTEGER       PRIMARY KEY AUTOINCREMENT,
    title VARCHAR (250) NOT NULL,
    year  INTEGER       NOT NULL
);

/* Заполнение данными новой таблицы с фильмами */
INSERT INTO films (title, year) VALUES 
('Titanic', 1997),
('Thor', 2011),
('Gladiator', 2000),
('Shrek', 2001),
('Avatar', 2009); 

/* Создание новой таблицы реализующей связь many-to-many */
CREATE TABLE employee_favorite_films (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    employee_id INTEGER NOT NULL
                        REFERENCES employees (id) ON DELETE NO ACTION,
    film_id     INTEGER NOT NULL
                        REFERENCES films (f_id) ON DELETE NO ACTION,
    score       FLOAT   NOT NULL
                        DEFAULT 0
);

/* Заполнение данными новой таблицы с любимыми фильмами сотрудников */
INSERT INTO employee_favorite_films (employee_id, film_id, score) VALUES 
(1, 1, 9.2),
(1, 3, 8.6),
(1, 5, 7.4),
(3, 1, 7.5),
(3, 4, 8.8),
(4, 5, 10.0),
(5, 1, 9.0),
(6, 2, 7.7),
(6, 4, 7.8),
(7, 5, 8.0),
(8, 1, 9.5),
(8, 2, 7.3),
(9, 3, 9.1); 

/* Выборка любимых фильмов женатых сотрудников */
SELECT e.full_name,
       f.title
  FROM employees AS e
       LEFT JOIN
       employee_favorite_films AS eff ON e.id = eff.employee_id
       LEFT JOIN
       films AS f ON eff.film_id = f.f_id
 WHERE f.title IS NOT NULL AND 
       e.is_married = TRUE;

/* Выборка аггрегированных результатов с помощью основных функций */
SELECT count(id),
       sum(salary),
       min(salary),
       max(salary),
       avg(salary) 
  FROM employees;
  
/* Выборка аггрегированных результатов с помощью основных функций по группам GROUP BY */
SELECT is_married,
       count(id),
       sum(salary),
       min(salary),
       max(salary),
       avg(salary) 
  FROM employees
 GROUP BY is_married;

 SELECT is_married,
       hobby,
       count(id),
       sum(salary),
       min(salary),
       max(salary),
       avg(salary) 
  FROM employees
 GROUP BY is_married,
          hobby;

/* Выборка аггрегированных результатов с помощью основных функций по группам GROUP BY и фильтрация по аггрегированным результатам */
SELECT is_married,
       hobby,
       count(id),
       sum(salary),
       min(salary),
       max(salary),
       avg(salary) 
  FROM employees
 GROUP BY is_married,
          hobby
HAVING count(id) > 1;

/* Подзапросы - получаем сотрудников кто живет в городе с населением больше 10 миллионов или кто любит фильм Титаник */
SELECT *
  FROM employees
 WHERE living_city_id IN (
           SELECT c_id
             FROM cities
            WHERE population > 10000000
       )
OR 
       id IN (
           SELECT eff.id
             FROM employee_favorite_films AS eff
                  LEFT JOIN
                  films AS f ON eff.film_id = f.f_id
            WHERE f.title = 'Titanic'
       );

/* Создание представления (VIEW) на основе выборки суммы зарплат сотрудников по городам */
CREATE VIEW salaries_by_city AS
    SELECT c.title AS city,
           ifnull(sum(salary), 0) AS total_salary
      FROM cities AS c
           LEFT JOIN
           employees AS e ON c.c_id = e.living_city_id
     GROUP BY c.c_id;
