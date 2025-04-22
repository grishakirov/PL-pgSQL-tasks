CREATE SEQUENCE sada_zbozi_seq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE dodavatelska_spolecnost_seq
START WITH 1
INCREMENT BY 1;

CREATE TABLE sada_zbozi (
    id_sada_zbozi NUMBER(10) PRIMARY KEY,
    id_pobocka NUMBER(10) NOT NULL,
    mnozstvi NUMBER(10) NOT NULL,
    datum_doruceni DATE NOT NULL,
    adresa_doruceni VARCHAR2(256) NOT NULL
);

CREATE TABLE dodavatelska_spolecnost (
    danove_identificacne_cislo VARCHAR2(10) PRIMARY KEY,
    nazev VARCHAR(100) UNIQUE,
    cislo_pracovniku NUMBER(10)
);

CREATE TABLE sada_spolecnost (
    id_sada_zbozi NUMBER(10) NOT NULL,
    danove_identificacne_cislo VARCHAR2(10) NOT NULL,
    CONSTRAINT fk_sada_zbozi FOREIGN KEY (id_sada_zbozi) REFERENCES sada_zbozi(id_sada_zbozi),
    CONSTRAINT fk_danove_identifikacni_cislo FOREIGN KEY (danove_identificacne_cislo) REFERENCES dodavatelska_spolecnost(danove_identificacne_cislo)
);

