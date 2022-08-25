codeally@9ba4761107d4:~/project$ psql --username=freecodecamp dbname=postgres
Border style is 2.
Pager usage is off.
psql (12.9 (Ubuntu 12.9-2.pgdg20.04+1))
Type "help" for help.

postgres=> \c postgres
You are now connected to database "postgres" as user "freecodecamp".
postgres=> \d
Did not find any relations.
postgres=> CREATE DATABASE universe;
CREATE DATABASE
postgres=> \c universe;
You are now connected to database "universe" as user "freecodecamp".
universe=> CREATE TABLE galaxy(galaxy_id SERIAL PRIMARY KEY, name VARCHAR(40) NOT NULL, description TEXT, age_in_million_of_years NUMERIC(3, 2), distance_from_earth NUMERIC(3,2));
CREATE TABLE
universe=> \d
                     List of relations
+--------+----------------------+----------+--------------+
| Schema |         Name         |   Type   |    Owner     |
+--------+----------------------+----------+--------------+
| public | galaxy               | table    | freecodecamp |
| public | galaxy_galaxy_id_seq | sequence | freecodecamp |
+--------+----------------------+----------+--------------+
(2 rows)

universe=> CREATE TABLE star(star_id SERIAL PRIMARY KEY, name VARCHAR(40) NOT NULL, description TEXT, distance_from_earth NUMERIC(3,2));
CREATE TABLE
universe=> ALTER TABLE star ADD COLUMN galaxy_id INT NOT NULL FOREIGN KEY REFERENCES galaxy(galaxy_id);
ERROR:  syntax error at or near "FOREIGN"
LINE 1: ...LTER TABLE star ADD COLUMN galaxy_id INT NOT NULL FOREIGN KE...
                                                             ^
universe=> ALTER TABLE star ADD COLUMN galaxy_id INT FOREIGN KEY REFERENCES galaxy(galaxy_id);
ERROR:  syntax error at or near "FOREIGN"
LINE 1: ALTER TABLE star ADD COLUMN galaxy_id INT FOREIGN KEY REFERE...
                                                  ^
universe=> ALTER TABLE star ADD COLUMN galaxy_id INT NOT NULL;
ALTER TABLE
universe=> ALTER TABLE star ADD FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id);
ALTER TABLE
universe=> \d star
                                             Table "public.star"
+---------------------+-----------------------+-----------+----------+---------------------------------------+
|       Column        |         Type          | Collation | Nullable |                Default                |
+---------------------+-----------------------+-----------+----------+---------------------------------------+
| star_id             | integer               |           | not null | nextval('star_star_id_seq'::regclass) |
| name                | character varying(40) |           | not null |                                       |
| description         | text                  |           |          |                                       |
| distance_from_earth | numeric(3,2)          |           |          |                                       |
| galaxy_id           | integer               |           | not null |                                       |
+---------------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "star_pkey" PRIMARY KEY, btree (star_id)
Foreign-key constraints:
    "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> \d
                     List of relations
+--------+----------------------+----------+--------------+
| Schema |         Name         |   Type   |    Owner     |
+--------+----------------------+----------+--------------+
| public | galaxy               | table    | freecodecamp |
| public | galaxy_galaxy_id_seq | sequence | freecodecamp |
| public | star                 | table    | freecodecamp |
| public | star_star_id_seq     | sequence | freecodecamp |
+--------+----------------------+----------+--------------+
(4 rows)

universe=> CREATE TABLE planet(planet_id SERIAL PRIMARY KEY, name VARCHAR(40) NOT NULL UNIQUE, description TEXT, has_life BOOLEAN, planet_types INT, star_id INT NOT NULL);
CREATE TABLE
universe=> \d planet
                                           Table "public.planet"
