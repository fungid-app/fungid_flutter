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