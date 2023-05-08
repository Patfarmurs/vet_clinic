/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name like '%mon';

SELECT name from animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

SELECT name from animals WHERE neutered = 'true' AND escape_attempts < 3;

SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;

SELECT * from animals WHERE neutered = true;

SELECT * from animals WHERE name != 'Gabumon';

SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- start transaction 

BEGIN;

-- update the transaction

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

-- start another transaction

BEGIN;

-- update transaction

UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals
SET species = 'pokemon' WHERE species IS NULL;

SELECT * FROM animals;

-- commit transaction
COMMIT;
SELECT * FROM animals;

-- start another transaction

BEGIN;

-- Delete all transactions

DELETE FROM animals;
-- Return to previous state
ROLLBACK;
SELECT * FROM animals;

-- Start transaction
BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;

-- create a savepoint for weight_kg column
SAVEPOINT weight_kg;

UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;

-- Return to savepoint
ROLLBACK TO weight_kg;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;
SELECT * FROM animals;

-- Start transaction
BEGIN;

-- make  counts for animals
SELECT COUNT (*) FROM animals;

SELECT COUNT (*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- Multiple tables
SELECT name FROM animals JOIN owners ON owner_id =owner_id
WHERE fullname = 'Melody Pond';

SELECT * FROM animals JOIN species s ON species_id = s.id
WHERE s.name = 'Pokemon';

SELECT fullname AS owner, name AS pet FROM animals a
FULL JOIN owners o ON o.id = a.owner_id;

SELECT COUNT(a.name), s.name FROM animals a JOIN species s ON species_id = s.id
GROUP BY s.name;

SELECT a.name FROM animals a 
LEFT JOIN owners o ON o.id = a.owner_id
LEFT JOIN species s ON s.id = a.species_id
WHERE o.fullname = 'Jennifer' AND s.name = 'Digimon';

SELECT * FROM animals a
FULL JOIN owners o ON o.id = owner_id
WHERE o.fullname = 'Dean Winchester' AND escape_attempts = 0;

SELECT COUNT(*) as count, fullname FROM animals a
INNER JOIN owners o ON a.owner_id = o.id
GROUP BY o.fullname
ORDER BY count DESC;

SELECT a.name, a.species_id, v.date_of_visits FROM animals a 
JOIN visits v ON a.id = v.animal_id
JOIN vets ve ON v.vets_id = ve.id
WHERE ve.name = 'William Tatcher'
ORDER BY v.date_of_visits DESC
LIMIT 1;

SELECT COUNT(DISTINCT animals_id) FROM visits WHERE vets_id = 3;

SELECT vets.name, specie.name FROM vets LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN specie ON specializations.species_id = species.id;

SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id WHERE visits.vets_id = 3 AND visits.date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animal_id, count(*) FROM visits GROUP BY animal_id ORDER BY count(animal_id) DESC limit 1;

SELECT vets.name FROM vets JOIN visits ON vets.id = visits.vets_id WHERE visits.animals_id = 2 ORDER BY visits.date_of_visits LIMIT 1;

SELECT animals.name, vets.name, visits.date_of_visits FROM animals JOIN visits ON animals.id = visits.animals_id JOIN vets ON visits.vets_id = vets.id ORDER BY visits.date_of_visits DESC LIMIT 1;

SELECT COUNT(visits.animal_id) FROM visits JOIN animals ON visits.animal_id = animals.id JOIN vets ON visits.vets_id = vets.id LEFT JOIN specializations ON vets.id = specializations.vets_id LEFT JOIN specie ON specializations.species_id = species.id WHERE specie.id != animals.species_id;

select species_id from animals where id = (select animals_id from visits where vets_id = 2 group by animals_id order by count(animals_id) desc limit 1); 
