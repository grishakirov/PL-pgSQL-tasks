CREATE OR REPLACE PACKAGE pobocka_DML AS
    PROCEDURE insertPobocka(id_p IN NUMBER, cislo_pr IN NUMBER);
    PROCEDURE updatePobocka(id_p IN NUMBER, cislo_pr IN NUMBER);
    PROCEDURE deletePobocka(id_p IN NUMBER);
END pobocka_DML;

CREATE OR REPLACE PACKAGE BODY pobocka_DML AS
        PROCEDURE insertPobocka(id_p IN NUMBER, cislo_pr IN NUMBER) IS
            num1 NUMBER(10);
        BEGIN
            SELECT COUNT(*) INTO num1 FROM pobocka p
            WHERE p.id_pobocka = id_p;

            IF num1 > 0 THEN
                RAISE_APPLICATION_ERROR(-20010, 'Branch exists.');
            END IF;

            IF cislo_pr < 5 THEN
                INSERT INTO pobocka (id_pobocka, cislo_pracovniku) VALUES (id_p, 5);
            ELSE
                INSERT INTO pobocka (id_pobocka, cislo_pracovniku) VALUES (id_p, cislo_pr);
            END IF;
        END insertPobocka;

  PROCEDURE updatePobocka(id_p IN NUMBER, cislo_pr IN NUMBER) IS
        old_cislo_pracovniku NUMBER(10);
        num1 NUMBER(10);
        BEGIN
           SELECT COUNT(*) INTO num1 FROM pobocka p
            WHERE p.id_pobocka = id_p;

            IF num1 = 0 THEN
                RAISE_APPLICATION_ERROR(-20010, 'Branch doesnt exist.');
            END IF;

            SELECT cislo_pracovniku INTO old_cislo_pracovniku
            FROM pobocka p
            WHERE p.id_pobocka = id_p AND ROWNUM = 1;

            IF cislo_pr < old_cislo_pracovniku THEN
                RAISE_APPLICATION_ERROR(-20002, 'New worker number cant be less then the old one.');
            END IF;
            UPDATE pobocka p SET p.cislo_pracovniku = cislo_pracovniku WHERE p.id_pobocka = id_p;
        END updatePobocka;

PROCEDURE deletePobocka(id_p IN NUMBER) IS
    num1 NUMBER(10);
    num2 NUMBER(10);
        BEGIN
            SELECT COUNT(*) INTO num1 FROM pobocka p
            WHERE p.id_pobocka = id_p;

            IF num1 = 0 THEN
                RAISE_APPLICATION_ERROR(-20010, 'Branch doesnt exist.');
            END IF;

            SELECT COUNT(*) INTO num2 FROM pobocka_sada_zbozi psz
            WHERE psz.id_pobocka = id_p;

            IF num2 > 0 THEN
                RAISE_APPLICATION_ERROR(-20502, 'Branch cant be deleted until it has set of products.');
            END IF;

              DELETE FROM pobocka p WHERE p.id_pobocka = id_p;
        END deletePobocka;
END pobocka_DML;
