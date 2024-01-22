drop schema if exists joins;
create schema joins;
use joins;

create table departamentos(
	id int PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	sigla VARCHAR(5)
);

create table funcionarios(
	id int PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	telefone VARCHAR(15),
	endereco VARCHAR(50),
	bairro VARCHAR(20),
	cep VARCHAR(8),
	salario double,
	cidade VARCHAR(20),
	departamento_id int,
	FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

insert into departamentos values (NULL, 'Compras', 'COMPR');
insert into departamentos values (NULL, 'Comercial', 'COMER');
insert into departamentos values (NULL, 'Financeiro', 'FINAN');
insert into departamentos values (NULL, 'Marketing', 'MARKE');
insert into departamentos values (NULL, 'Diretoria', 'DIRET');	
				
insert into funcionarios values (NULL, 'Maria João', '99070012', 'Av. Gov José Malcher, 2460', 
'São Bras', '66060281', 1500.80, 'Belém', 1);
insert into funcionarios values (NULL, 'Pedro Zamora', '99989988', 'Av. Magalhães Barata, 1360', 
'Nazaré', '66055090', 2300.12, 'Belem', 2);
insert into funcionarios values (NULL, 'Andrea Pinho', '99989988', 'Boaventura da Silva, 678, ap 304', 
'Umarizal', '66075080', 4080.50, 'BELEM', 2);
insert into funcionarios values (NULL, 'Mario Silva', '2223234', 'Cidade Nova IV, 3456', 
'São Bras', '66060281', 1200.80, 'Ananindeua', 5);
insert into funcionarios values (NULL, 'Felipe Almeida', '99980088', 'Av. Roberto Camelier, 2360', 
'Jurunas', '66055090', 9300.72, 'Belem', 4);
insert into funcionarios values (NULL, 'Rafael Bezerra', '99345688', 'Passagem Maxima, 678, ap 304', 
'Marco', '66075080', 4080.50, 'BELEM', 3);
insert into funcionarios values (NULL, 'Katia Santos', '98760012', 'Trav Mauriti, 2460', 
'Marco', '66060281', 700.80, 'Belém', 4);
insert into funcionarios values (NULL, 'Gustavo Pinto', '22389988', 'Passagem Barata, 1360', 
'Cidade Nova IV', '66055090', 2300.12, 'Ananindeua', 2);
insert into funcionarios values (NULL, 'Anderson Marques', '32289988', '40 horas, 678', 
'Coqueiro', '66075080', 8900.50, 'Ananindeua', 1);
insert into funcionarios values (NULL, 'Renato Hudson', '34553234', 'Passagem Tereza, 3456', 
'Cidade Nova V', '66060281', 1450.80, 'Ananindeua', 5);
insert into funcionarios values (NULL, 'Tiago Alves', '78889988', 'Av. Magalhães Barata, 1360', 
'Nazaré', '66055090', 2990.62, 'Belem', 4);
insert into funcionarios values (NULL, 'Mario Antonio', '23489988', 'Boaventura da Silva, 678, ap 304', 
'Umarizal', '66075080', 4080.50, 'BELEM', 3);
insert into funcionarios values (NULL, 'Maria Silva', '32470012', 'Av. Gov José Malcher, 2460', 
'São Bras', '66060281', 1500.80, 'Belém', 2);
insert into funcionarios values (NULL, 'Jean Zorat', '88789988', 'Av. Magalhães Barata, 1360', 
'Nazaré', '66055090', 2823.99, 'Belem', 1);
insert into funcionarios values (NULL, 'Andre Ribeiro', '76589988', 'Boaventura da Silva, 678, ap 304', 
'Umarizal', '66075080', 3567.50, 'BELEM', 2);
insert into funcionarios values (NULL, 'Matheus Carmo', '87893234', 'Cidade Nova IV, 3456', 
'São Bras', '66060281', 1689.90, 'Ananindeua', 4);
insert into funcionarios values (NULL, 'Daniel Dantes', '22989988', 'Av. Magalhães Barata, 1360', 
'Nazaré', '66055090', 2800.12, 'Belem', 3);
insert into funcionarios values (NULL, 'Zumira Castro', '99989988', 'Boaventura da Silva, 678, ap 304', 
'Umarizal', '66075080', 8080.00, 'BELEM', 4);

-- Maior salario do departamento compras;
SELECT MAX(salario) AS maior_salario
FROM funcionarios
WHERE departamento_id = (SELECT id FROM departamentos WHERE nome = 'Compras');
-- Menor salario do departamento de compras;
SELECT MIN(salario) AS menor_salario
FROM funcionarios
WHERE departamento_id = (SELECT id FROM departamentos WHERE nome = 'Compras');
-- Media dos salarios
SELECT AVG(salario) AS media_salarios
FROM funcionarios
WHERE departamento_id = (SELECT id FROM departamentos WHERE nome = 'Compras');


-- Quantos funcionarios existem no departamento de compras
SELECT COUNT(*) AS total_funcionarios
FROM funcionarios
WHERE departamento_id = (SELECT id FROM departamentos WHERE nome = 'Compras');


-- Somando os salarios da diretoria
SELECT SUM(salario) AS total_salarios
FROM funcionarios
WHERE departamento_id = (SELECT id FROM departamentos WHERE nome = 'Diretoria');


-- Contar o numero de funcionarios de cada departamento
SELECT d.nome AS departamento, COUNT(f.id) AS total_funcionarios
FROM departamentos d
LEFT JOIN funcionarios f ON d.id = f.departamento_id
GROUP BY d.id, d.nome;


-- Somar os salarios de cada departamento
SELECT d.nome AS departamento, SUM(f.salario) AS total_salarios
FROM departamentos d
LEFT JOIN funcionarios f ON d.id = f.departamento_id
GROUP BY d.id, d.nome;


-- Somar os salarios de cada departamento, mostrar apenas com a soma maior que 20.000
SELECT d.nome AS departamento, SUM(f.salario) AS total_salarios
FROM departamentos d
LEFT JOIN funcionarios f ON d.id = f.departamento_id
GROUP BY d.id, d.nome
HAVING total_salarios > 20000;
