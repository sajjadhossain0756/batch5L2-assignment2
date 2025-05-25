-- Active: 1747579820207@@127.0.0.1@5432@conservation_db

-- Problem One;
INSERT INTO rangers (name,region) VALUES ('Derek Fox','Coastal Plains');

-- Problem Two;
SELECT COUNT(DISTINCT species_id) as unique_species_cout FROM sightings; 

-- Problem Three;
SELECT * FROM sightings WHERE location ILIKE '%pass%';

-- Problems Four;
SELECT name,COUNT(sightings.ranger_id) as total_sightings FROM rangers
  JOIN sightings ON rangers.ranger_id = sightings.ranger_id GROUP BY name;

-- Problems Five;
SELECT common_name FROM species WHERE NOT EXISTS(SELECT species_id FROM sightings 
WHERE species_id = species.species_id);

-- Problems Six;
SELECT common_name, sighting_time,name FROM sightings s
JOIN species sp ON sp.species_id = s.species_id 
JOIN rangers r ON r.ranger_id = s.ranger_id ORDER BY sighting_time DESC LIMIT 2;  

-- Problems Seven;
UPDATE species
  SET conservation_status = 'Historic'
  WHERE EXTRACT(year FROM discovery_date) > 1800;

-- Problems Eight;
CREATE or REPLACE FUNCTION time_of_day(hour NUMERIC)
RETURNS VARCHAR(255)
LANGUAGE plpgsql
AS
$$
  BEGIN
      IF hour >= 0 AND hour < 12 THEN
        RETURN 'Morning';
      ELSIF hour >= 12 AND hour < 17 THEN
        RETURN 'Afternoon';
      ELSIF hour >= 17 AND hour <= 23 THEN  
        RETURN 'Evening'; 
      ELSE 
        RETURN 'Not a valid Hour';
      END IF;    
  END;
$$;
SELECT sighting_id,time_of_day(EXTRACT(HOUR FROM sighting_time)) 
FROM sightings;

-- Problems Nine;
DELETE FROM rangers 
WHERE ranger_id NOT IN(SELECT ranger_id FROM sightings);
