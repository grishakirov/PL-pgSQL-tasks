-- procedure with parametrized cursor
CREATE OR REPLACE PROCEDURE find_ancestors (
    p_name IN VARCHAR2,
    p_line IN VARCHAR2
)
AUTHID DEFINER
IS
    CURSOR ancestors (c_name IN VARCHAR2, c_line IN VARCHAR2) IS
        WITH ancestors (generace, f_cv, f_jmeno, f_otec, f_matka, f_dnar, f_barva, f_pohlavi, f_crev) AS (
            SELECT 0, cv, jmeno, otec, matka, dnar, barva, pohlavi, crev
            FROM vydra v1
            WHERE v1.jmeno = c_name
            UNION ALL
            SELECT fa.generace + 1, v2.cv, v2.jmeno, v2.otec, v2.matka, v2.dnar, v2.barva, v2.pohlavi, v2.crev
            FROM vydra v2
            INNER JOIN ancestors fa ON fa.f_matka = v2.cv OR fa.f_otec = v2.cv
            WHERE (c_line = 'O' OR v2.pohlavi = c_line)
        )
        SELECT * FROM ancestors;
p_gender VARCHAR2(1);
p_num NUMBER(10);
BEGIN
    IF p_line = 'ženská' THEN
        p_gender := 'Z';
    ELSIF p_line = 'mužská' THEN
        p_gender := 'M';
    ELSIF p_line = 'obě' THEN
        p_gender := 'O';
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Given parametr is not valid.');
    END IF;

    SELECT COUNT(*) INTO p_num FROM vydra WHERE jmeno = p_name;
    IF p_num = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Otter does not exist.');
    END IF;

    p_num := 0;

    FOR ancestor IN ancestors(p_name, p_gender) LOOP
        IF ancestor.generace = 0 THEN
            IF p_line = 'obě' THEN
                DBMS_OUTPUT.PUT_LINE(UPPER(p_line) || ' rodové linii vydry ' || UPPER(ancestor.f_jmeno) || ' jsou:');
            ELSE
                DBMS_OUTPUT.PUT_LINE(UPPER(p_line) || ' rodová linie vydry ' || UPPER(ancestor.f_jmeno) || ' je:');
            END IF;
        END IF;
        IF ancestor.generace <> 0 THEN
        DBMS_OUTPUT.PUT_LINE(ancestor.f_jmeno);
        p_num := 1;
        END IF;
    END LOOP;

    IF p_num = 0 AND p_gender = 'O' THEN
        DBMS_OUTPUT.PUT_LINE('Neznamé');
    ELSIF p_num = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Neznamá');
    END IF;

END find_ancestors;
