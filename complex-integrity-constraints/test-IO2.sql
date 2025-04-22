-- inserting valid branch
DECLARE
    num NUMBER(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Inserting valid branch.');
    pobocka_DML.insertPobocka(1, 5);
    DBMS_OUTPUT.PUT_LINE('Branch inserted successfully.');
    SELECT p.CISLO_PRACOVNIKU INTO num FROM POBOCKA p WHERE p.ID_POBOCKA = 1;
    DBMS_OUTPUT.PUT_LINE('Num of workers: '|| num);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting branch: ' || SQLERRM);
END;
/

-- inserting existing branch
DECLARE
    num NUMBER(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Inserting existing branch.');
    pobocka_DML.insertPobocka(1, 5);
    DBMS_OUTPUT.PUT_LINE('Branch inserted successfully.');
    SELECT p.CISLO_PRACOVNIKU INTO num FROM POBOCKA p WHERE p.ID_POBOCKA = 1;
    DBMS_OUTPUT.PUT_LINE('Num of workers: '|| num);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting branch: ' || SQLERRM);
END;
/

-- inserting branch with less than 5 workers
DECLARE
    num NUMBER(10);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Inserting branch with less than 5 workers.');
    pobocka_DML.insertPobocka(2, 3);
    DBMS_OUTPUT.PUT_LINE('Branch inserted successfully.');
    SELECT p.CISLO_PRACOVNIKU INTO num FROM POBOCKA p WHERE p.ID_POBOCKA = 2;
    DBMS_OUTPUT.PUT_LINE('Num of workers: '|| num);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting branch: ' || SQLERRM);
END;
/

-- updating branch with valid data
BEGIN
    DBMS_OUTPUT.PUT_LINE('Updating branch with valid data.');
    pobocka_DML.updatePobocka(1, 5);
    DBMS_OUTPUT.PUT_LINE('Branch updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating branch: ' || SQLERRM);
END;
/

-- updating branch with less workers than there were
BEGIN
    DBMS_OUTPUT.PUT_LINE('Updating branch with less workers than there were.');
    pobocka_DML.updatePobocka(1, 1);
    DBMS_OUTPUT.PUT_LINE('Branch updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating branch: ' || SQLERRM);
END;
/

-- deleting existing branch
BEGIN
    DBMS_OUTPUT.PUT_LINE('Deleting existing branch.');
    pobocka_DML.deletePobocka(1);
    DBMS_OUTPUT.PUT_LINE('Branch deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting branch: ' || SQLERRM);
END;
/

-- deleting non-existing branch
BEGIN
    DBMS_OUTPUT.PUT_LINE('Deleting non-existing branch.');
    pobocka_DML.deletePobocka(1);
    DBMS_OUTPUT.PUT_LINE('Branch deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting branch: ' || SQLERRM);
END;
/

-- deleting branch that has set of products
BEGIN
    DBMS_OUTPUT.PUT_LINE('Deleting branch that has set of products.');
    INSERT INTO POBOCKA (ID_POBOCKA, CISLO_PRACOVNIKU) VALUES (1,5);
    INSERT INTO SADA_ZBOZI (ID_SADA_ZBOZI, MNOZSTVI, DATUM_DORUCENI, ADRESA_DORUCENI) VALUES (1, 10, '11.11.2024','Thákurova 9, Praha');
    INSERT INTO POBOCKA_SADA_ZBOZI (ID_SADA_ZBOZI, ID_POBOCKA) VALUES (1,1);
    pobocka_DML.deletePobocka(1);
    DBMS_OUTPUT.PUT_LINE('Branch deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting branch: ' || SQLERRM);
END;
/
