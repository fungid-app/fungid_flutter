SELECT COUNT(*) FROM classifier_observations

CREATE TABLE classifier_species_images (familykey INTEGER, genuskey INTEGER, specieskey INTEGER, gbifid INTEGER, imgid INTEGER, 
	external_url VARCHAR COLLATE NOCASE, rights_holder VARCHAR COLLATE NOCASE, creator VARCHAR COLLATE NOCASE, license VARCHAR COLLATE NOCASE
);


INSERT INTO classifier_species_images (specieskey, genuskey, familykey, 
		gbifid, imgid, external_url, rights_holder, creator, license)
SELECT specieskey, genuskey, familykey, 
		gbifid, imgid, external_url, rights_holder, creator, license
FROM (
	SELECT cs.specieskey, cs.genuskey, cs.familykey, 
		co.gbifid, goi.imgid, goi.external_url, goi.rights_holder, goi.creator, goi.license,
		ROW_NUMBER () OVER ( 
	        PARTITION BY cs.specieskey
	        ORDER BY imgid, gbifid DESC
    	) RowNum
	FROM classifier_species cs
	JOIN classifier_observations co ON co.specieskey = cs.specieskey 
	JOIN gbif_observation_images goi ON goi.observation_id = co.gbifid 
) 
WHERE RowNum <= 100;

DROP TABLE classifier_names;
CREATE TABLE classifier_names (specieskey int, name VARCHAR COALLATE NOCASE, lang VARCHAR COALLATE NOCASE);

INSERT INTO classifier_names (specieskey, name, lang)
SELECT cs.specieskey, cn.name, cn."language" 
FROM common_names cn 
JOIN species s ON s.id = cn.species_id
JOIN classifier_species cs ON s.species = cs.species; 

DROP TABLE classifier_species_props;
CREATE TABLE classifier_species_props(specieskey INTEGER, prop VARCHAR COALLATE NOCASE, value VARCHAR COALLATE NOCASE, datasource VARCHAR COALLATE NOCASE, 
			PRIMARY KEY (specieskey, prop, value));
		
INSERT INTO classifier_species_props (specieskey, prop, value, datasource)
SELECT cs.specieskey, cn.prop, cn.value, cn."source" 
FROM mapped_props cn 
JOIN classifier_species cs ON cn.species = cs.species; 


DROP TABLE classifier_observations;

DROP TABLE gbif_observation_images;

DROP TABLE mapped_props;
DROP TABLE species;
DROP TABLE common_names;

VACUUM;