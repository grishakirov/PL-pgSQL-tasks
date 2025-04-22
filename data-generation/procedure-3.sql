CREATE OR REPLACE PROCEDURE fill_sada_spolecnost
    AUTHID DEFINER
IS
    danove_identificacne_cislo_ VARCHAR2(10);
    num NUMBER(10);
    num_of_products NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO num FROM sada_spolecnost;
    IF num > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Table sada_spolecnost is not empty');
        RETURN;
    END IF;
    SELECT COUNT(*) INTO num_of_products FROM sada_zbozi;
    FOR i IN 1.. num_of_products LOOP
        BEGIN

            SELECT danove_identificacne_cislo INTO danove_identificacne_cislo_
            FROM (SELECT danove_identificacne_cislo FROM dodavatelska_spolecnost ORDER BY DBMS_RANDOM.VALUE)
            WHERE ROWNUM = 1;

        END;

        INSERT INTO sada_spolecnost (id_sada_zbozi, danove_identificacne_cislo) VALUES (i, danove_identificacne_cislo_);
    END LOOP;

    SELECT COUNT(*) INTO num FROM sada_spolecnost;
    DBMS_OUTPUT.PUT_LINE(num || ' rows were inserted into sada_spolecnost table.');
    COMMIT;
END fill_sada_spolecnost;
