-- SIBD 2018-12-14 ETAPA 2
-- GRUPO 14
-- Daniel Nunes 49467
-- Inês Gonçalves 49493
-- João Rangel 47982
-- Manuel Tovar 49522

-- -------------------------------------------------------------------------------------
-- INSERTS

Insert into AULA (ID,MODALIDADE,ESPACO,DIA_SEMANA,HORA_INICIO,HORA_FIM) values ('1','Tenis','Corte','MON','9','10');
Insert into AULA (ID,MODALIDADE,ESPACO,DIA_SEMANA,HORA_INICIO,HORA_FIM) values ('2','Golf','Campo','TUE','10','11');
Insert into AULA (ID,MODALIDADE,ESPACO,DIA_SEMANA,HORA_INICIO,HORA_FIM) values ('3','Boxe','Ringue','WED','11','12');
Insert into AULA (ID,MODALIDADE,ESPACO,DIA_SEMANA,HORA_INICIO,HORA_FIM) values ('4','Cricket','Salao','FRI','16','17');
Insert into AULA (ID,MODALIDADE,ESPACO,DIA_SEMANA,HORA_INICIO,HORA_FIM) values ('5','Cycling','Salao Ciclismo','SUN','10','12');
Insert into AULA (ID,MODALIDADE,ESPACO,DIA_SEMANA,HORA_INICIO,HORA_FIM) values ('6','Karate','Sala 1','SUN','11','13');
Insert into AULA (ID,MODALIDADE,ESPACO,DIA_SEMANA,HORA_INICIO,HORA_FIM) values ('7','Ginastica','Sala 2','WED','15','16');
Insert into AULA (ID,MODALIDADE,ESPACO,DIA_SEMANA,HORA_INICIO,HORA_FIM) values ('8','Ginastica','Sala 2','THU','10','11');

Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('17','Joaquim','M','1975');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('18','Antonio','M','1975');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('1','Daniel','M','1996');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('2','Inês','F','1997');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('3','Manuel','M','1998');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('4','João','M','1999');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('7','Miguel','M','1999');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('8','Jose','M','1999');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('9','Maria','F','2001');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('10','Gabriel','M','2001');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('13','Carlos','M','2001');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('15','Nuno','M','1945');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('11','Francisco','M','2001');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('12','Fernando','M','1999');
Insert into UTENTE (NIF,NOME,GENERO,ANO) values ('14','David','M','1969');

Insert into FREQUENTA (UTENTE,AULA,DATA) values ('1','1',to_date('14.11.13','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('1','2',to_date('15.05.16','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('1','2',to_date('18.01.02','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('1','2',to_date('18.12.17','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('1','3',to_date('18.12.27','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('1','5',to_date('18.12.07','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('2','2',to_date('15.11.12','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('2','3',to_date('17.03.04','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('3','1',to_date('15.04.12','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('3','3',to_date('17.11.12','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('3','3',to_date('17.12.16','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('3','4',to_date('17.11.22','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('4','1',to_date('14.11.12','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('4','2',to_date('18.11.14','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('7','3',to_date('18.12.07','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('8','6',to_date('18.12.12','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('9','1',to_date('17.12.21','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('9','1',to_date('18.12.04','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('9','1',to_date('18.12.16','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('10','4',to_date('18.12.02','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('11','8',to_date('15.12.09','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('12','7',to_date('18.12.18','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('13','7',to_date('18.01.26','RR.MM.DD'));
Insert into FREQUENTA (UTENTE,AULA,DATA) values ('14','7',to_date('18.01.26','RR.MM.DD'));
