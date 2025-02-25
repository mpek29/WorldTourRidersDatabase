.headers on
.mode column

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

.print "---------------------------------- CREATE TABLE  ----------------------------------------------"
CREATE TABLE personne (
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    nom varchar (20),
    prenom varchar (20),
    datedenaissance TEXT
);

CREATE TABLE equipe (
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    nom varchar(20),
    budget FLOAT
);

CREATE TABLE coureur (
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    taille FLOAT,
    personne_id INTEGER,
    equipe_id INTEGER,
    FOREIGN KEY ( personne_id ) REFERENCES personnes,
    FOREIGN KEY ( equipe_id ) REFERENCES equipe
);

CREATE TABLE directeur_sportif(
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    personne_id INTEGER,
    equipe_id INTEGER,
    FOREIGN KEY ( personne_id ) REFERENCES personnes,
    FOREIGN KEY ( equipe_id ) REFERENCES equipe
);

CREATE TABLE soigneur(
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    nationalite varchar(20),
    personne_id INTEGER,
    FOREIGN KEY ( personne_id ) REFERENCES personnes
);

CREATE TABLE sponsor(
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    nom varchar(20),
    adresse varchar(30),
    domaineactivite varchar(20),
    equipe_id INTEGER,
    FOREIGN KEY ( equipe_id ) REFERENCES equipe
);

CREATE TABLE course(
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    nom varchar(20),
    distancetotale FLOAT
);

CREATE TABLE soin(
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    soigneur_id INTEGER,
    equipe_id INTEGER,
    course_id INTEGER,
    FOREIGN KEY ( equipe_id ) REFERENCES equipe,
    FOREIGN KEY ( course_id ) REFERENCES course
);

CREATE TABLE produit(
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    numero INTEGER,
    nom varchar(20),
    indication varchar(30),
    contre_indication varchar(30),
    posologie varchar(30)
);

CREATE TABLE dose(
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    quantite FLOAT,
    produit_id INTEGER,
    soigneur_id INTEGER,
    FOREIGN KEY ( produit_id ) REFERENCES produit,
    FOREIGN KEY ( soigneur_id ) REFERENCES soigneur
);

