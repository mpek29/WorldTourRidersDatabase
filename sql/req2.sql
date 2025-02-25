SELECT p.prenom || ' ' || p.nom AS "coureur", taille
FROM coureur c, equipe e, personne p
WHERE c.equipe_id = e.rowid AND e.nom = 'Vendée U' and c.personne_id = p.rowid;