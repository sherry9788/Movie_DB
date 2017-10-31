/* PRIMARY KEY violations */
INSERT INTO Actor VALUES (1, 'W', 'Lud', 'Male', 19960101, \N);
/*ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
  It makes two different tuples have the same id*/
INSERT INTO Director VALUES (37146, 'W', 'Lud', 19960101, \N);
/*ERROR 1062 (23000): Duplicate entry '37146' for key 'PRIMARY'
  It makes two different directors have the same id*/
INSERT INTO Movie VALUES (\N, 'W', 1996, "A", \N);
/*ERROR 1048 (23000): Column 'id' cannot be null
  It makes primary key id contains null value
*/

/* FOREIGN KEY VIOLATION */
DELETE FROM Movie WHERE id = 3;
/*ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`TEST`.`MovieGenre`, CONSTRAINT `MovieGenre_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))
It makes MovieGenre refers to some non-existing Movie(whose id doesn't appear in Movie)*/
DELETE FROM Director WHERE id = 37146;
/*ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`TEST`.`MovieDirector`, CONSTRAINT `MovieDirector_ibfk_2` FOREIGN KEY (`did`) REFERENCES `Director` (`id`))
It makes MovieDirector refers to some non-existing Director(whose id doesn't appear in Directors)*/
DELETE FROM Actor WHERE id=10208;
/*ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`TEST`.`MovieActor`, CONSTRAINT `MovieActor_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `Actor` (`id`))
It makes MovieActor refers to some non-existing Actor(whose id doesn't appear in Actor)*/
DELETE FROM Movie WHERE id = 272;
/*ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`TEST`.`MovieRating`, CONSTRAINT `MovieRating_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))
It makes MovieRating refers to some non-existing Movie(whose id doesn't appear in Movie)*/
DELETE FROM Movie WHERE id = 906;
/*ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`TEST`.`MovieDirector`, CONSTRAINT `MovieDirector_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))
It makes MovieDirector refers to some non-existing Movie(whose id doesn't appear in Movie)*/
DELETE FROM Movie WHERE id = 1266;
/*ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`TEST`.`MovieActor`, CONSTRAINT `MovieActor_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `Movie` (`id`))
It makes MovieActor refers to some non-existing Movie(whose id doesn't appear in Movie)*/

/* CHECK VIOLATION */
INSERT INTO Movie VALUES(-10, 'Nirvana', 1000, 'Good', 'Company');
/*Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0
INNODB doesn't support CHECK, but this violates the check that id of the movie should be non-negative*/
UPDATE MovieRating SET imdb = 1000 WHERE mid = 2971;
/*Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0
INNODB doesn't support CHECK, but this violates the check that the rating should be scaled to 0-100*/
UPDATE Sales SET ticketsSold = -10 WHERE mid = 272;
/*Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0
INNODB doesn't support CHECK, but this violates the check that ticketsSold of the movie should be non-negative*/
