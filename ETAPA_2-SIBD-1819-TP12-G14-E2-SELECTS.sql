-- SIBD 2018-12-14 ETAPA 2
-- GRUPO 14
-- Daniel Nunes 49467
-- Inês Gonçalves 49493
-- João Rangel 47982
-- Manuel Tovar 49522


--  SELECT 1 --
/*  NIF e nome dos utentes que frequentaram aulas (pelo menos uma) em 2017, bem como as modalidades
    praticadas e as datas. O resultado não deve ter repetições e deve vir ordenado pela
    modalidade, nome, e NIF de forma ascendente, e pela data da aula de forma descendente.  */

  SELECT DISTINCT u.nif, u.nome, a.modalidade, f.data
    FROM utente u, aula a, frequenta f
   WHERE u.nif = f.utente
     AND a.id = f.aula
     AND TO_CHAR((f.data),'YYYY') = '2017'
ORDER BY modalidade ASC, nome ASC, nif ASC, data DESC;

-- SELECT 2
/* Espaço e modalidade com aulas frequentadas por utentes que foram ao ginásio pelo menos uma
   vez ao domingo, ou então frequentadas por utentes do género masculino nascidos no século
   XXI, isto é, a partir de 2001, inclusive. Nota: pode usar construtores de conjuntos. */

(SELECT DISTINCT a.espaco, a.modalidade
   FROM aula a, frequenta f, utente u
  WHERE f.utente = u.nif
    AND f.aula = a.id
    AND a.dia_semana = 'SUN')
  UNION
(SELECT a2.espaco, a2.modalidade
   FROM aula a2, frequenta f2, utente u2
  WHERE f2.utente = u2.nif
    AND f2.aula = a2.id
    AND u2.genero = 'M'
    AND u2.ano >= 2001);

-- SELECT 3
/* Dia de semana, horas de início e fim, espaço, e modalidade das aulas começadas ou terminadas
   da parte da tarde, e frequentadas em janeiro de 2018, por utentes com nome começado pela letra
   ‘C’, com idade entre os 17 e os 45 anos. */

SELECT a.dia_semana, a.hora_inicio, a.hora_fim, a.espaco, a.modalidade
  FROM utente u, aula a, frequenta f
 WHERE u.nif = f.utente
   AND a.id = f.aula
   AND TO_CHAR((f.data),'YYYY.MM') = '2018.01'
   AND a.hora_inicio > 12 OR a.hora_fim > 12
   -- Considerámos que a hora que foi inserida está em 24H e que às 12h00 já pertence à tarde
   AND(TO_CHAR(CURRENT_DATE,'YYYY') - u.ano) BETWEEN 17 AND 45
   AND u.nome = 'C%';

-- SELECT 4
/* NIF, nome, e idade dos utentes que nunca frequentaram aulas de ginástica começadas de manhã.
   O resultado deve vir ordenado pela idade do utente de forma descendente.*/

  SELECT DISTINCT u.nif, u.nome, TO_CHAR(CURRENT_DATE,'YYYY') - u.ano AS Idade
    FROM utente u, aula a, frequenta f
   WHERE (u.nif = f.utente)
     AND (f.aula = a.id)
     AND ('ginastica' NOT IN (SELECT a.modalidade FROM aula a, frequenta f WHERE f.aula=a.id)
      OR(a.modalidade = 'ginastica' AND a.hora_inicio BETWEEN 13 AND 23 ))
ORDER BY Idade DESC;

-- SELECT 5
/* Modalidade, espaço, dia de semana, e hora de início das aulas frequentadas por todas as utentes
   (género feminino) nascidas no ano em que nasceram mais utentes (ambos os géneros) do ginásio.
   No caso de existirem vários anos candidatos, deve ser escolhido o mais recente. O resultado
   deve vir ordenado pelo dia de semana, hora de início, e modalidade de forma ascendente*/
  SELECT a.modalidade, a.espaco, a.dia_semana, a.hora_inicio
    FROM aula a, utente u, frequenta f
   WHERE f.utente = u.nif
     AND f.aula = a.id
     AND u.genero = 'F'
     AND u.ano = (SELECT * FROM (SELECT u.ano FROM utente u GROUP BY u.ano ORDER BY COUNT(u.ano) DESC, u.ano DESC) WHERE ROWNUM = 1)
ORDER BY a.dia_semana ASC, a.hora_inicio ASC, a.modalidade ASC;

-- SELECT 6
/* Total pago e valor do IVA à taxa 23% das aulas frequentadas por cada utente, com NIF e nome,
   para cada ano e modalidade, assumindo que cada aula custa 10 euros. O resultado deve vir ordenado
   pelo NIF do utente e modalidade de forma ascendente, e pelo ano de forma descendente. */
  SELECT u.nif, u.nome, a.modalidade, to_char(f.data, 'YYYY') AS ano, ((COUNT(f.aula))*10) AS total_pago, ((COUNT(f.aula))*10*0.23) AS valor_IVA
    FROM utente u, aula a, frequenta f
   WHERE f.utente = u.nif
     AND f.aula = a.id
GROUP BY u.nif, u.nome, a.modalidade, to_char(f.data, 'YYYY')
ORDER BY u.nif ASC, a.modalidade ASC, ano DESC;

-- SELECT 7
/* Para cada utente, com NIF e nome, calcular a soma das horas das aulas que já frequentou. Caso
   um utente não tenha ainda frequentado aulas, deve aparecer o valor zero na soma. O resultado
   deve vir ordenado de forma descendente pela soma das horas das aulas, e pelo NIF e nome do
   utente de forma ascendente. Dica: a função NVL pode ser útil. */
SELECT DISTINCT u.nif, u.nome,  NVL(COUNT(a.hora_fim - a.hora_inicio),0) AS horas
  FROM (utente u FULL OUTER JOIN frequenta f ON (f.utente = u.nif)) LEFT OUTER JOIN aula a ON (f.aula = a.id)
GROUP BY u.nif, u.nome
ORDER BY horas DESC, u.nif ASC,u.nome ASC;


-- SELECT 8
/*  NIF e nome dos utentes com maior quantidade de aulas frequentadas em cada ano, separadamente
    para homens e mulheres. Em caso de empate, devem ser mostrados todos os utentes em
    causa. O resultado deve vir ordenado pelo ano de forma descendente, e pelo género, NIF, e
    nome dos utentes de forma ascendente  */
  SELECT u.nif, u.nome, u.genero, TO_CHAR((f.data),'YYYY') AS ano, COUNT(f.aula)
    FROM utente u, frequenta f
   WHERE u.nif = f.utente
GROUP BY  u.nif, u.nome, TO_CHAR((f.data),'YYYY'), u.genero
  HAVING COUNT(f.aula) >= (SELECT COUNT(f1.aula)
                             FROM utente u1,frequenta f1
                            WHERE u1.nif = f1.utente
                              AND u1.genero = u.genero
                              AND TO_CHAR((f.data),'YYYY') = TO_CHAR((f1.data),'YYYY') )
ORDER BY ano DESC, u.genero ASC, u.nif ASC, u.nome ASC;
