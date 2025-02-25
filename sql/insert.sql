-- insertion de personne
INSERT INTO personne ( prenom , nom , datedenaissance ) VALUES ( 'Bernard' , 'Hinault' , '14-11-1954');
INSERT INTO personne ( prenom , nom , datedenaissance ) VALUES ( 'Thomas' , 'Voeckler' , '22-06-1979');
INSERT INTO personne ( prenom , nom , datedenaissance ) VALUES ( 'Bryan' , 'Coquard' , '25-04-1992');
INSERT INTO personne ( prenom , nom , datedenaissance ) VALUES ( 'Morgan' , 'Lamoisson' , '07-09-1988');
INSERT INTO personne ( prenom , nom , datedenaissance ) VALUES ( 'Jean' , 'Dupont' , '04-03-1960');

-- insertion de equipe
INSERT INTO equipe ( nom, budget ) VALUES ( 'Vendée U', 80000.15);
INSERT INTO equipe ( nom, budget ) VALUES ( 'Gitane-Campagnolo', 40010.25);

-- insertion de coureur
INSERT INTO coureur(taille, personne_id, equipe_id) VALUES (
    1.70,
    (SELECT rowid FROM personne WHERE prenom="Thomas" AND nom="Voeckler"),
    (SELECT rowid FROM equipe WHERE nom="Vendée U"));

INSERT INTO coureur(taille, personne_id, equipe_id) VALUES (
    1.75,
    (SELECT rowid FROM personne WHERE prenom="Bryan" AND nom="Coquard"),
    (SELECT rowid FROM equipe WHERE nom="Vendée U"));

INSERT INTO coureur(taille, personne_id, equipe_id) VALUES (
    1.80,
    (SELECT rowid FROM personne WHERE prenom="Bernard" AND nom="Hinault"),
    (SELECT rowid FROM equipe WHERE nom="Gitane-Campagnolo"));

-- insertion de directeur sportif
INSERT INTO directeur_sportif ( personne_id , equipe_id ) VALUES (
	(SELECT rowid FROM personne WHERE prenom = 'Morgan' AND nom = 'Lamoisson'),
	(SELECT rowid FROM equipe WHERE nom = 'Vendée U'));

-- insertion de soigneur
INSERT INTO soigneur ( nationalite, personne_id) VALUES (
	'Francais',
	(SELECT rowid FROM personne WHERE prenom = 'Jean' AND nom = 'Dupont'));

-- insertion de sponsor
INSERT INTO sponsor ( nom, adresse, domaineactivite, equipe_id ) VALUES ( 'Système U',
    '20 RUE D ARCUEIL PARC TERTIAIRE SILIC BATIMENT MO 94150 RUNGIS',
    'Grande distribution',
    (SELECT rowid FROM equipe WHERE nom = 'Vendée U'));

INSERT INTO sponsor ( nom, adresse, domaineactivite, equipe_id ) VALUES ( 'Département Vendée',
    '2 Av. Gordon Bennett, 75016 Paris',
    'Département',
    (SELECT rowid FROM equipe WHERE nom = 'Vendée U'));

-- insertion de course
INSERT INTO course ( nom, distancetotale ) VALUES ( 'Tour de France',  3000);
INSERT INTO course ( nom, distancetotale ) VALUES ( 'Tour d Espagne',  1000);

-- insertion de soin
INSERT INTO soin ( soigneur_id, equipe_id, course_id ) VALUES (
	(SELECT s.rowid FROM personne p CROSS JOIN soigneur s WHERE prenom = 'Jean' AND nom = 'Dupont' AND s.personne_id = p.rowid),
	(SELECT rowid FROM equipe WHERE nom = 'Vendée U'),
	(SELECT rowid FROM course WHERE nom = 'Tour de France'));

-- insertion de produit
INSERT INTO produit ( numero, nom, indication, contre_indication, posologie ) VALUES ( 1547,
	'Salbutamol',
	'douleur musculaire',
	'ne pas administrer en dessous de 20 ans',
	'1 comprimé par jour');

