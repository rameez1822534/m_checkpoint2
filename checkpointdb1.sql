CREATE TABLE contacts (
   id SERIAL PRIMARY KEY ,
   first_name VARCHAR(30) NOT NULL ,
   last_name VARCHAR(50),
	title VARCHAR(30),
	organization VARCHAR(50)
   );
   
   CREATE TABLE contact_types (
   id SERIAL PRIMARY KEY ,
   contact_type VARCHAR(50) 
    );
   
   CREATE TABLE contact_categories (
   id SERIAL PRIMARY KEY ,
   contact_category VARCHAR(30) NOT NULL 
   );
   
  CREATE TABLE items (
   id SERIAL PRIMARY KEY,
   contact VARCHAR(50),
   contact_id INT REFERENCES contacts(id),
   contact_type INT REFERENCES contact_types(id),
   contact_category_id INT REFERENCES contact_categories(id)
);

   
   
 INSERT INTO public.contacts(
	 first_name, last_name, title, organization)
	VALUES 
			('Anna', 'Sundh', '', ''),
			('Goran', 'Bregovic', 'Coach', 'Dalens IK'),
			('Ann-Marie', 'Bergqvist', 'Cousin', ''),
			('Herman', 'Appelkvist', '', ''),
			;
   SELECT * FROM contacts
   
   
INSERT INTO contact_categories (contact_category)
VALUES ('Home'),
	('Work'),
	('Fax');
	
	
INSERT INTO contact_types (contact_type)
VALUES ('Email'),
		('Phone'),
		('Skype'),
		('Instagram')
;
   
INSERT INTO items (contact, contact_id, contact_type, contact_category_id)
VALUES ('011-12 33 45', 3, 2, 1),
('goran@infoab.se', 3, 1, 2),
('010 88 55 44', 4, 2, 2),
('erik57@hotmail.com', 1, 1, 1),
('@annapanna99', 2, 4, 1),
('077-563578', 2, 2, 1),
('077-156 22 78', 3, 2, 2);

--1.5Add two more rows into the contacts table, where one of them contains
--your own name.
INSERT INTO contacts (first_name, last_name, title, organization)
VALUES ('Khaqan', 'Yousaf', 'Student', 'Brights AB'),
('koko', 'momo', 'Student', 'Brights AB');

--1.6Create a query that lists if there are unused contact_types.

SELECT ct.id, ct.contact_type
FROM contact_types ct
LEFT JOIN items i ON ct.id = i.contact_type
WHERE i.contact_type IS NULL;

--1.7Create a VIEW view_contacts that lists the columns: first_name,
--last_name, contact, contact_type, contact_category.
CREATE VIEW view_contacts AS
SELECT 
	c.first_name,
	c.last_name ,
	i.contact,
	ct.contact_type,
	cc.contact_category
FROM contacts c
JOIN items i ON c.id = i.contact_id
JOIN contact_types ct ON i.contact_type = ct.id
JOIN contact_categories cc ON i.contact_category_id = cc.id;

SELECT * FROM view_contacts

--1.8Create a query that lists all information from the database in one big
--resulting table. The id columns should be invisible in the result.

SELECT c.first_name,
		c.last_name,
		c.title,
		c.organization,
		ct.contact_type,
		cc.contact_category
FROM contacts c

JOIN items i ON c.id = i.contact_id
JOIN contact_types ct ON i.contact_type = ct.id
JOIN contact_categories cc ON i.contact_category_id = cc.id;