CREATE TABLE etape(
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
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

CREATE TABLE classement(
    --id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    place varchar(10),
    etape_id INTEGER,
    coureur_id INTEGER,
    FOREIGN KEY ( etape_id ) REFERENCES etape,
    FOREIGN KEY ( coureur_id ) REFERENCES coureur
);

.print "---------------------------------- INSERT INTO ... VALUES() ... -------------------------------------------"

INSERT INTO personne ( prenom , nom , datedenaissance ) VALUES ( 'Thomas' , 'Voeckler' , '22-06-1979');
INSERT INTO personne ( prenom , nom , datedenaissance ) VALUES ( 'Morgan' , 'Lamoisson' , '07-09-1988');
INSERT INTO personne ( prenom , nom , datedenaissance ) VALUES ( 'Jean' , 'Dupont' , '04-03-1960');

INSERT INTO equipe ( nom, budget ) VALUES ( 'Vendée U', 80000.15);

INSERT INTO coureur(taille, personne_id, equipe_id) VALUES (
    1.80,
    (SELECT rowid FROM personne WHERE prenom="Thomas" AND nom="Voeckler"),
    (SELECT rowid FROM equipe WHERE nom="Vendée U"));

INSERT INTO directeur_sportif ( personne_id , equipe_id ) VALUES (
    (SELECT rowid FROM personne WHERE prenom = 'Morgan' AND nom = 'Lamoisson'),
    (SELECT rowid FROM equipe WHERE nom = 'Vendée U'));

INSERT INTO soigneur ( nationalite, personne_id) VALUES (
    'Francais',
    (SELECT rowid FROM personne WHERE prenom = 'Jean' AND nom = 'Dupont'));

INSERT INTO sponsor ( nom, adresse, domaineactivite, equipe_id ) VALUES ( 'Système U',
    '20 RUE D ARCUEIL PARC TERTIAIRE SILIC BATIMENT MO 94150 RUNGIS',
    'Grande distribution',
    (SELECT rowid FROM equipe WHERE nom = 'Vendée U'));

INSERT INTO course ( nom, distancetotale ) VALUES ( 'Tour de France',  3328); --faire une requete faisant la somme de toute ses etapes 

INSERT INTO soin ( soigneur_id, equipe_id, course_id ) VALUES (
    (SELECT s.rowid FROM personne p CROSS JOIN soigneur s WHERE prenom = 'Jean' AND nom = 'Dupont' AND s.personne_id = p.rowid),
    (SELECT rowid FROM equipe WHERE nom = 'Vendée U'),
    (SELECT rowid FROM course WHERE nom = 'Tour de France'));

INSERT INTO produit ( numero, nom, indication, contre_indication, posologie ) VALUES ( 1547,
    'Salbutamol',
    'douleur musculaire',
    'ne pas administrer en dessous de 20 ans',
    '1 comprimé par jour');

INSERT INTO dose ( quantite, produit_id, soigneur_id ) VALUES ( '2.85',
    (SELECT rowid FROM produit WHERE nom = 'Salbutamol'),
    (SELECT s.rowid FROM personne p CROSS JOIN soigneur s WHERE prenom = 'Jean' AND nom = 'Dupont' AND s.personne_id = p.rowid));

INSERT INTO etape ( numeroordre, date, type, villedepart, villearivee, course_id, equipegagnante_id, coureurgagnant_id ) VALUES (
    '1re étape',
    '15-01-2015',
    'Contre la montre individuel',
    'Lorient',
    'Brest',
    (SELECT rowid FROM course WHERE nom = 'Tour de France'),
    (SELECT rowid FROM equipe WHERE nom = 'Vendée U'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Thomas' AND nom = 'Voeckler' AND c.personne_id = p.rowid));

INSERT INTO classement ( place, etape_id, coureur_id ) VALUES (
    '1er',
    (SELECT rowid FROM etape WHERE numeroordre = '1re étape'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Thomas' AND nom = 'Voeckler' AND c.personne_id = p.rowid));

.print "---------------------------------- UPDATE  ... SET ... WHERE ... -------------------------------------"

UPDATE coureur
SET taille = 1.82
WHERE personne_id = (SELECT rowid FROM personne WHERE nom = 'Thomas' AND prenom = 'Voeckler');

UPDATE soigneur
SET nationalite = 'Allemand/Francais'
WHERE personne_id = (SELECT rowid FROM personne WHERE nom = 'Jean' AND prenom = 'Dupont');

UPDATE sponsor
SET adresse = '2bis rue Louis Armand, 75015 PARIS'
WHERE nom = 'Système U';

.print "--- JOINTURE : entre toutes les tables -------------------------------------"
SELECT DISTINCT per.nom AS "NOM",
                 per.prenom AS "PRENOM",
                 per.datedenaissance,
                 eq.nom AS "EQUIPE",
                 eq.budget,
                 cr.taille ,
                 sg.nationalite,
                 spon.nom AS "SPONSOR",
                 spon.adresse,
                 spon.domaineactivite ,
                 cs.nom AS "COURSE",
                 cs.distancetotale ,
                 pro.numero,
                 pro.nom  AS "PRODUIT",
                 pro.indication,
                 pro.contre_indication,
                 pro.posologie,
                 do.quantite AS "DOSE",
                 et.numeroordre AS "ETAPE",
                 et.date,
                 et.type,
                 et.villedepart,
                 et.villearivee,
                 cla.place AS "CLASSEMENT"
FROM personne per, equipe eq ,coureur cr,
     directeur_sportif ds, soigneur sg, sponsor spon,
     course cs, soin s, produit pro, dose do, etape et,
     classement cla
WHERE per.rowid = cr.personne_id
 AND eq.rowid = cr.equipe_id
-- AND per.rowid = ds.personne_id
 AND eq.rowid = ds.equipe_id
-- AND per.rowid = sg.personne_id
 AND eq.rowid = spon.equipe_id
 AND sg.rowid = s.soigneur_id
 AND eq.rowid = s.equipe_id
 AND cs.rowid = s.course_id
 AND pro.rowid = do.produit_id
 AND sg.rowid = do.soigneur_id
 AND cs.rowid = et.course_id
 AND eq.rowid = et.equipegagnante_id
 AND cr.rowid = et.coureurgagnant_id
 AND et.rowid = cla.etape_id
 AND cr.rowid = cla.coureur_id;

.print "-------------------ETAT DE LA BASE DE DONNEES   -------------------------------------"
.print "---------- les entreprises" ------------"
SELECT * FROM entreprises;
.print "---------- les departements" ------------"
SELECT * FROM departements;
.print "---------- les personnes" ------------"
SELECT * FROM personnes;
.print "---------- les contacts" ------------"
SELECT * FROM contacts;
.print "---------- les employes" ------------"
SELECT * FROM employes;
.print "---------- les postes" ------------"
SELECT * FROM postes;

.print "---------------------------------- REQUETES    -------------------------------------"


.print "Q1 : Nom et capital pour les entreprises dont le capital est compris entre 0.00 € et 10000.00 €"
SELECT nom, capital
FROM entreprises
WHERE capital BETWEEN 0.00 AND 10000.00;

.print "Q2 :Nom de tous les départements de l’entreprise 'BIEN'"
SELECT d.nom
FROM entreprises e INNER JOIN departements d ON ( e.rowid=d.entreprise_id)
WHERE e.nom='BIEN';

.print "Q3 : Le nom des personnes qui ne sont pas des employés de l’entreprise 'BIEN'"
SELECT nom
FROM personnes
WHERE rowid NOT IN (
                    SELECT emp.personne_id
                    FROM entreprises e INNER JOIN employes emp ON (e.rowid=emp.entreprise_id)
                    WHERE e.nom='BIEN'
);

.print "Q4 : La personne qui serait responsable de tous les départements de l’ entreprise 'BIEN'"
SELECT DISTINCT p.nom
FROM personnes p,employes e1 INNER JOIN employes emp ON (p.rowid=e1.personne_id)
WHERE NOT EXISTS (
                  SELECT *
                  FROM departements d,entreprises e
                  WHERE d.entreprise_id=e.rowid AND e.nom='BIEN'
                   AND NOT EXISTS (
                                   SELECT *
                                   FROM employes e2
                                   WHERE e2.personne_id=d.responsable_id
                                   AND e1.personne_id=e2.personne_id
                                 )
);
.print "Q5 : Le salaire moyen des employes 'MdC' de l’entreprise 'BIEN'"
SELECT AVG ( salaire )
FROM employes emp INNER JOIN entreprises e ON (e.rowid=emp.entreprise_id)
WHERE e.nom='BIEN'
  AND poste_id IN (
                   SELECT rowid
                   FROM postes
                   WHERE nom='MdC'

);

.print "Q6 : le nom des employés qui ont le plus gros salaire dans l’entreprise 'BIEN'"
DROP VIEW SALAIRE_BIEN;

CREATE VIEW SALAIRE_BIEN AS
SELECT salaire
FROM entreprises e INNER JOIN employes emp ON (e.rowid=emp.entreprise_id)
WHERE e.nom='BIEN';

SELECT p.nom
FROM personnes p INNER JOIN employes emp ON (p.rowid=emp.personne_id)
INNER JOIN entreprises e ON (e.rowid=emp.entreprise_id)
WHERE e.nom='BIEN'
AND salaire=(SELECT MAX (salaire) FROM SALAIRE_BIEN);

.print "Q7 : Le nombre de postes par département dans l’entreprise 'BIEN'"
SELECT count (p.rowid)
FROM entreprises e INNER JOIN departements d ON (e.rowid=d.entreprise_id)
INNER JOIN postes p ON (p.departement_id=d.rowid)
WHERE e.nom='BIEN'
GROUP BY p.departement_id;

.print "Q8 : Le nombre d’employes par poste dans l’entreprise 'BIEN' dont le salaire minimum est inférieur au salaire moyen  dans l’entreprise 'BIEN'"

SELECT p.rowid, count(emp.rowid)
FROM entreprises e INNER JOIN employes emp ON (e.rowid=emp.entreprise_id)
                   INNER JOIN postes p ON (emp.poste_id=p.rowid)
WHERE e.nom='BIEN'
GROUP BY p.rowid;

SELECT p.rowid, count(emp.rowid)
FROM entreprises e INNER JOIN employes emp ON (e.rowid=emp.entreprise_id)
                   INNER JOIN postes p ON (emp.poste_id=p.rowid)
WHERE e.nom='BIEN' AND salaire < (SELECT AVG (salaire) FROM entreprises e INNER JOIN employes emp ON (e.rowid=emp.entreprise_id))
GROUP BY p.rowid;

print "Q8 : Le nombre d’employes par poste dans l’entreprise 'BIEN' lorsque ce nombre  est supérieur ou égal à la moyenne des postes de
l’entreprise 'BIEN'"

SELECT p.rowid, count(emp.rowid)
FROM entreprises e INNER JOIN employes emp ON (e.rowid=emp.entreprise_id)
                   INNER JOIN postes p ON (emp.poste_id=p.rowid)
WHERE e.nom='BIEN'
GROUP BY p.rowid
HAVING COUNT(emp.rowid) >= (
                           SELECT AVG(emp.rowid)
                           FROM entreprises e INNER JOIN employes emp ON (e.rowid=emp.entreprise_id)
                           WHERE  e.nom='BIEN'
);

