-- ----------------------------------------------------------------------------
-- SIBD - Sistemas de Informacao e Base Dados 2018/2019
-- Grupo: 14
-- Daniel Nunes N:49467
-- Ines Goncalves N:49493
-- Joao Rangel N:47982
-- Manuel Tovar N:49522

-- ----------------------------------------------------------------------------

DROP TABLE Desconto;
DROP TABLE NaoEmpregado CASCADE CONSTRAINTS;
DROP TABLE Fatura;
DROP TABLE Empregado;
DROP TABLE Empresa;
DROP TABLE Inscrevem;
DROP TABLE Consultados;
DROP TABLE Decorre;
DROP TABLE De;
DROP TABLE Aula;
DROP TABLE Treinador CASCADE CONSTRAINTS;
DROP TABLE Modalidades;
DROP TABLE Espaco;
DROP TABLE Ginasio CASCADE CONSTRAINTS;
DROP TABLE Gerente;
DROP TABLE Funcionarios;
DROP TABLE Utentes;
DROP TABLE Pessoa;
DROP TABLE Cidade;

-- ----------------------------------------------------------------------------

CREATE TABLE Cidade (
	nome VARCHAR(40) CONSTRAINT nn_cidade_nome NOT NULL,
--
	CONSTRAINT pk_cidade
		PRIMARY KEY(nome)
);

-- ----------------------------------------------------------------------------

CREATE TABLE Ginasio (
	nipc NUMBER (9) CONSTRAINT nn_ginasio_nipc NOT NULL,
	nome VARCHAR(40) CONSTRAINT nn_ginasio_nome NOT NULL,
	mail VARCHAR(40) CONSTRAINT nn_ginasio_mail NOT NULL,
	morada VARCHAR(40) CONSTRAINT nn_ginasio_morada NOT NULL,
	local,
	telefone NUMBER(9) CONSTRAINT nn_ginasio_telefone NOT NULL,
	hora_abertura VARCHAR(5) CONSTRAINT nn_ginasio_hora_abertura NOT NULL,
	hora_fecho VARCHAR(5) CONSTRAINT nn_ginasio_hora_fecho NOT NULL,
	data_de_inauguracao DATE CONSTRAINT nn_ginasio_data_de_inauguracao NOT NULL,
--
	CONSTRAINT pk_ginasio
		PRIMARY KEY (nipc),
--
	CONSTRAINT fk_ginasio_cidade
		FOREIGN KEY (local) REFERENCES Cidade(nome),
--
	CONSTRAINT ck_ginasio_nipc
		CHECK(nipc>0),
--
--	CONSTRAINT ck_ginasio_date
--		CHECK(CURRENT_DATE >= data_de_inauguracao),
--
	CONSTRAINT un_ginasio_nome
		UNIQUE(nome)
);

-- ----------------------------------------------------------------------------

CREATE TABLE Pessoa (
	nome VARCHAR(40) CONSTRAINT nn_pessoa_nome NOT NULL,
	numero NUMBER (9) CONSTRAINT nn_pessoa_numero NOT NULL,
	id_ginasio,
	nif NUMBER (9) CONSTRAINT nn_pessoa_nif NOT NULL,
	nic NUMBER (9) CONSTRAINT nn_pessoa_nic NOT NULL,
	morada VARCHAR(40) CONSTRAINT nn_pessoa_morada NOT NULL,
	telefone NUMBER(9) CONSTRAINT nn_pessoa_telefone NOT NULL,
	genero VARCHAR(10) CONSTRAINT nn_pessoa_genero NOT NULL,
	data_nascimento DATE CONSTRAINT nn_pessoa_data_nascimento NOT NULL,
	mail VARCHAR(40) CONSTRAINT nn_pessoa_mail NOT NULL,
--
	CONSTRAINT pk_pessoa
		PRIMARY KEY(numero),
--
	CONSTRAINT fk_pessoa_ginasio
		FOREIGN KEY (id_ginasio) REFERENCES Ginasio(nipc),

--Assumindo que o mail eh unico para nao haver pessoas com mails repetidos
	CONSTRAINT un_mail
		UNIQUE(mail),
--Decidimos em grupo meter nif unico, pela logica achamos que fazia sentido
	CONSTRAINT un_nif
		UNIQUE(nif),
--Decidimos em grupo meter nic unico, pela logica achamos que fazia sentido
	CONSTRAINT un_nic
		UNIQUE(nic),
--
	CONSTRAINT ck_pessoa_numero
		CHECK(numero>0),
--
	CONSTRAINT ck_pessoa_nif
		CHECK(nif>0),
--
	CONSTRAINT ck_pessoa_nic
		CHECK(nic>0)
);