-- insertion de dose
INSERT INTO dose ( quantite, produit_id, soigneur_id ) VALUES ( '2.85',
	(SELECT rowid FROM produit WHERE nom = 'Salbutamol'),
	(SELECT s.rowid FROM personne p CROSS JOIN soigneur s WHERE prenom = 'Jean' AND nom = 'Dupont' AND s.personne_id = p.rowid));

-- insertion de etape
INSERT INTO etape ( numeroordre, date, type, villedepart, villearivee, course_id, equipegagnante_id, coureurgagnant_id ) VALUES (
    '1re étape',
    '15-01-2015',
    'Contre la montre individuel',
    'Lorient',
    'Brest',
    (SELECT rowid FROM course WHERE nom = 'Tour de France'),
    (SELECT rowid FROM equipe WHERE nom = 'Vendée U'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Thomas' AND nom = 'Voeckler' AND c.personne_id = p.rowid));

INSERT INTO etape ( numeroordre, date, type, villedepart, villearivee, course_id, equipegagnante_id, coureurgagnant_id ) VALUES (
    '2nd étape',
    '16-02-2015',
    'Course en ligne',
    'Brest',
    'Lannion',
    (SELECT rowid FROM course WHERE nom = 'Tour de France'),
    NULL,
    NULL);

INSERT INTO etape ( numeroordre, date, type, villedepart, villearivee, course_id, equipegagnante_id, coureurgagnant_id ) VALUES (
    '3ème étape',
    '17-02-2015',
    'Course en ligne',
    'Lannion',
    'Rennes',
    (SELECT rowid FROM course WHERE nom = 'Tour de France'),
    NULL,
    NULL);

INSERT INTO etape ( numeroordre, date, type, villedepart, villearivee, course_id, equipegagnante_id, coureurgagnant_id ) VALUES (
    '4ème étape',
    '18-02-2015',
    'Course en ligne',
    'Rennes',
    'Nantes',
    (SELECT rowid FROM course WHERE nom = 'Tour de France'),
    NULL,
    NULL);

-- insertion de classement
INSERT INTO classement ( place, etape_id, coureur_id ) VALUES (
    '1er',
    (SELECT rowid FROM etape WHERE numeroordre = '1re étape'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Thomas' AND nom = 'Voeckler' AND c.personne_id = p.rowid));

INSERT INTO classement ( place, etape_id, coureur_id ) VALUES (
    '3ème',
    (SELECT rowid FROM etape WHERE numeroordre = '3ème étape'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Thomas' AND nom = 'Voeckler' AND c.personne_id = p.rowid));

INSERT INTO classement ( place, etape_id, coureur_id ) VALUES (
    '2nd',
    (SELECT rowid FROM etape WHERE numeroordre = '2nd étape'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Thomas' AND nom = 'Voeckler' AND c.personne_id = p.rowid));

INSERT INTO classement ( place, etape_id, coureur_id ) VALUES (
    '4ème',
    (SELECT rowid FROM etape WHERE numeroordre = '4ème étape'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Thomas' AND nom = 'Voeckler' AND c.personne_id = p.rowid));

INSERT INTO classement ( place, etape_id, coureur_id ) VALUES (
    '2nd',
    (SELECT rowid FROM etape WHERE numeroordre = '1re étape'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Bernard' AND nom = 'Hinault' AND c.personne_id = p.rowid));

INSERT INTO classement ( place, etape_id, coureur_id ) VALUES (
    '1er',
    (SELECT rowid FROM etape WHERE numeroordre = '3ème étape'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Bernard' AND nom = 'Hinault' AND c.personne_id = p.rowid));

INSERT INTO classement ( place, etape_id, coureur_id ) VALUES (
    '1er',
    (SELECT rowid FROM etape WHERE numeroordre = '2nd étape'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Bernard' AND nom = 'Hinault' AND c.personne_id = p.rowid));

INSERT INTO classement ( place, etape_id, coureur_id ) VALUES (
    '3ème',
    (SELECT rowid FROM etape WHERE numeroordre = '1re étape'),
    (SELECT c.rowid FROM coureur c CROSS JOIN personne p WHERE prenom = 'Bryan' AND nom = 'Coquard' AND c.personne_id = p.rowid));