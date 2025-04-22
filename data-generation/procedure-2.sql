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
