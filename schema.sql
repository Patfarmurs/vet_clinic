/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT ,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(150);

CREATE TABLE owners (
    id       SERIAL PRIMARY KEY,
    fullname VARCHAR(200) NOT NULL,
    age      INT NOT NULL
);

CREATE TABLE specie (
    id  SERIAL PRIMARY KEY,
    name  VARCHAR(200) NOT NULL
);


CREATE TABLE vets (id INT Generated ALWAYS AS IDENTITY PRIMARY KEY, 
name VARCHAR(100), 
age INT, 
date_of_graduation DATE);

CREATE TABLE specializations (species_id INT CONSTRAINT fk_specializations_species_id REFERENCES species(id), vet_id INT CONSTRAINT fk_vet_id REFERENCES vets(id));

CREATE TABLE visits (animal_id INT CONSTRAINT fk_animal_id REFERENCES animals(id), vet_id INT CONSTRAINT fk_visits_vet_id REFERENCES vets(id), visited_date date NOT NULL DEFAULT CURRENT_DATE);


ALTER TABLE animals DROP COLUMN id;

ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY;


ALTER TABLE animals DROP COLUMN species;


ALTER TABLE animals  ADD COLUMN species_id INT,
ADD FOREIGN KEY (species_id) REFERENCES specie(id);

ALTER TABLE animals ADD COLUMN species_id INT,
ADD FOREIGN KEY (owner_id) REFERENCES owners(id);