-- ----------------------------------------------------------------------------

CREATE TABLE Utentes (
	numero,
--
	CONSTRAINT pk_utentes
		PRIMARY KEY(numero),
--
	CONSTRAINT fk_utentes_pessoa
		FOREIGN KEY (numero) REFERENCES Pessoa ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------

CREATE TABLE Funcionarios (
	numero,
--
	CONSTRAINT pk_funcionarios
		PRIMARY KEY(numero),
--
	CONSTRAINT fk_funcionarios_pessoa
		FOREIGN KEY (numero) REFERENCES Pessoa ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------

CREATE TABLE Gerente (
	numero,
--
	CONSTRAINT pk_gerente
		PRIMARY KEY(numero),
--
	CONSTRAINT fk_gerente_funcionarios
		FOREIGN KEY (numero) REFERENCES Funcionarios(numero) ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------

ALTER TABLE Ginasio ADD (
	gerente,
--
	CONSTRAINT fk_ginasio_gerente
		FOREIGN KEY (gerente) REFERENCES Gerente(numero)
);

-- ----------------------------------------------------------------------------

CREATE TABLE Treinador (
	numero,
--
	CONSTRAINT pk_treinador
		PRIMARY KEY(numero),
--
	CONSTRAINT fk_treinador_funcionarios
		FOREIGN KEY (numero) REFERENCES Funcionarios ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------

CREATE TABLE Espaco (
	nome VARCHAR(40) CONSTRAINT nn_espaco_nome NOT NULL,
	num_ginasio,
--
	CONSTRAINT pk_espaco
		PRIMARY KEY(nome),
--
	CONSTRAINT fk_espaco_ginasio
		FOREIGN KEY(num_ginasio) REFERENCES Ginasio(nipc) ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------

CREATE TABLE Modalidades (
	nome VARCHAR(40) CONSTRAINT nn_modalidades_nome NOT NULL,
	nivel_exigencia_fisica NUMBER(3),
	beneficio_para_saude VARCHAR(40),
	duracao_exercicio VARCHAR(8) CONSTRAINT nn_mod_dur_exerc NOT NULL,
	descricao VARCHAR(40),
	faixa_etaria_recomendada NUMBER(3),
--
	CONSTRAINT pk_modalidades
		PRIMARY KEY(nome)
);

-- ----------------------------------------------------------------------------

ALTER TABLE Treinador ADD (
	nome_modalidade,
--
	CONSTRAINT fk_treinador_modalidades
		FOREIGN KEY (nome_modalidade) REFERENCES Modalidades(nome)
);

-- ----------------------------------------------------------------------------

CREATE TABLE Aula (
	codigo NUMBER (9) CONSTRAINT nn_aula_codigo NOT NULL,
	dia_semana NUMBER (1) CONSTRAINT nn_aula_dia_semana NOT NULL,
	hora_inicio VARCHAR(5) CONSTRAINT nn_aula_hora_inicio NOT NULL,
	hora_fim VARCHAR(5) CONSTRAINT nn_aula_hora_fim NOT NULL,
	nome_modalidade,
	nome_espaco,
	num_treinador,
--
	CONSTRAINT pk_aula
		PRIMARY KEY(codigo),
--
	CONSTRAINT fk_aula_modalidades
		FOREIGN KEY(nome_modalidade) REFERENCES Modalidades(nome),
--
	CONSTRAINT fk_aula_espaco
		FOREIGN KEY(nome_espaco) REFERENCES Espaco(nome),
--
	CONSTRAINT fk_aula_treinador
		FOREIGN KEY(num_treinador) REFERENCES Treinador(numero)
);

-- ----------------------------------------------------------------------------

CREATE TABLE De (
	preco NUMBER (6,2) CONSTRAINT nn_de_preco NOT NULL,
	codigo,
	nome,
--
	CONSTRAINT pk_de
		PRIMARY KEY(codigo,nome),
--
	CONSTRAINT fk_de_aula
		FOREIGN KEY(codigo) REFERENCES Aula(codigo),
--
	CONSTRAINT fk_de_modalidades
		FOREIGN KEY(nome) REFERENCES Modalidades(nome)
);

-- ----------------------------------------------------------------------------

CREATE TABLE Decorre (
	lotacao NUMBER(3) CONSTRAINT nn_decorre_lotacao NOT NULL,
	nome_espaco,
	nome_modalidade,
--
	CONSTRAINT pk_decorre
		PRIMARY KEY (nome_espaco,nome_modalidade),
--
	CONSTRAINT fk_decorre_espaco
		FOREIGN KEY(nome_espaco) REFERENCES Espaco(nome),
--
	CONSTRAINT fk_decorre_modalidades
		FOREIGN KEY(nome_modalidade) REFERENCES Modalidades(nome)
);

-- ----------------------------------------------------------------------------

CREATE TABLE Consultados (
	autorizado NUMBER(1) DEFAULT 0,
	nome_modalidade,
	num_utente,
--
	CONSTRAINT pk_consultados
		PRIMARY KEY (num_utente,nome_modalidade),
--
	CONSTRAINT fk_consultados_modalidades
		FOREIGN KEY(nome_modalidade) REFERENCES Modalidades(nome),
--
	CONSTRAINT fk_consultados_utentes
		FOREIGN KEY(num_utente) REFERENCES Utentes(numero)
);

-- ----------------------------------------------------------------------------

CREATE TABLE Inscrevem (
	data_hora_entrada VARCHAR(20) CONSTRAINT nn_inscrevem_data_hora_entrada NOT NULL,
	pode_ir_aula NUMBER(1) DEFAULT 0,
	num_utente,
	cod_aula,
--
	CONSTRAINT pk_inscrevem
		PRIMARY KEY (num_utente,cod_aula),
--
	CONSTRAINT fk_inscrevem_aula
		FOREIGN KEY(cod_aula) REFERENCES Aula(codigo),
--
	CONSTRAINT fk_inscrevem_utentes
		FOREIGN KEY(num_utente) REFERENCES Utentes(numero)
);

-- ----------------------------------------------------------------------------

CREATE TABLE Empresa (
	nipc NUMBER (9) CONSTRAINT nn_empresa_nipc NOT NULL,
	mail VARCHAR(40) CONSTRAINT nn_empresa_mail NOT NULL,
	morada VARCHAR(40) CONSTRAINT nn_empresa_morada NOT NULL,
	telefone NUMBER (9) CONSTRAINT nn_empresa_telefone NOT NULL,
	pessoa_de_contacto VARCHAR(40) CONSTRAINT nn_empresa_pessoa_de_contacto NOT NULL,
--
	CONSTRAINT pk_empresa
		PRIMARY KEY (nipc),
--
	CONSTRAINT ck_empresa_nipc
		CHECK (nipc>0)
);

-- ----------------------------------------------------------------------------

CREATE TABLE NaoEmpregado (
	numero,
--
	CONSTRAINT pk_naoempregado
		PRIMARY KEY(numero),
--
	CONSTRAINT fk_naoempregado_utentes
		FOREIGN KEY (numero) REFERENCES Utentes ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------

CREATE TABLE Empregado (
	numero,
	empresa_nipc,
--
	CONSTRAINT pk_empregado
		PRIMARY KEY (numero),
--
	CONSTRAINT fk_empregado_empresa
		FOREIGN KEY (empresa_nipc) REFERENCES Empresa(nipc),
--
	CONSTRAINT fk_empregado_utentes
		FOREIGN KEY (numero) REFERENCES Utentes ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------

CREATE TABLE Fatura (
	num_seq NUMBER (6) CONSTRAINT nn_fatura_num_seq NOT NULL,
	grande_total NUMBER (6,2) CONSTRAINT nn_fatura_grande_total NOT NULL,
	data_emissao DATE,
	data_pagamento DATE,
--
	CONSTRAINT pk_fatura
		PRIMARY KEY (num_seq),
	CONSTRAINT ck_fatura_pagaDepoisDeEmitido
		CHECK (data_pagamento > data_emissao)
);

-- ----------------------------------------------------------------------------

ALTER TABLE NaoEmpregado ADD (
	fatura,
--
	CONSTRAINT fk_naoempregado_fatura
		FOREIGN KEY (fatura) REFERENCES Fatura(num_seq)
);

-- ----------------------------------------------------------------------------

CREATE TABLE Desconto (
	valor NUMBER (3) CONSTRAINT nn_desconto_valor NOT NULL,
	num_empregado,
	num_fatura,
--
	CONSTRAINT pk_desconto
		PRIMARY KEY (num_empregado, num_fatura),
--
	CONSTRAINT fk_desconto_empregado
		FOREIGN KEY (num_empregado) REFERENCES Empregado(numero),
--
	CONSTRAINT fk_desconto_fatura
		FOREIGN KEY (num_fatura) REFERENCES Fatura(num_seq),
--
	CONSTRAINT ck_desconto_valor
		CHECK (valor BETWEEN 0 AND 100)
);

-- ----------------------------------------------------------------------------

COMMIT;

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
-- SIBD - Sistemas de Informacao e Base Dados 2018/2019
-- Grupo: 14
-- Daniel Nunes N:49467
-- Ines Goncalves N:49493
-- Joao Rangel N:47982
-- Manuel Tovar N:49522
-- ----------------------------------------------------------------------------
--            INSERTS            ----------------------------------------------
-- ----------------------------------------------------------------------------

--INSERTS Cidade

INSERT INTO Cidade(nome)
  VALUES('Porto');
--
INSERT INTO Cidade(nome)
  VALUES('Braga');
--
INSERT INTO Cidade(nome)
  VALUES('Lisboa');

-- ----------------------------------------------------------------------------

--INSERTS Ginasio - Porto-
INSERT INTO Ginasio(nipc,nome,mail,morada,local,telefone
,hora_abertura,hora_fecho,data_de_inauguracao, gerente)
  VALUES(123456789,'FitPorto','fitporto@hotmail.com','Rua Santa Catarina n:3 2A'
  ,'Porto',255345789,'08:00','23:00',TO_DATE('1996/04/24'),NULL);

--INSERTS Ginasio - Braga-
INSERT INTO Ginasio(nipc,nome,mail,morada,local,telefone
  ,hora_abertura,hora_fecho,data_de_inauguracao, gerente)
    VALUES(987654321,'FitNessUpBraga','fitnupbraga@hotmail.com','Avenida Central n:1'
    ,'Braga',212541809,'08:00','23:00',TO_DATE('2000/06/13'),NULL);

--INSERTS Ginasio - Lisboa-
INSERT INTO Ginasio(nipc,nome,mail,morada,local,telefone
      ,hora_abertura,hora_fecho,data_de_inauguracao, gerente)
        VALUES(923467824,'PUMPLisboa','pumplisboa@hotmail.com','Parque Das Nacoes n:2'
        ,'Lisboa',217766221,'07:00','23:30',TO_DATE('2002/06/24'),NULL);

-- ----------------------------------------------------------------------------

--INSERTS Pessoa Utentes - Empregados- Lisboa-
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
  genero,data_nascimento, mail)
  VALUES('The Rock',57982,923467824,261116754,14926792,
    'Rua Rock n:4 3E',212534679,
    'Masculino',TO_DATE('1972/05/02'),'rock@gmail.com');

--INSERTS Pessoa Utentes - Empregados- Porto-
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
      genero,data_nascimento, mail)
      VALUES('Taylor Swift',58982,123456789,274116754,16836792,
        'Rua Swift n:1 1D',255533789,
        'Feminino',TO_DATE('1989/12/13'),'taylorprincesa@gmail.com');

--INSERTS Pessoa Utentes - Empregados- Braga-
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
    genero,data_nascimento, mail)
    VALUES('Triple H',59999,987654321,234566754,12336792,
      'Alameda das Antas n:1 2E',255678289,
      'Masculino',TO_DATE('1969/07/27'),'dxhh@gmail.com');

-- ----------------------------------------------------------------------------

--INSERTS Pessoa Utentes - Nao Empregados- Lisboa-
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
  genero,data_nascimento, mail)
  VALUES('Ines Goncalves',49493,923467824,268638004,14475913,
    'Avenida da Liberdade n:4 3E',215606099,
    'Feminino',TO_DATE('1998/03/26'),'poneiscorderosa@gmail.com');

--INSERTS Pessoa Utentes - Nao Empregados- Porto-
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
      genero,data_nascimento, mail)
      VALUES('Joao Rangel',41569,123456789,234567854,12356792,
        'Avenida Fernao Magalhaes n:1 1D',255531808,
        'Masculino',TO_DATE('1996/04/24'),'boss96@gmail.com');

--INSERTS Pessoa Utentes - Nao Empregados- Braga-
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
    genero,data_nascimento, mail)
    VALUES('Daniel Nunes',49467,987654321,231133759,18516792,
      'Rua Sa de Miranda n:5 4E',215778289,
      'Masculino',TO_DATE('1996/11/10'),'marmelada@gmail.com');

-- ----------------------------------------------------------------------------

--INSERTS Pessoa Funcionarios - Treinadores - Porto --
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
    genero,data_nascimento, mail)
    VALUES('Rafel Martins',62034,123456789,223145759,13419782,
      'Rua Dom Antonio Barroso n:2 2E',255328289,
      'Masculino',TO_DATE('1986/09/10'),'coachmartins@gmail.com');