+--------------+-----------------------+-----------+----------+-------------------------------------------+
|    Column    |         Type          | Collation | Nullable |                  Default                  |
+--------------+-----------------------+-----------+----------+-------------------------------------------+
| planet_id    | integer               |           | not null | nextval('planet_planet_id_seq'::regclass) |
| name         | character varying(40) |           | not null |                                           |
| description  | text                  |           |          |                                           |
| has_life     | boolean               |           |          |                                           |
| planet_types | integer               |           |          |                                           |
| star_id      | integer               |           | not null |                                           |
+--------------+-----------------------+-----------+----------+-------------------------------------------+
Indexes:
    "planet_pkey" PRIMARY KEY, btree (planet_id)
    "planet_name_key" UNIQUE CONSTRAINT, btree (name)

universe=> CREATE TABLE moon(moon_id SERIAL PRIMARY KEY, name VARCHAR(40) NOT NULL UNIQUE, description TEXT, has_resources BOOLEAN, planet_id INT);
CREATE TABLE
universe=> \d star
                                             Table "public.star"
+---------------------+-----------------------+-----------+----------+---------------------------------------+
|       Column        |         Type          | Collation | Nullable |                Default                |
+---------------------+-----------------------+-----------+----------+---------------------------------------+
| star_id             | integer               |           | not null | nextval('star_star_id_seq'::regclass) |
| name                | character varying(40) |           | not null |                                       |
| description         | text                  |           |          |                                       |
| distance_from_earth | numeric(3,2)          |           |          |                                       |
| galaxy_id           | integer               |           | not null |                                       |
+---------------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "star_pkey" PRIMARY KEY, btree (star_id)
Foreign-key constraints:
    "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> \d planets
Did not find any relation named "planets".
universe=> \d planet
                                           Table "public.planet"
+--------------+-----------------------+-----------+----------+-------------------------------------------+
|    Column    |         Type          | Collation | Nullable |                  Default                  |
+--------------+-----------------------+-----------+----------+-------------------------------------------+
| planet_id    | integer               |           | not null | nextval('planet_planet_id_seq'::regclass) |
| name         | character varying(40) |           | not null |                                           |
| description  | text                  |           |          |                                           |
| has_life     | boolean               |           |          |                                           |
| planet_types | integer               |           |          |                                           |
| star_id      | integer               |           | not null |                                           |
+--------------+-----------------------+-----------+----------+-------------------------------------------+
Indexes:
    "planet_pkey" PRIMARY KEY, btree (planet_id)
    "planet_name_key" UNIQUE CONSTRAINT, btree (name)

universe=> ALTER TABLE planet ADD FOREIGN KEY(star_id) REFERENCES star(star_id);
ALTER TABLE
universe=> \d planet
                                           Table "public.planet"
+--------------+-----------------------+-----------+----------+-------------------------------------------+
|    Column    |         Type          | Collation | Nullable |                  Default                  |
+--------------+-----------------------+-----------+----------+-------------------------------------------+
| planet_id    | integer               |           | not null | nextval('planet_planet_id_seq'::regclass) |
| name         | character varying(40) |           | not null |                                           |
| description  | text                  |           |          |                                           |
| has_life     | boolean               |           |          |                                           |
| planet_types | integer               |           |          |                                           |
| star_id      | integer               |           | not null |                                           |
+--------------+-----------------------+-----------+----------+-------------------------------------------+
Indexes:
    "planet_pkey" PRIMARY KEY, btree (planet_id)
    "planet_name_key" UNIQUE CONSTRAINT, btree (name)
Foreign-key constraints:
    "planet_star_id_fkey" FOREIGN KEY (star_id) REFERENCES star(star_id)

universe=> ALTER TABLE moon ADD FOREIGN KEY(planet_id) REFERENCES star(planet_id);
ERROR:  column "planet_id" referenced in foreign key constraint does not exist
universe=> \d moon
                                          Table "public.moon"
+---------------+-----------------------+-----------+----------+---------------------------------------+
|    Column     |         Type          | Collation | Nullable |                Default                |
+---------------+-----------------------+-----------+----------+---------------------------------------+
| moon_id       | integer               |           | not null | nextval('moon_moon_id_seq'::regclass) |
| name          | character varying(40) |           | not null |                                       |
| description   | text                  |           |          |                                       |
| has_resources | boolean               |           |          |                                       |
| planet_id     | integer               |           |          |                                       |
+---------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "moon_pkey" PRIMARY KEY, btree (moon_id)
    "moon_name_key" UNIQUE CONSTRAINT, btree (name)

