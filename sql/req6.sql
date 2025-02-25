SELECT p.prenom || ' ' || p.nom AS "coureur", count(cla.rowid) AS "nombre de classement"
FROM coureur cr, classement cla, equipe e, personne p
WHERE e.nom='Vendée U' AND cla.coureur_id = cr.rowid and cr.equipe_id = e.rowid and cr.personne_id = p.rowid
GROUP BY p.nom;