--INSERTS Pessoa Funcionarios - Treinadores - Lisboa --
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
    genero,data_nascimento, mail)
    VALUES('Jorge Jesus',61004,923467824,284146759,11219782,
      'Intendente n:2 1E',215318289,
      'Masculino',TO_DATE('1954/07/24'),'jj@gmail.com');

--INSERTS Pessoa Funcionarios - Treinadores - Braga --
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
    genero,data_nascimento, mail)
    VALUES('Cristina Lopes',62398,987654321,222146987,15519782,
      'Avenida de Santo Andre n:2 1E',212348289,
      'Feminino',TO_DATE('1989/06/24'),'clopes@gmail.com');

-- ----------------------------------------------------------------------------

--INSERTS Pessoa Funcionarios - Gerente- Porto-
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
    genero,data_nascimento, mail)
    VALUES('Fernando Rocha',71000,123456789,223346759,10019782,
      'Avenida da Franca n:1 5E',255001289,
      'Masculino',TO_DATE('1975/07/02'),'fernandinho@gmail.com');

--INSERTS Pessoa Funcionarios - Gerente- Lisboa-
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
    genero,data_nascimento, mail)
    VALUES('Cristiano Ronaldo',70000,923467824,233140759,16009782,
      'Paco da Rainha n:2 2D',210329289,
      'Masculino',TO_DATE('1985/02/05'),'cr7@gmail.com');

