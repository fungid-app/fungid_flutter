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


SELECT prop, value FROM classifier_species_props css GROUP BY 1,2 ORDER BY 1,2


SELECT prop, value, MAX(species) 
FROM classifier_species_props css
JOIN classifier_species cs  ON css.specieskey  = cs.specieskey 
GROUP BY 1, 2 ORDER BY 1, 2;

SELECT prop, stat, MAX(species) FROM classifier_species_stats css GROUP BY 1, 2 ORDER BY 1, 2;



SELECT * FROM classifier_species_stats css WHERE value is null;

SELECT * FROM classifier_species cs ;

SELECT * FROM classifier_species cs  ;

SELECT * FROM classifier_names cn;

SELECT * FROM classifier_species_images csi;


DELETE FROM classifier_names;

DROP TABLE names;

INSERT INTO classifier_names (specieskey, name, lang) 
SELECT specieskey, n.commonname, lng
FROM names n
JOIN classifier_species s ON s.species = n.species;



CREATE TABLE IF NOT EXISTS classifier_species_stats2(
	specieskey INTEGER NOT NULL, 
	stat VARCHAR COLLATE NOCASE, 
	value VARCHAR COLLATE NOCASE, 
	likelihood FLOAT
);


INSERT INTO classifier_species_stats2
SELECT cs.specieskey, css.stat, css.value, css.likelihood
FROM classifier_species_stats css 
JOIN classifier_species cs  ON cs.species  = css.species;


-- GENERATING image file
-- FROM gbif.sqlite3

CREATE TABLE classifier_species_images (
	specieskey INTEGER,
	gbifid INTEGER,
	imgid INTEGER,
	external_url VARCHAR,
	rights_holder VARCHAR,
	creator VARCHAR,
	license VARCHAR,
	PRIMARY KEY(specieskey, gbifid, imgid)
);

INSERT INTO classifier_species_images
SELECT t2.specieskey, t.gbifid, t.imgid, m.identifier AS external_url, t3.rightsholder AS rights_holder, t3.creator, t3.license
FROM trainingimages t  
JOIN multimedia m ON t.gbifid  = m.gbifid  AND m.imgid  = t.imgid 
JOIN trainingspecies t2 ON t.specieskey = t2.specieskey 
JOIN occurrence t3 ON t3.gbifid = t.gbifid 
WHERE t.rank <= 100;


DROP TABLE classifier_species_images;



identificationqualifier, 
identificationreferences,
identificationverificationstatus,
occurrencestatus,


