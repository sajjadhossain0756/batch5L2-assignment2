-- Active: 1747579820207@@127.0.0.1@5432@conservation_db
CREATE DATABASE conservation_db;
CREATE TABLE rangers (ranger_id SERIAL PRIMARY KEY,name VARCHAR(55),region VARCHAR(255));
INSERT INTO rangers (name,region) VALUES ('Alice Green','Northern Hills'),('Bob White','River Delta'),
('Carol King','Mountain Range'),('Meera','West Forest'),('shain Miah','South Forest');
SELECT * FROM rangers;
CREATE TABLE species (species_id SERIAL PRIMARY KEY,common_name VARCHAR(55),scientific_name VARCHAR(55),
discovery_date DATE,conservation_status VARCHAR(55));
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Giant Panda', 'Ailuropoda melanoleuca', '1869-01-01', 'Vulnerable'),
('Blue Whale', 'Balaenoptera musculus', '1758-01-01', 'Endangered'),
('Green Sea Turtle', 'Chelonia mydas', '1758-01-01', 'Endangered'),
('Orangutan', 'Pongo pygmaeus', '1766-01-01', 'Critically Endangered'),
('Grizzly Bear', 'Ursus arctos horribilis', '1815-01-01', 'Least Concern'),
('African Penguin', 'Spheniscus demersus', '1789-01-01', 'Endangered');
SELECT * FROM species;
CREATE TABLE sightings (sighting_id SERIAL PRIMARY KEY,ranger_id INT REFERENCES rangers(ranger_id),
species_id INT REFERENCES species(species_id),sighting_time TIMESTAMP WITHOUT TIME ZONE,location VARCHAR(255),
notes VARCHAR(255));
INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL), -- NULL for notes
(4, 1, 'Riverbed North', '2024-05-20 10:00:00', 'Heard trumpeting in distance'),
(1, 3, 'Bamboo Grove West', '2024-05-22 11:45:00', 'Slightly injured, reported to vet team'),
(6, 2, 'Ocean Vista Point', '2024-05-23 14:00:00', 'Pod of 3 observed moving south'),
(7, 5, 'Coastal Nesting Site', '2024-05-24 06:30:00', 'New hatchlings observed'),
(2, 1, 'Forest Canopy Trail', '2024-05-25 08:00:00', 'Mother with infant'),
(9, 2, 'Rocky Mountain Slope', '2024-05-26 09:30:00', 'Eating berries');
SELECT * FROM sightings;
-- Problem One;
INSERT INTO rangers (name,region) VALUES ('Derek Fox','Coastal Plains');
SELECT * FROM species;
-- Problem Two;
SELECT COUNT(DISTINCT species_id) as unique_species_cout FROM sightings; 
-- Problem Three;
SELECT * FROM sightings WHERE location ILIKE '%pass%';
-- Problems Four;
SELECT name,COUNT(sightings.ranger_id) as total_sightings FROM rangers
  JOIN sightings ON rangers.ranger_id = sightings.ranger_id GROUP BY name;
-- Problems Five;
SELECT common_name FROM species WHERE NOT EXISTS(SELECT species_id FROM sightings WHERE species_id = species.species_id);  
