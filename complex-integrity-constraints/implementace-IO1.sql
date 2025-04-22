CREATE OR REPLACE TRIGGER pocet_sad_trigger
    BEFORE INSERT OR UPDATE ON pobocka_sada_zbozi
    FOR EACH ROW
DECLARE
    pocet_sad INTEGER;
BEGIN

    SELECT COUNT(*)
    INTO pocet_sad
    FROM pobocka_sada_zbozi psz
    JOIN sada_spolecnost ss ON psz.id_sada_zbozi = ss.id_sada_zbozi
    WHERE psz.id_pobocka = :NEW.id_pobocka
    AND ss.danove_identificacne_cislo = (SELECT danove_identificacne_cislo FROM sada_spolecnost WHERE id_sada_zbozi = :NEW.id_sada_zbozi);

    IF pocet_sad > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Branch cant have more than one set of products from one company.');
    END IF;
END pocet_sad_trigger;