--INSERTS Pessoa Funcionarios - Gerente- Braga-
INSERT INTO Pessoa(nome,numero,id_ginasio,nif,nic,morada,telefone,
    genero,data_nascimento, mail)
    VALUES('Maria Isabel',74002,987654321,270176759,14200782,
      'Rua da Feira',215668200,
      'Feminino',TO_DATE('1887/04/15'),'isabix@gmail.com');

-- ----------------------------------------------------------------------------

--INSERTS Utentes - Empregados- Porto-
INSERT INTO Utentes(numero)
  VALUES(58982);

--INSERTS Utentes - Empregados- Lisboa-
INSERT INTO Utentes(numero)
  VALUES(57982);

--INSERTS Utentes - Empregados- Braga-
INSERT INTO Utentes(numero)
  VALUES(59999);

-- ----------------------------------------------------------------------------

--INSERTS Utentes - Nao Empregados- Porto-
INSERT INTO Utentes(numero)
  VALUES(41569);

--INSERTS Utentes - Nao Empregados- Lisboa-
INSERT INTO Utentes(numero)
  VALUES(49493);

--INSERTS Utentes - Nao Empregados- Braga-
INSERT INTO Utentes(numero)
  VALUES(49467);

-- ----------------------------------------------------------------------------

--INSERTS Funcionarios - Treinadores- Porto-
INSERT INTO Funcionarios(numero)
  VALUES(62034);

