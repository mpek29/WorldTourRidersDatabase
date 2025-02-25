DROP TABLE IF EXISTS personne;
DROP TABLE IF EXISTS equipe;
DROP TABLE IF EXISTS coureur;
DROP TABLE IF EXISTS directeur_sportif;
DROP TABLE IF EXISTS soigneur;
DROP TABLE IF EXISTS sponsor;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS soin;
DROP TABLE IF EXISTS produit;
DROP TABLE IF EXISTS dose;
DROP TABLE IF EXISTS etape;
DROP TABLE IF EXISTS classement;

--creation de personne
CREATE TABLE personne (
	nom varchar (20),
	prenom varchar (20),
	datedenaissance TEXT
);

--creation de equipe
CREATE TABLE equipe (
	nom varchar(20),
	budget FLOAT
);

--creation de coureur
CREATE TABLE coureur (
	taille FLOAT,
	personne_id INTEGER,
	equipe_id INTEGER,
	FOREIGN KEY ( personne_id ) REFERENCES personnes,
	FOREIGN KEY ( equipe_id ) REFERENCES equipe
);

--creation de directeur sportif
CREATE TABLE directeur_sportif(
	personne_id INTEGER,
	equipe_id INTEGER,
	FOREIGN KEY ( personne_id ) REFERENCES personnes,
	FOREIGN KEY ( equipe_id ) REFERENCES equipe
);

--creation de soigneur
CREATE TABLE soigneur(
	nationalite varchar(20),
	personne_id INTEGER,
	FOREIGN KEY ( personne_id ) REFERENCES personnes
);

--creation de sponsor
CREATE TABLE sponsor(
	nom varchar(20),
	adresse varchar(30),
	domaineactivite varchar(20),
	equipe_id INTEGER,
	FOREIGN KEY ( equipe_id ) REFERENCES equipe
);

--creation de course
CREATE TABLE course(
	nom varchar(20),
	distancetotale FLOAT
);

--creation de soin
CREATE TABLE soin(
	soigneur_id INTEGER,
	equipe_id INTEGER,
	course_id INTEGER,
	FOREIGN KEY ( equipe_id ) REFERENCES equipe,
	FOREIGN KEY ( course_id ) REFERENCES course
);

--creation de produit
CREATE TABLE produit(
	numero INTEGER,
	nom varchar(20),
	indication varchar(30),
	contre_indication varchar(30),
	posologie varchar(30)
);

--creation de dose
CREATE TABLE dose(
	quantite FLOAT,
	produit_id INTEGER,
	soigneur_id INTEGER,
	FOREIGN KEY ( produit_id ) REFERENCES produit,
	FOREIGN KEY ( soigneur_id ) REFERENCES soigneur
);

--creation de etape
CREATE TABLE etape(
	numeroordre varchar(20),
	date TEXT,
	type varchar(30),
	villedepart varchar(20),
	villearivee varchar(20),
	course_id INTEGER,
	equipegagnante_id INTEGER,
	coureurgagnant_id INTEGER,
	FOREIGN KEY ( equipegagnante_id ) REFERENCES equipe,
	FOREIGN KEY ( coureurgagnant_id ) REFERENCES coureur
);

--creation de classement
CREATE TABLE classement(
	place varchar(10),
	etape_id INTEGER,
	coureur_id INTEGER,
	FOREIGN KEY ( etape_id ) REFERENCES etape,
	FOREIGN KEY ( coureur_id ) REFERENCES coureur
);