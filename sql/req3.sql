SELECT s.nom FROM sponsor s, equipe e WHERE e.nom = 'Vendée U' AND s.equipe_id = e.rowid
EXCEPT
SELECT s.nom FROM sponsor s, equipe e WHERE e.nom = 'Vendée U' AND s.equipe_id = e.rowid AND s.domaineactivite = "Grande distribution";