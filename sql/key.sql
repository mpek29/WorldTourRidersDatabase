--creation de coureur
CREATE TABLE coureur (
	taille FLOAT,
	personne_id INTEGER,
	equipe_id INTEGER,
	FOREIGN KEY ( personne_id ) REFERENCES personnes,
	FOREIGN KEY ( equipe_id ) REFERENCES equipe
);

-- postes primary key : rowid
SELECT rowid from coureur ;
rowid
-- ---
1
2
...