universe=> ALTER TABLE moon ADD FOREIGN KEY(planet_id) REFERENCES planet(planet_id);
ALTER TABLE
universe=> \d moon
                                          Table "public.moon"
+---------------+-----------------------+-----------+----------+---------------------------------------+
|    Column     |         Type          | Collation | Nullable |                Default                |
+---------------+-----------------------+-----------+----------+---------------------------------------+
| moon_id       | integer               |           | not null | nextval('moon_moon_id_seq'::regclass) |
| name          | character varying(40) |           | not null |                                       |
| description   | text                  |           |          |                                       |
| has_resources | boolean               |           |          |                                       |
| planet_id     | integer               |           |          |                                       |
+---------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "moon_pkey" PRIMARY KEY, btree (moon_id)
    "moon_name_key" UNIQUE CONSTRAINT, btree (name)
Foreign-key constraints:
    "moon_planet_id_fkey" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)

universe=> \d galaxy
                                                Table "public.galaxy"
+-------------------------+-----------------------+-----------+----------+-------------------------------------------+
|         Column          |         Type          | Collation | Nullable |                  Default                  |
+-------------------------+-----------------------+-----------+----------+-------------------------------------------+
| galaxy_id               | integer               |           | not null | nextval('galaxy_galaxy_id_seq'::regclass) |
| name                    | character varying(40) |           | not null |                                           |
| description             | text                  |           |          |                                           |
| age_in_million_of_years | numeric(3,2)          |           |          |                                           |
| distance_from_earth     | numeric(3,2)          |           |          |                                           |
+-------------------------+-----------------------+-----------+----------+-------------------------------------------+
Indexes:
    "galaxy_pkey" PRIMARY KEY, btree (galaxy_id)
Referenced by:
    TABLE "star" CONSTRAINT "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> ALTER TABLE galaxy ALTER COLUMN name SET UNIQUE;
ERROR:  syntax error at or near "UNIQUE"
LINE 1: ALTER TABLE galaxy ALTER COLUMN name SET UNIQUE;
                                                 ^
universe=> ALTER TABLE galaxy ALTER COLUMN name SET UNIQUE(name);
ERROR:  syntax error at or near "UNIQUE"
LINE 1: ALTER TABLE galaxy ALTER COLUMN name SET UNIQUE(name);
                                                 ^
universe=> DROP TABLE galaxy;
ERROR:  cannot drop table galaxy because other objects depend on it
DETAIL:  constraint star_galaxy_id_fkey on table star depends on table galaxy
HINT:  Use DROP ... CASCADE to drop the dependent objects too.
universe=> ALTER TABLE galaxy ADD COLUMN code INT NOT NULL UNIQUE;
ALTER TABLE
universe=> \d galaxy
                                                Table "public.galaxy"
+-------------------------+-----------------------+-----------+----------+-------------------------------------------+
|         Column          |         Type          | Collation | Nullable |                  Default                  |
+-------------------------+-----------------------+-----------+----------+-------------------------------------------+
| galaxy_id               | integer               |           | not null | nextval('galaxy_galaxy_id_seq'::regclass) |
| name                    | character varying(40) |           | not null |                                           |
| description             | text                  |           |          |                                           |
| age_in_million_of_years | numeric(3,2)          |           |          |                                           |
| distance_from_earth     | numeric(3,2)          |           |          |                                           |
| code                    | integer               |           | not null |                                           |
+-------------------------+-----------------------+-----------+----------+-------------------------------------------+
Indexes:
    "galaxy_pkey" PRIMARY KEY, btree (galaxy_id)
    "galaxy_code_key" UNIQUE CONSTRAINT, btree (code)
Referenced by:
    TABLE "star" CONSTRAINT "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> \d star
                                             Table "public.star"
