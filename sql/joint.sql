-- les coureurs de l'équipe 'Vendée U'
SELECT p.nom
FROM equipe e, coureur c, personne p
WHERE e.rowid = c.equipe_id AND p.rowid = c.personne_id AND e.nom = 'Vendée U';

-- jointure entre toutes les tables ( renommage de colonnes de meme ... nom )
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