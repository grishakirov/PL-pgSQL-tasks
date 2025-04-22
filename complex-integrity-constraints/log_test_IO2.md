SHAKIGRI> DECLARE
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
[2024-03-28 14:35:05] completed in 17 ms
Inserting valid branch.
Branch inserted successfully.
Num of workers: 5
SHAKIGRI> DECLARE
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
[2024-03-28 14:35:06] completed in 16 ms
Inserting existing branch.
Error inserting branch: ORA-20010: Branch exists.
SHAKIGRI> DECLARE
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
[2024-03-28 14:35:06] completed in 16 ms
Inserting branch with less than 5 workers.
Branch inserted successfully.
Num of workers: 5
SHAKIGRI> BEGIN
              DBMS_OUTPUT.PUT_LINE('Updating branch with valid data.');
              pobocka_DML.updatePobocka(1, 5);
              DBMS_OUTPUT.PUT_LINE('Branch updated successfully.');
          EXCEPTION
              WHEN OTHERS THEN
                  DBMS_OUTPUT.PUT_LINE('Error updating branch: ' || SQLERRM);
          END;
[2024-03-28 14:35:06] completed in 17 ms
Updating branch with valid data.
Branch updated successfully.
SHAKIGRI> BEGIN
              DBMS_OUTPUT.PUT_LINE('Updating branch with less workers than there were.');
              pobocka_DML.updatePobocka(1, 1);
              DBMS_OUTPUT.PUT_LINE('Branch updated successfully.');
          EXCEPTION
              WHEN OTHERS THEN
                  DBMS_OUTPUT.PUT_LINE('Error updating branch: ' || SQLERRM);
          END;
[2024-03-28 14:35:06] completed in 17 ms
Updating branch with less workers than there were.
Error updating branch: ORA-20002: New worker number cant be less then the old one.
SHAKIGRI> BEGIN
              DBMS_OUTPUT.PUT_LINE('Deleting existing branch.');
              pobocka_DML.deletePobocka(1);
              DBMS_OUTPUT.PUT_LINE('Branch deleted successfully.');
          EXCEPTION
              WHEN OTHERS THEN
                  DBMS_OUTPUT.PUT_LINE('Error deleting branch: ' || SQLERRM);
          END;
[2024-03-28 14:35:06] completed in 17 ms
Deleting existing branch.
Branch deleted successfully.
SHAKIGRI> BEGIN
              DBMS_OUTPUT.PUT_LINE('Deleting non-existing branch.');
              pobocka_DML.deletePobocka(1);
              DBMS_OUTPUT.PUT_LINE('Branch deleted successfully.');
          EXCEPTION
              WHEN OTHERS THEN
                  DBMS_OUTPUT.PUT_LINE('Error deleting branch: ' || SQLERRM);
          END;
[2024-03-28 14:35:06] completed in 20 ms
Deleting non-existing branch.
Error deleting branch: ORA-20010: Branch doesnt exist.
SHAKIGRI> BEGIN
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
[2024-03-28 14:35:06] completed in 19 ms
Deleting branch that has set of products.
Error deleting branch: ORA-20502: Branch cant be deleted until it has set of products.