+---------------------+-----------------------+-----------+----------+---------------------------------------+
|       Column        |         Type          | Collation | Nullable |                Default                |
+---------------------+-----------------------+-----------+----------+---------------------------------------+
| star_id             | integer               |           | not null | nextval('star_star_id_seq'::regclass) |
| name                | character varying(40) |           | not null |                                       |
| description         | text                  |           |          |                                       |
| distance_from_earth | numeric(3,2)          |           |          |                                       |
| galaxy_id           | integer               |           | not null |                                       |
+---------------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "star_pkey" PRIMARY KEY, btree (star_id)
Foreign-key constraints:
    "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
Referenced by:
    TABLE "planet" CONSTRAINT "planet_star_id_fkey" FOREIGN KEY (star_id) REFERENCES star(star_id)

universe=> ALTER TABLE star ADD COLUMN code INT NOT NULL UNIQUE;
ALTER TABLE
universe=> \d galaxy
                                                Table "public.galaxy"
+-------------------------+-----------------------+-----------+----------+-------------------------------------------+
|         Column          |         Type          | Collation | Nullable |                  Default                  |
+-------------------------+-----------------------+-----------+----------+-------------------------------------------+
| galaxy_id               | integer               |           | not null | nextval('galaxy_galaxy_id_seq'::regclass) |
| name                    | character varying(40) |           | not null |                                           |
| description             | text                  |           |          |                                           |
| age_in_million_of_years | numeric(3,2)          |           |          |                                           |
| distance_from_earth     | numeric(3,2)          |           |          |                                           |
| code                    | integer               |           | not null |                                           |
+-------------------------+-----------------------+-----------+----------+-------------------------------------------+
Indexes:
    "galaxy_pkey" PRIMARY KEY, btree (galaxy_id)
    "galaxy_code_key" UNIQUE CONSTRAINT, btree (code)
Referenced by:
    TABLE "star" CONSTRAINT "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)

universe=> INSERT INTO galaxy(name, description, age_in_million_of_years, distance_from_earth, code) VALUES
universe-> ('Centaurus A', 'Una galaxia lejana', 450.1, 18.2, 'A'),
universe-> ('Enana de Draco', 'Otra galaxia lejana', 320.1, 15.1, 'B'),
universe-> ('Antennae', 'Una galaxia en algun lugar del universo', 125.4, 18.6, 'C'),
universe-> ('Barnard', NULL, NULL, NULL, 'D'),
universe-> ('Cometa', NULL, 175.2, 8.9, 'E'),
universe-> ('Molinete', 'Una extraña galaxia', 75.8, 7.1, 'F');
ERROR:  invalid input syntax for type integer: "A"
LINE 2: ('Centaurus A', 'Una galaxia lejana', 450.1, 18.2, 'A'),
                                                           ^
universe=> INSERT INTO galaxy(name, description, age_in_million_of_years, distance_from_earth, code) VALUES
('Centaurus A', 'Una galaxia lejana', 450.1, 18.2, 1),
('Enana de Draco', 'Otra galaxia lejana', 320.1, 15.1, 2),
('Antennae', 'Una galaxia en algun lugar del universo', 125.4, 18.6, 3),
('Barnard', NULL, NULL, NULL, 4),
('Cometa', NULL, 175.2, 8.9, 5),
('Molinete', 'Una extraña galaxia', 75.8, 7.1, 6);
ERROR:  numeric field overflow
DETAIL:  A field with precision 3, scale 2 must round to an absolute value less than 10^1.
universe=> select * from galaxy;
+-----------+------+-------------+-------------------------+---------------------+------+
| galaxy_id | name | description | age_in_million_of_years | distance_from_earth | code |
+-----------+------+-------------+-------------------------+---------------------+------+
+-----------+------+-------------+-------------------------+---------------------+------+
(0 rows)

