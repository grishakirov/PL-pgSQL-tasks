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

        INSERT INTO sada_zbozi (id_sada_zbozi, id_pobocka, mnozstvi, datum_doruceni, adresa_doruceni)
        VALUES (
            sada_zbozi_seq.NEXTVAL,
            ROUND(DBMS_RANDOM.VALUE(1, 200)),
            ROUND(DBMS_RANDOM.VALUE(5, 150)),
            TO_CHAR(CURRENT_DATE + ROUND(DBMS_RANDOM.VALUE(0, 365)), 'DD.MM.YYYY'),
            city(ROUND(DBMS_RANDOM.VALUE(1, 10))) || ', ' || street(ROUND(DBMS_RANDOM.VALUE(1, 10))) || ', ' || housenum
        );
    END LOOP;
    SELECT COUNT(*) INTO num FROM sada_zbozi;
    DBMS_OUTPUT.PUT_LINE(num || ' rows were inserted into sada_zbozi table.');
    COMMIT;
END fill_sada_zbozi;