--INSERTS Funcionarios - Treinadores- Lisboa-
INSERT INTO Funcionarios(numero)
  VALUES(61004);

--INSERTS Funcionarios - Treinadores- Braga-
INSERT INTO Funcionarios(numero)
  VALUES(62398);

-- ----------------------------------------------------------------------------

--INSERTS Funcionarios - Gerente- Porto-
INSERT INTO Funcionarios(numero)
  VALUES(71000);

--INSERTS Funcionarios - Gerente- Lisboa-
INSERT INTO Funcionarios(numero)
  VALUES(70000);

--INSERTS Funcionarios - Gerente- Braga-
INSERT INTO Funcionarios(numero)
  VALUES(74002);

-- ----------------------------------------------------------------------------

--INSERTS Gerente- Porto-
INSERT INTO Gerente(numero)
  VALUES(71000);

--INSERTS Gerente- Lisboa-
INSERT INTO Gerente(numero)
  VALUES(70000);

--INSERTS Gerente- Braga-
INSERT INTO Gerente(numero)
  VALUES(74002);

-- ----------------------------------------------------------------------------

--INSERTS Treinador - Porto-
INSERT INTO Treinador(numero)
  VALUES(62034);

--INSERTS Treinador - Lisboa-
INSERT INTO Treinador(numero)
  VALUES(61004);

