UPDATE coureur
SET taille = 1.82
WHERE personne_id = (SELECT rowid FROM personne WHERE nom = 'Thomas' AND prenom = 'Voeckler');

UPDATE soigneur
SET nationalite = 'Allemand/Francais'
WHERE personne_id = (SELECT rowid FROM personne WHERE nom = 'Jean' AND prenom = 'Dupont');

UPDATE sponsor
SET adresse = '2bis rue Louis Armand, 75015 PARIS'
WHERE nom = 'Système U';