CREATE DATABASE IF NOT EXISTS yelp;

SET GLOBAL local_infile = 1; 

use yelp;

CREATE TABLE review_notext
(
    rid int,
    review_id varchar(100),
    business_id varchar(100),
    user_id varchar(100),
    stars int,
    date date,
    userful_votes int,
    funny_votes int,
    cool_votes int
);

LOAD DATA LOCAL INFILE '/Users/noahpelberg/Desktop/school/masters/760/yelp_academic_dataset_review_notext.csv'
INTO TABLE yelp.review_notext
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 ROWS
(rid,review_id,business_id,user_id,stars,date,userful_votes,funny_votes,cool_votes);

# repeat the same for category table 

CREATE TABLE category
(
    cid int,
    business_id varchar(100),
    category_name varchar(100)
);


LOAD DATA LOCAL INFILE '/Users/noahpelberg/Desktop/school/masters/760/yelp_academic_dataset_category.csv'
INTO TABLE yelp.category
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(cid, business_id, category_name);

CREATE TABLE business
(
    bid int,
    business_id varchar(100),
    name varchar(100),
    address varchar(150),
    city varchar(100),
    state varchar(100),
    postal_code varchar(50),
    latitude float,
    longitude float,
    stars float,
    review_count int,
    is_open int
);


#upload the business table from the csv file. replace the path with the path in your machine where the file is located

LOAD DATA LOCAL INFILE '/Users/noahpelberg/Desktop/school/masters/760/yelp_academic_dataset_business.csv'
INTO TABLE yelp.business
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
-- LINES TERMINATED BY '\r'
IGNORE 1 ROWS
(bid, business_id,name,address,city,state,postal_code,latitude,longitude,stars,review_count,is_open);

-- project code
select c.business_id, category_name, date, r.stars, b.city
from yelp.category as c
left join yelp.review_notext as r
on c.business_id = r.business_id
left join yelp.business as b
on r.business_id = b.business_id
where category_name like '%Coffee%';