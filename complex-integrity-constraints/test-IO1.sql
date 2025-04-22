CREATE OR REPLACE PROCEDURE fill_pobocka_sada_RIGHT
    AUTHID DEFINER
IS
    num_of_products NUMBER(10);
    id_p NUMBER(10);
    num NUMBER(10);
    dic VARCHAR2(10);
BEGIN
    SELECT COUNT(*) INTO num FROM pobocka_sada_zbozi;
    IF num > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Table pobocka_sada_zbozi is not empty');
        RETURN;
    END IF;

    SELECT COUNT(*) INTO num_of_products FROM sada_zbozi;

   FOR i IN 1..num_of_products LOOP
       BEGIN

           SELECT ds.danove_identificacne_cislo INTO dic FROM dodavatelska_spolecnost ds
           JOIN sada_spolecnost ss ON ds.danove_identificacne_cislo = ss.danove_identificacne_cislo
           WHERE id_sada_zbozi = i AND ROWNUM = 1;

           SELECT id_pobocka INTO id_p
           FROM pobocka
            WHERE NOT EXISTS(
               SELECT * FROM pobocka_sada_zbozi sz
                JOIN sada_spolecnost ss on sz.id_sada_zbozi = ss.id_sada_zbozi
                WHERE sz.id_pobocka = pobocka.id_pobocka AND ss.danove_identificacne_cislo = dic
                )
           ORDER BY DBMS_RANDOM.VALUE
           FETCH FIRST 1 ROW ONLY;
           INSERT INTO pobocka_sada_zbozi (id_sada_zbozi, id_pobocka) VALUES (i, id_p);
       END;
    END LOOP;

    SELECT COUNT(*) INTO num FROM pobocka_sada_zbozi;
    DBMS_OUTPUT.PUT_LINE(num || ' rows were inserted into pobocka_sada_zbozi table.');
    COMMIT;
END fill_pobocka_sada_RIGHT;


CREATE OR REPLACE PROCEDURE fill_pobocka_sada_WRONG
    AUTHID DEFINER
IS
    num_of_pobocka NUMBER(10);
    num_of_sada NUMBER(10);
    num NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO num FROM pobocka_sada_zbozi;
    IF num > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Table pobocka_sada_zbozi is not empty');
        RETURN;
    END IF;
    SELECT COUNT(*) INTO num_of_pobocka FROM pobocka;
    SELECT COUNT(*) INTO num_of_sada FROM sada_zbozi;

    FOR x IN 1..num_of_pobocka LOOP
        FOR y IN 1..num_of_sada LOOP
            BEGIN
                INSERT INTO pobocka_sada_zbozi (id_sada_zbozi, id_pobocka) VALUES (y,x);
            END;
           END LOOP;
        END LOOP;

    SELECT COUNT(*) INTO num FROM pobocka_sada_zbozi;
    DBMS_OUTPUT.PUT_LINE(num || ' rows were inserted into pobocka_sada_zbozi table.');
    COMMIT;
END fill_pobocka_sada_WRONG;
