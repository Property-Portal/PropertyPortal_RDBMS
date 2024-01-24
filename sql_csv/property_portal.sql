CREATE TABLE `Agent` (
  `agent_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` CHAR(255) NOT NULL,
  `last_name` CHAR(255) NOT NULL,
  `email` CHAR(255) NOT NULL,
  `phone` CHAR(255) NOT NULL,
  PRIMARY KEY (`agent_id`)
);

CREATE TABLE `Property_Listing` (
  `property_id` INT NOT NULL AUTO_INCREMENT,
  `property_type` CHAR(255) NOT NULL,
  `address` CHAR(255) NOT NULL,
  `city` CHAR(255) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `zip_code` CHAR(5) NOT NULL,
  `price` NUMERIC(8) NOT NULL,
  `bedrooms` INT NOT NULL,
  `bathrooms` INT NOT NULL,
  `listing_date` CHAR(255) NOT NULL,
  `agent_id` INT NOT NULL,
  `property_status` CHAR(255) NOT NULL,
  PRIMARY KEY (`property_id`),
  FOREIGN KEY (`agent_id`) REFERENCES `Agent`(`agent_id`)
);

CREATE TABLE `Buyers` (
  `buyer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` CHAR(255) NOT NULL,
  `last_name` CHAR(255) NOT NULL,
  `email` CHAR(255) NOT NULL, 
  `phone` CHAR(255) NOT NULL,
  PRIMARY KEY (`buyer_id`)
);

CREATE TABLE `Transaction` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `buyer_id` INT NOT NULL,
  `agent_id` INT NOT NULL,
  `property_id` INT NOT NULL,
  `transaction_date` CHAR(255) NOT NULL,
  `sale_price` NUMERIC(8),
  PRIMARY KEY (`transaction_id`),
  FOREIGN KEY (`buyer_id`) REFERENCES `Buyers`(`buyer_id`),
  FOREIGN KEY (`agent_id`) REFERENCES `Agent`(`agent_id`),
  FOREIGN KEY (`property_id`) REFERENCES `Property_Listing`(`property_id`)
  );
  

/* Change file paths for loading data from local machine */
  LOAD DATA LOCAL INFILE 'C:/PropertyPortal/Agents.csv'
  INTO TABLE Agent
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;

/* Change file paths for loading data from local machine */
  LOAD DATA LOCAL INFILE 'C:/PropertyPortal/Buyers.csv'
  INTO TABLE Buyers
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;

/* Change file paths for loading data from local machine */
  LOAD DATA LOCAL INFILE 'C:/PropertyPortal/Property_Listing.csv'
  INTO TABLE Property_Listing
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS
  SET listing_date = STR_TO_DATE(listing_date, '%m/%d/%y');

/* Change file paths for loading data from local machine */
  LOAD DATA LOCAL INFILE 'C:/PropertyPortal/Transactions.csv'
  INTO TABLE Transaction
  FIELDS TERMINATED BY ','
  OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS
  (@var1, buyer_id, agent_id, property_id, @var2, sale_price)
  SET
  transaction_date = STR_TO_DATE(@var2, '%m/%d/%y');
