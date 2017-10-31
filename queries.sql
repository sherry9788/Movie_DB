/*this query select the full name of the actor who played in 'Death to Smoochy'*/
SELECT CONCAT(first, ' ', last) FROM Actor, Movie, MovieActor WHERE Actor.id = MovieActor.aid AND Movie.id = MovieActor.mid AND Movie.title = 'Death to Smoochy';
/*this query select the count of all directors who direct at least 4 movies*/
SELECT COUNT(*) FROM (SELECT COUNT(mid) FROM MovieDirector GROUP BY did HAVING COUNT(mid) >= 4) AS sub;
/*this query select the ids of all males who are both an actor and a director*/
SELECT a.id FROM Actor a, Director d WHERE a.id = d.id AND a.sex = 'Male';
/*this query select all the names of the movies whose rating in both IMDb and Rotten Tomatoes are more than 80*/
SELECT title FROM Movie, MovieRating WHERE Movie.id = MovieRating.mid AND imdb > 80 AND rot > 80;
