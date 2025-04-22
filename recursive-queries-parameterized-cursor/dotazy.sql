 -- find male parent line of otter n.10
WITH male_ancestors (CV, JMENO, OTEC, DNAR, BARVA, POHLAVI, CREV) AS (
    SELECT cv, jmeno, otec, dnar, barva, pohlavi, crev
    FROM vydra v1
    WHERE v1.cv = 10
    UNION ALL
    SELECT v2.cv, v2.jmeno, v2.otec, v2.dnar, v2.barva, v2.pohlavi, v2.crev
    FROM vydra v2
    INNER JOIN male_ancestors fa ON fa.otec = v2.cv
)
SELECT * FROM male_ancestors;


 -- find female parent line of otter n.10
WITH female_ancestors (CV, JMENO, MATKA, DNAR, BARVA, POHLAVI, CREV) AS (
    SELECT cv, jmeno, matka, dnar, barva, pohlavi, crev
    FROM vydra v1
    WHERE v1.cv = 10
    UNION ALL
    SELECT v2.cv, v2.jmeno, v2.matka, v2.dnar, v2.barva, v2.pohlavi, v2.crev
    FROM vydra v2
    INNER JOIN female_ancestors fa ON fa.matka = v2.cv
)
SELECT * FROM female_ancestors;

-- find all parent lines of otter n.10
WITH male_or_female_ancestors (GENERACE, CV, JMENO, OTEC, MATKA, DNAR, BARVA, POHLAVI, CREV) AS (
    SELECT 0, cv, jmeno, otec, matka, dnar, barva, pohlavi, crev
    FROM vydra v1
    WHERE v1.cv = 10
    UNION ALL
    SELECT fa.generace + 1, v2.cv, v2.jmeno, v2.otec, v2.matka, v2.dnar, v2.barva, v2.pohlavi, v2.crev
    FROM vydra v2
    INNER JOIN male_or_female_ancestors fa ON fa.matka = v2.cv OR fa.otec = v2.cv
)
SELECT * FROM male_or_female_ancestors;