--INSERTS Treinador - Braga-
INSERT INTO Treinador(numero)
  VALUES(62398);

-- ----------------------------------------------------------------------------

--INSERT Espaco - lisboa
INSERT INTO Espaco(nome,num_ginasio)
  VALUES('Sala 2',923467824);

--INSERT Espaco - Porto
INSERT INTO Espaco(nome,num_ginasio)
  VALUES('Sala 1',123456789);

--INSERT Espaco - Braga
INSERT INTO Espaco(nome,num_ginasio)
  VALUES('Sala 3',987654321);

-- ----------------------------------------------------------------------------

--INSERT Modalidades
INSERT INTO Modalidades(nome,nivel_exigencia_fisica,
  beneficio_para_saude,duracao_exercicio
  ,descricao,faixa_etaria_recomendada)
  VALUES ('Pilates',15,'relaxamento_concentracao','00:30:00',
    'metodo de alongamento e exercicio fisico',18);


INSERT INTO Modalidades(nome,nivel_exigencia_fisica,
  beneficio_para_saude,duracao_exercicio
  ,descricao,faixa_etaria_recomendada)
  VALUES ('Yoga',30,'relaxamento_elasticidade','00:45:00',
    'disciplina espiritual',30);


INSERT INTO Modalidades(nome,nivel_exigencia_fisica,
  beneficio_para_saude,duracao_exercicio
    ,descricao,faixa_etaria_recomendada)
    VALUES ('Powerlifting',80,'perda gordura_ganho musculo','01:00:00',
      'levantamento de pesos',25);

-- ----------------------------------------------------------------------------

--INSERTS AULAS - Treinador do Porto
INSERT INTO Aula(codigo,dia_semana,hora_inicio,hora_fim,nome_modalidade
  ,nome_espaco,num_treinador)
  VALUES (121,4,'16:00','17:00','Powerlifting','Sala 1',62034);

--INSERTS AULAS - Treinador do Lisboa
INSERT INTO Aula(codigo,dia_semana,hora_inicio,hora_fim,nome_modalidade
  ,nome_espaco,num_treinador)
  VALUES (111,3,'15:00','16:00','Yoga','Sala 2',61004);

--INSERTS AULAS - Treinador do Braga
INSERT INTO Aula(codigo,dia_semana,hora_inicio,hora_fim,nome_modalidade
  ,nome_espaco,num_treinador)
  VALUES (101,6,'14:00','15:00','Pilates','Sala 3',62398);

-- ----------------------------------------------------------------------------

--INSERTS De - Preco da Aula de Powerlifting -
  INSERT INTO De (preco,codigo,nome)
      VALUES(50,121,'Powerlifting');

--INSERTS De - Preco da Aula de Yoga -
  INSERT INTO De (preco,codigo,nome)
      VALUES(70,111,'Yoga');

--INSERTS De - Preco da Aula de Pilates -
  INSERT INTO De (preco,codigo,nome)
      VALUES(60,101,'Pilates');

-- ----------------------------------------------------------------------------

