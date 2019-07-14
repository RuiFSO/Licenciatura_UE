/* Introdutorio */

/* Ver todos os acidentes no dia 7 de Janeiro de 2014

SELECT *
FROM acidente
WHERE data = '07/01/2014';
*/

/* Contar o numero de relatorios do condutor com o numero de identificação 12

SELECT COUNT (numero_relatorio)
FROM participacao
WHERE id_condutor = '12'; 
*/

/* Ver todas as matriculas do carros com a marca Audi

SELECT niv
FROM carro
WHERE modelo = 'Audi';


/* Ver quais o modelo dos carros registados a partir do ano 2000
SELECT modelo
FROM carro
WHERE ano > '2000';
*/

/* Intermedio */