universe=> INSERT INTO galaxy(name, description, age_in_million_of_years, distance_from_earth, code) VALUES
('Centaurus A', 'Una galaxia lejana', 50.1, 18.2, 1),
('Enana de Draco', 'Otra galaxia lejana', 20.1, 15.1, 2),
('Antennae', 'Una galaxia en algun lugar del universo', 25.4, 18.6, 3),
('Barnard', NULL, NULL, NULL, 4),
('Cometa', NULL, 15.2, 8.9, 5),
('Molinete', 'Una extraña galaxia', 75.8, 7.1, 6);
ERROR:  numeric field overflow
DETAIL:  A field with precision 3, scale 2 must round to an absolute value less than 10^1.
universe=> INSERT INTO galaxy(name, description, age_in_million_of_years, distance_from_earth, code) VALUES
('Centaurus A', 'Una galaxia lejana', 8.1, 8.2, 1),
('Enana de Draco', 'Otra galaxia lejana', 0.1, 5.1, 2),
('Antennae', 'Una galaxia en algun lugar del universo', 5.4, 8.6, 3),
('Barnard', NULL, NULL, NULL, 4),
('Cometa', NULL, 5.2, 8.9, 5),
('Molinete', 'Una extraña galaxia', 5.8, 7.1, 6);
INSERT 0 6
universe=> select * from galaxy;
+-----------+----------------+-----------------------------------------+-------------------------+---------------------+------+
| galaxy_id |      name      |               description               | age_in_million_of_years | distance_from_earth | code |
+-----------+----------------+-----------------------------------------+-------------------------+---------------------+------+
|         1 | Centaurus A    | Una galaxia lejana                      |                    8.10 |                8.20 |    1 |
|         2 | Enana de Draco | Otra galaxia lejana                     |                    0.10 |                5.10 |    2 |
|         3 | Antennae       | Una galaxia en algun lugar del universo |                    5.40 |                8.60 |    3 |
|         4 | Barnard        |                                         |                         |                     |    4 |
|         5 | Cometa         |                                         |                    5.20 |                8.90 |    5 |
|         6 | Molinete       | Una extraña galaxia                     |                    5.80 |                7.10 |    6 |
+-----------+----------------+-----------------------------------------+-------------------------+---------------------+------+
(6 rows)

universe=>  \d star
                                             Table "public.star"
+---------------------+-----------------------+-----------+----------+---------------------------------------+
|       Column        |         Type          | Collation | Nullable |                Default                |
+---------------------+-----------------------+-----------+----------+---------------------------------------+
| star_id             | integer               |           | not null | nextval('star_star_id_seq'::regclass) |
| name                | character varying(40) |           | not null |                                       |
| description         | text                  |           |          |                                       |
| distance_from_earth | numeric(3,2)          |           |          |                                       |
| galaxy_id           | integer               |           | not null |                                       |
| code                | integer               |           | not null |                                       |
+---------------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "star_pkey" PRIMARY KEY, btree (star_id)
    "star_code_key" UNIQUE CONSTRAINT, btree (code)
Foreign-key constraints:
    "star_galaxy_id_fkey" FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
Referenced by:
    TABLE "planet" CONSTRAINT "planet_star_id_fkey" FOREIGN KEY (star_id) REFERENCES star(star_id)

universe=> INSERT INTO star(name, description, distance_from_earth, galaxy_id, code) VALUEs
universe-> ('Sirio', 'Una estrella lejana', 8.6, 1, 1),
universe-> ('Canopues', 'Otra estrella', 4.5, 2, 2),
universe-> ('Arturo', NULL, NULL, 3, 3),
universe-> ('Vega', NULL, 7.1, 4, 4),
universe-> ('Hadar', 'Una estrella brillante', 1.5, 5, 5),
universe-> ('Rigel', 'Ultima estrella', 7.6, 6, 6);
INSERT 0 6
universe=> SELECt * from star;
+---------+----------+------------------------+---------------------+-----------+------+
| star_id |   name   |      description       | distance_from_earth | galaxy_id | code |
+---------+----------+------------------------+---------------------+-----------+------+
|       1 | Sirio    | Una estrella lejana    |                8.60 |         1 |    1 |
|       2 | Canopues | Otra estrella          |                4.50 |         2 |    2 |
|       3 | Arturo   |                        |                     |         3 |    3 |
|       4 | Vega     |                        |                7.10 |         4 |    4 |
|       5 | Hadar    | Una estrella brillante |                1.50 |         5 |    5 |
|       6 | Rigel    | Ultima estrella        |                7.60 |         6 |    6 |
+---------+----------+------------------------+---------------------+-----------+------+
(6 rows)

