CREATE OR REPLACE PROCEDURE fill_sada_zbozi(
    num_rows NUMBER
)
    AUTHID DEFINER
IS
    TYPE streetarr IS VARRAY(10) OF VARCHAR(25);
    TYPE cityarr IS VARRAY(10) OF VARCHAR(25);
    housenum NUMBER(5);
    street streetarr;
    city cityarr;
    num NUMBER;
BEGIN
    SELECT COUNT(*) INTO num FROM sada_zbozi;
    IF num>0 THEN
        DBMS_OUTPUT.PUT_LINE('Table sada_zbozi is not empty');
        RETURN;
    END IF;
    street := streetarr('Maple Avenue', 'Elm Street', 'Oak Lane', 'Cedar Road', 'Pine Street', 'Willow Lane', 'Birch Avenue', 'Spruce Drive', 'Magnolia Boulevard', 'Cypress Lane');
    city := cityarr('Aurora', 'Savannah', 'Bristol', 'Phoenix', 'Kingston', 'Adelaide', 'Denver', 'Glasgow', 'Venice', 'Oslo');

    FOR i IN 1..num_rows LOOP
        housenum := TO_CHAR(ROUND(DBMS_RANDOM.VALUE(1, 200)));

        INSERT INTO sada_zbozi (id_sada_zbozi, mnozstvi, datum_doruceni, adresa_doruceni)
        VALUES (
            sada_zbozi_seq.NEXTVAL,
            ROUND(DBMS_RANDOM.VALUE(5, 150)),
            TO_CHAR(CURRENT_DATE + ROUND(DBMS_RANDOM.VALUE(0, 365)), 'DD.MM.YYYY'),
            city(ROUND(DBMS_RANDOM.VALUE(1, 10))) || ', ' || street(ROUND(DBMS_RANDOM.VALUE(1, 10))) || ', ' || housenum
        );
    END LOOP;
    SELECT COUNT(*) INTO num FROM sada_zbozi;
    DBMS_OUTPUT.PUT_LINE(num || ' rows were inserted into sada_zbozi table.');
    COMMIT;
END fill_sada_zbozi;

CREATE OR REPLACE PROCEDURE fill_dodavatelska_spolecnost(
    num_rows NUMBER
)
    AUTHID DEFINER
IS
    TYPE firstnamearr IS VARRAY(10) OF VARCHAR(25);
    TYPE secondnamearr IS VARRAY(10) OF VARCHAR(25);
    TYPE countryarr IS VARRAY(10) OF VARCHAR(2);
    fname firstnamearr;
    sname secondnamearr;
    country countryarr;
    dicp NUMBER(6);
    num NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO num FROM dodavatelska_spolecnost;
    IF num>0 THEN
        DBMS_OUTPUT.PUT_LINE('Table dodavatelska_spolecnost is not empty');
        RETURN;
    END IF;
    fname := firstnamearr('Alpha', 'Beta', 'Gamma', 'Delta', 'Epsilon', 'Zeta', 'Eta', 'Theta', 'Iota', 'Kappa');
    sname := secondnamearr(' Industries', ' Technologies', ' Solutions', ' Enterprises', ' Corporation', ' Incorporated', ' International', ' Services', ' Consulting', '');
    country := countryarr('CZ', 'US', 'GB', 'FR', 'DE', 'IT', 'ES', 'JP', 'UK', 'CN');
    FOR i IN 1..num_rows LOOP
        dicp := TO_CHAR(ROUND(DBMS_RANDOM.VALUE(0000001, 999999)));

        INSERT INTO dodavatelska_spolecnost (danove_identificacne_cislo, nazev, cislo_pracovniku)
        VALUES (
            country(ROUND(DBMS_RANDOM.VALUE(1,10)))||dicp||dodavatelska_spolecnost_seq.NEXTVAL,
            fname(ROUND(DBMS_RANDOM.VALUE(1,10)))||sname(ROUND(DBMS_RANDOM.VALUE(1,10))),
            ROUND(DBMS_RANDOM.VALUE(1,250))
        );
    END LOOP;
    SELECT COUNT(*) INTO num FROM dodavatelska_spolecnost;
    DBMS_OUTPUT.PUT_LINE(num || ' rows were inserted into dodavatelska_spolecnost table.');
    COMMIT;
END fill_dodavatelska_spolecnost;

CREATE OR REPLACE PROCEDURE fill_pobocka(
    num_rows NUMBER
)
    AUTHID DEFINER
IS
    num NUMBER(6);
BEGIN
    SELECT COUNT(*) INTO num FROM pobocka;
    IF NUM>0 THEN
        DBMS_OUTPUT.PUT_LINE('Table pobocka is not empty');
        RETURN;
    END IF;
    FOR i IN 1..num_rows LOOP
        INSERT INTO pobocka (id_pobocka, cislo_pracovniku)
        VALUES (
                pobocka_seq.nextval,
                ROUND(DBMS_RANDOM.VALUE(5,30))
               );
    END LOOP;
    SELECT COUNT(*) INTO num FROM pobocka;
    DBMS_OUTPUT.PUT_LINE(num || ' rows were inserted into pobocka table.');
    COMMIT;
END fill_pobocka;

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