--INSERT Decorre - Powerlifting decorre no espaco sala 1 -
INSERT INTO Decorre (lotacao,nome_espaco,nome_modalidade)
  VALUES(80,'Sala 1','Powerlifting');

--INSERT Decorre - Yoga decorre no espaco sala 2 -
INSERT INTO Decorre (lotacao,nome_espaco,nome_modalidade)
  VALUES(70,'Sala 2','Yoga');

--INSERT Decorre - Pilates decorre no espaco sala 3 -
INSERT INTO Decorre (lotacao,nome_espaco,nome_modalidade)
  VALUES(60,'Sala 3','Pilates');

-- ----------------------------------------------------------------------------

--INSERTS Consultados Empregados - Porto
INSERT INTO Consultados (autorizado,nome_modalidade,num_utente)
  Values(1,'Powerlifting',58982);

--INSERTS Consultados Empregados - Lisboa
INSERT INTO Consultados (autorizado,nome_modalidade,num_utente)
  Values(0,'Yoga',57982);

--INSERTS Consultados Empregados - Braga
INSERT INTO Consultados (autorizado,nome_modalidade,num_utente)
  Values(1,'Pilates',59999);

-- ----------------------------------------------------------------------------

--INSERTS Consultados NaoEmpregado - Porto
INSERT INTO Consultados (autorizado,nome_modalidade,num_utente)
  Values(1,'Powerlifting',41569);

--INSERTS Consultados NaoEmpregados - Lisboa
INSERT INTO Consultados (autorizado,nome_modalidade,num_utente)
  Values(1,'Yoga',49493);

--INSERTS Consultados NaoEmpregados - Braga
INSERT INTO Consultados (autorizado,nome_modalidade,num_utente)
  Values(1,'Pilates',49467);

-- ----------------------------------------------------------------------------