universe=> \d
                     List of relations
+--------+----------------------+----------+--------------+
| Schema |         Name         |   Type   |    Owner     |
+--------+----------------------+----------+--------------+
| public | galaxy               | table    | freecodecamp |
| public | galaxy_galaxy_id_seq | sequence | freecodecamp |
| public | moon                 | table    | freecodecamp |
| public | moon_moon_id_seq     | sequence | freecodecamp |
| public | planet               | table    | freecodecamp |
| public | planet_planet_id_seq | sequence | freecodecamp |
| public | star                 | table    | freecodecamp |
| public | star_star_id_seq     | sequence | freecodecamp |
+--------+----------------------+----------+--------------+
(8 rows)

universe=> SELECt * from star;
+---------+----------+------------------------+---------------------+-----------+------+
| star_id |   name   |      description       | distance_from_earth | galaxy_id | code |
+---------+----------+------------------------+---------------------+-----------+------+
|       1 | Sirio    | Una estrella lejana    |                8.60 |         1 |    1 |
|       2 | Canopues | Otra estrella          |                4.50 |         2 |    2 |
|       3 | Arturo   |                        |                     |         3 |    3 |
|       4 | Vega     |                        |                7.10 |         4 |    4 |
|       5 | Hadar    | Una estrella brillante |                1.50 |         5 |    5 |
|       6 | Rigel    | Ultima estrella        |                7.60 |         6 |    6 |
+---------+----------+------------------------+---------------------+-----------+------+
(6 rows)

universe=> \d planet
                                           Table "public.planet"
+--------------+-----------------------+-----------+----------+-------------------------------------------+
|    Column    |         Type          | Collation | Nullable |                  Default                  |
+--------------+-----------------------+-----------+----------+-------------------------------------------+
| planet_id    | integer               |           | not null | nextval('planet_planet_id_seq'::regclass) |
| name         | character varying(40) |           | not null |                                           |
| description  | text                  |           |          |                                           |
| has_life     | boolean               |           |          |                                           |
| planet_types | integer               |           |          |                                           |
| star_id      | integer               |           | not null |                                           |
+--------------+-----------------------+-----------+----------+-------------------------------------------+
Indexes:
    "planet_pkey" PRIMARY KEY, btree (planet_id)
    "planet_name_key" UNIQUE CONSTRAINT, btree (name)
Foreign-key constraints:
    "planet_star_id_fkey" FOREIGN KEY (star_id) REFERENCES star(star_id)
Referenced by:
    TABLE "moon" CONSTRAINT "moon_planet_id_fkey" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)

