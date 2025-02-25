SELECT et1.villedepart || '-' || et1.villearivee as 'Départ-Arrivée'
FROM etape et1
WHERE NOT EXISTS (
                  SELECT *
                  FROM coureur c,equipe eq
                  WHERE c.equipe_id=eq.rowid AND eq.nom='Vendée U'
                   AND NOT EXISTS (
                                   SELECT *
                                   FROM etape et2, classement cl
                                   WHERE cl.coureur_id = c.rowid  AND cl.etape_id = et1.rowid
                                   AND et1.rowid=et2.rowid
                                 )
);