--INSERTS Inscrevem NaoEmpregados - Porto
INSERT INTO Inscrevem (data_hora_entrada,pode_ir_aula,num_utente,cod_aula)
  Values(TO_DATE('2018-JAN-01 12:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),0,41569,121);

--INSERTS Inscrevem NaoEmpregados - Lisboa
INSERT INTO Inscrevem (data_hora_entrada,pode_ir_aula,num_utente,cod_aula)
  Values(TO_DATE('2018-MAR-26 12:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),1,49493,111);

--INSERTS Inscrevem NaoEmpregados - Braga
INSERT INTO Inscrevem (data_hora_entrada,pode_ir_aula,num_utente,cod_aula)
  Values(TO_DATE('2018-FEB-26 11:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),0,49467,101);

-- ----------------------------------------------------------------------------

--INSERTS Inscrevem Empregados - Porto
INSERT INTO Inscrevem (data_hora_entrada,pode_ir_aula,num_utente,cod_aula)
  Values(TO_DATE('2018-JAN-01 12:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),0,58982,121);

--INSERTS Inscrevem Empregados - Lisboa
INSERT INTO Inscrevem (data_hora_entrada,pode_ir_aula,num_utente,cod_aula)
  Values(TO_DATE('2018-MAR-26 12:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),1,57982,111);

--INSERTS Inscrevem Empregados - Braga
INSERT INTO Inscrevem (data_hora_entrada,pode_ir_aula,num_utente,cod_aula)
  Values(TO_DATE('2018-FEB-26 11:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),0,59999,101);

-- ----------------------------------------------------------------------------

--INSERTS EMPRESA

INSERT INTO Empresa(nipc,mail,morada,telefone,pessoa_de_contacto)
  VALUES (251118752,'google@gmail.com','Rua Fonseca n2 3E',213458586,'Josefina');

INSERT INTO Empresa(nipc,mail,morada,telefone,pessoa_de_contacto)
  VALUES(291116454,'jeronimo@gmail.com','Rua Saraiva n3 4E',214547568,'Maria');

INSERT INTO Empresa(nipc,mail,morada,telefone,pessoa_de_contacto)
  VALUES(281156753,'sonae@gmail.com','Rua Rogerio n6 7D',213458325,'Isabel');

-- ----------------------------------------------------------------------------

--INSERTS EMPREGADO - Porto
INSERT INTO Empregado (numero, empresa_nipc)
  VALUES (58982,251118752);
--INSERTS EMPREGADO - Lisboa
INSERT INTO Empregado (numero, empresa_nipc)
  VALUES (57982,291116454);
--INSERTS EMPREGADO - Braga
INSERT INTO Empregado (numero, empresa_nipc)
  VALUES (59999,281156753);

-- ----------------------------------------------------------------------------

--INSERTS FATURA - Empregados
INSERT INTO Fatura(num_seq,grande_total,data_emissao,data_pagamento)
  VALUES(253698,95,TO_DATE('2018-APR-10 16:30','YYYY-MON-DD HH24:MI'
    ,'NLS_DATE_LANGUAGE=AMERICAN'),TO_DATE('2018-MAY-15 18:00','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'));

INSERT INTO Fatura(num_seq,grande_total,data_emissao,data_pagamento)
  VALUES(254789,50,TO_DATE('2018-JUL-18 13:30','YYYY-MON-DD HH24:MI'
    ,'NLS_DATE_LANGUAGE=AMERICAN'),TO_DATE('2018-AUG-29 16:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'));

INSERT INTO Fatura(num_seq,grande_total,data_emissao,data_pagamento)
  VALUES(258143,80,TO_DATE('2018-SEP-24 11:30','YYYY-MON-DD HH24:MI'
    ,'NLS_DATE_LANGUAGE=AMERICAN'),TO_DATE('2018-OCT-15 13:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'));

---------------------------------
--INSERTS FATURA - NãoEmpregados
INSERT INTO Fatura(num_seq,grande_total,data_emissao,data_pagamento)
  VALUES(253485,95,TO_DATE('2018-JUN-10 12:30','YYYY-MON-DD HH24:MI'
    ,'NLS_DATE_LANGUAGE=AMERICAN'),TO_DATE('2018-AUG-19 18:00','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'));

INSERT INTO Fatura(num_seq,grande_total,data_emissao,data_pagamento)
  VALUES(254283,50,TO_DATE('2018-JAN-12 13:30','YYYY-MON-DD HH24:MI'
    ,'NLS_DATE_LANGUAGE=AMERICAN'),TO_DATE('2018-FEB-09 16:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'));

INSERT INTO Fatura(num_seq,grande_total,data_emissao,data_pagamento)
  VALUES(258125,80,TO_DATE('2018-NOV-21 11:30','YYYY-MON-DD HH24:MI'
    ,'NLS_DATE_LANGUAGE=AMERICAN'),TO_DATE('2018-DEC-16 13:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'));

-- ----------------------------------------------------------------------------

--INSERTS NAO EMPREGADO - Porto
INSERT INTO NaoEmpregado (numero, fatura)
  VALUES (41569,253485);
--INSERTS NAO EMPREGADO - Lisboa
INSERT INTO NaoEmpregado (numero, fatura)
  VALUES (49493,254283);
--INSERTS NAO EMPREGADO - Braga
INSERT INTO NaoEmpregado (numero, fatura)
  VALUES (49467,254283);

-- ----------------------------------------------------------------------------

--INSERTS DESCONTO - Porto
INSERT INTO Desconto(valor,num_empregado,num_fatura)
  VALUES(20,58982,253698);
--INSERTS DESCONTO - Lisboa
INSERT INTO Desconto(valor,num_empregado,num_fatura)
  VALUES(40,57982,254789);
--INSERTS DESCONTO - Braga
INSERT INTO Desconto(valor,num_empregado,num_fatura)
  VALUES(15,59999,258143);

-- ----------------------------------------------------------------------------

COMMIT;

-- ----------------------------------------------------------------------------

UPDATE Ginasio
   SET gerente = 71000
 WHERE nome = 'FitPorto';

UPDATE Ginasio
   SET gerente = 70000
 WHERE nome = 'PUMPLisboa';

UPDATE Ginasio
   SET gerente = 74002
 WHERE nome = 'FitNessUpBraga';

-- ----------------------------------------------------------------------------

UPDATE Treinador
   SET nome_modalidade = 'Pilates'
 WHERE numero = 62034;

UPDATE Treinador
   SET nome_modalidade = 'Yoga'
 WHERE numero = 61004;

UPDATE Treinador
   SET nome_modalidade = 'Powerlifting'
 WHERE numero = 62398;

-- ----------------------------------------------------------------------------
COMMIT;
-- ----------------------------------------------------------------------------