universe=> INSERT INTO planet(nane, description, has_life, planet_types, star_id) VALUES
universe-> ('Mercurio', 'Primer planeta', FALSE, 2, 1),
universe-> ('Venus', 'Segundo planeta', FALSE, 4, 2),
universe-> ('Tierra', 'Tercer planeta', TRUE, 2, 3),
universe-> ('Marte', 'Cuarto planeta', TRUE, 5, 4),
universe-> ('Ceres', 'Quinto planeta', FALSE, 3, 5),
universe-> ('Jupiter', 'Sexto planeta', FALSE, 3, 6),
universe-> ('Saturno', 'Septimo planeta', FALSE, 1, 1),
universe-> ('Urano', 'Octavo planeta', TRUE, 2, 2),
universe-> ('Neptuno', 'Noveno planeta', FALSE, 5, 3),
universe-> ('Pluton', 'Decimo planeta', FALSE, 4, 4),
universe-> ('Caronte', 'Onceavo planeta', FALSE, 3, 5),
universe-> ('UB313', 'Doceavo planeta', TRUE, 5, 6);
ERROR:  column "nane" of relation "planet" does not exist
LINE 1: INSERT INTO planet(nane, description, has_life, planet_types...
                           ^
universe=> INSERT INTO planet(name, description, has_life, planet_types, star_id) VALUES
('Mercurio', 'Primer planeta', FALSE, 2, 1),
('Venus', 'Segundo planeta', FALSE, 4, 2),
('Tierra', 'Tercer planeta', TRUE, 2, 3),
('Marte', 'Cuarto planeta', TRUE, 5, 4),
('Ceres', 'Quinto planeta', FALSE, 3, 5),
('Jupiter', 'Sexto planeta', FALSE, 3, 6),
('Saturno', 'Septimo planeta', FALSE, 1, 1),
('Urano', 'Octavo planeta', TRUE, 2, 2),
('Neptuno', 'Noveno planeta', FALSE, 5, 3),
('Pluton', 'Decimo planeta', FALSE, 4, 4),
('Caronte', 'Onceavo planeta', FALSE, 3, 5),
('UB313', 'Doceavo planeta', TRUE, 5, 6);
INSERT 0 12
universe=> SELECT * FROM planet;
+-----------+----------+-----------------+----------+--------------+---------+
| planet_id |   name   |   description   | has_life | planet_types | star_id |
+-----------+----------+-----------------+----------+--------------+---------+
|         1 | Mercurio | Primer planeta  | f        |            2 |       1 |
|         2 | Venus    | Segundo planeta | f        |            4 |       2 |
|         3 | Tierra   | Tercer planeta  | t        |            2 |       3 |
|         4 | Marte    | Cuarto planeta  | t        |            5 |       4 |
|         5 | Ceres    | Quinto planeta  | f        |            3 |       5 |
|         6 | Jupiter  | Sexto planeta   | f        |            3 |       6 |
|         7 | Saturno  | Septimo planeta | f        |            1 |       1 |
|         8 | Urano    | Octavo planeta  | t        |            2 |       2 |
|         9 | Neptuno  | Noveno planeta  | f        |            5 |       3 |
|        10 | Pluton   | Decimo planeta  | f        |            4 |       4 |
|        11 | Caronte  | Onceavo planeta | f        |            3 |       5 |
|        12 | UB313    | Doceavo planeta | t        |            5 |       6 |
+-----------+----------+-----------------+----------+--------------+---------+
(12 rows)

universe=> \d moon
                                          Table "public.moon"
+---------------+-----------------------+-----------+----------+---------------------------------------+
|    Column     |         Type          | Collation | Nullable |                Default                |
+---------------+-----------------------+-----------+----------+---------------------------------------+
| moon_id       | integer               |           | not null | nextval('moon_moon_id_seq'::regclass) |
| name          | character varying(40) |           | not null |                                       |
| description   | text                  |           |          |                                       |
| has_resources | boolean               |           |          |                                       |
| planet_id     | integer               |           |          |                                       |
+---------------+-----------------------+-----------+----------+---------------------------------------+
Indexes:
    "moon_pkey" PRIMARY KEY, btree (moon_id)
    "moon_name_key" UNIQUE CONSTRAINT, btree (name)
Foreign-key constraints:
    "moon_planet_id_fkey" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)

