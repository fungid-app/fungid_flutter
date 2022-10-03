CREATE TABLE classifier_species_images (
    specieskey INTEGER,
    gbifid INTEGER,
    imgid INTEGER,
    rights_holder VARCHAR,
    creator VARCHAR,
    license VARCHAR,
    PRIMARY KEY(specieskey, gbifid, imgid)
);
 	
INSERT INTO classifier_species_images
SELECT t2.specieskey, t.gbifid, t.imgid, t3.rightsholder AS rights_holder, t3.creator, 
    CASE t3.license
        WHEN CC0_1_0 THEN 0
        WHEN CC_BY_4_0 THEN 1
        WHEN CC_BY_NC_4_0 THEN 2
    END AS license
FROM trainingimages t  
JOIN multimedia m ON t.gbifid  = m.gbifid  AND m.imgid  = t.imgid 
JOIN trainingspecies t2 ON t.specieskey = t2.specieskey 
JOIN occurrence t3 ON t3.gbifid = t.gbifid 
WHERE t.rank <= 100; 