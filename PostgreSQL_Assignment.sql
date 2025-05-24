-- Active: 1747579820207@@127.0.0.1@5432@conservation_db
CREATE DATABASE conservation_db;
CREATE TABLE rangers (ranger_id SERIAL PRIMARY KEY,name VARCHAR(55),region VARCHAR(255));
CREATE TABLE species (species_id SERIAL PRIMARY KEY,common_name VARCHAR(55),scientific_name VARCHAR(55),
discovery_date DATE,conservation_status VARCHAR(55));
CREATE TABLE sightings (sighting_id SERIAL PRIMARY KEY,ranger_id INT REFERENCES rangers(ranger_id),
species_id INT REFERENCES species(species_id),sighting_time TIMESTAMP WITHOUT TIME ZONE,location VARCHAR(255),
notes VARCHAR(255));