universe=> INSERT INTO moon(name, description, has_resources, planet_id) VALUES
universe-> ('Luna', 'Unica luna de la tierra', TRUE, 3),
universe-> ('Deimos', 'Primera luna de marte', TRUE, 4),
universe-> ('Phobos', 'Segunda luna de marte', FALSE, 4),
universe-> ('Adrastea', '1 luna de jupiter', FALSE, 6),
universe-> ('Aitne', '2 luna de jupiter', FALSE, 6),
universe-> ('Amalthes', NULL, FALSE, 6),
universe-> ('Io', 'Otra luna de jupiter', TRUE, 6),
universe-> ('Kale', 'Emm otra luna', FALSE, 6),
universe-> ('Kalyke', 'Ultima luna de jupiter', FALSE, 6),
universe-> ('Aegir', '1 Luta de saturno', FALSE, 7),
universe-> ('Atlas', '2 luna de saturno', TRUE, 7),
universe-> ('Helene', '3 luna de saturno', TRUE, 7),
universe-> ('Janus', '4 luna de saturno', FALSE, 7),
universe-> ('Kari', '5 luna de saturno', FALSE, 7),
universe-> ('Loge', '6 luna de saturno', FALSE, 7),
universe-> ('Rhea', NULL, TRUE, 7),
universe-> ('Ariel', '1 luna de urano', TRUE, 8),
universe-> ('Mab', '2 luna de urano', FALSE, 8),
universe-> ('Portia', '3 luna de urano', FALSE, 8),
universe-> ('Puck', '4 luna de urano', TRUE, 8);
INSERT 0 20
universe=> CREATE TABLE especies(especies_id SERIAL, name TEXT NOT NULL, planet_id INT);
CREATE TABLE
universe=> ALTER TABLE especies ADD PRIMARY KEY(especies_id);
ALTER TABLE
universe=> \d especies
                                    Table "public.especies"
+-------------+---------+-----------+----------+-----------------------------------------------+
|   Column    |  Type   | Collation | Nullable |                    Default                    |
+-------------+---------+-----------+----------+-----------------------------------------------+
| especies_id | integer |           | not null | nextval('especies_especies_id_seq'::regclass) |
| name        | text    |           | not null |                                               |
| planet_id   | integer |           |          |                                               |
+-------------+---------+-----------+----------+-----------------------------------------------+
Indexes:
    "especies_pkey" PRIMARY KEY, btree (especies_id)

universe=> DROP TABLE especies;
DROP TABLE
universe=> CREATE TABLE especies(especies_id SERIAL PRIMARY KEY, name VARCHAR(40) NOT NULL UNIQUE, planet_id INT);
CREATE TABLE
universe=> \d especies
                                           Table "public.especies"
+-------------+-----------------------+-----------+----------+-----------------------------------------------+
|   Column    |         Type          | Collation | Nullable |                    Default                    |
+-------------+-----------------------+-----------+----------+-----------------------------------------------+
| especies_id | integer               |           | not null | nextval('especies_especies_id_seq'::regclass) |
| name        | character varying(40) |           | not null |                                               |
| planet_id   | integer               |           |          |                                               |
+-------------+-----------------------+-----------+----------+-----------------------------------------------+
Indexes:
    "especies_pkey" PRIMARY KEY, btree (especies_id)
    "especies_name_key" UNIQUE CONSTRAINT, btree (name)

universe=> ALTER TABLE especies ADD FOREIGN KEY planet_id REFERENCES planet(planet_id);
ERROR:  syntax error at or near "planet_id"
LINE 1: ALTER TABLE especies ADD FOREIGN KEY planet_id REFERENCES pl...
                                             ^
universe=> ALTER TABLE especies ADD FOREIGN KEY(planet_id) REFERENCES planet(planet_id);
ALTER TABLE
universe=> \d especies
                                           Table "public.especies"
+-------------+-----------------------+-----------+----------+-----------------------------------------------+
|   Column    |         Type          | Collation | Nullable |                    Default                    |
+-------------+-----------------------+-----------+----------+-----------------------------------------------+
| especies_id | integer               |           | not null | nextval('especies_especies_id_seq'::regclass) |
| name        | character varying(40) |           | not null |                                               |
| planet_id   | integer               |           |          |                                               |
+-------------+-----------------------+-----------+----------+-----------------------------------------------+
Indexes:
    "especies_pkey" PRIMARY KEY, btree (especies_id)
    "especies_name_key" UNIQUE CONSTRAINT, btree (name)
Foreign-key constraints:
    "especies_planet_id_fkey" FOREIGN KEY (planet_id) REFERENCES planet(planet_id)

universe=> INSERT INTO especies(name, planet_id) VALUES
universe-> ('Humano', 3),
universe-> ('Xenos', 4),
universe-> ('Perro', 3);
INSERT 0 3
universe=> 
universe=>