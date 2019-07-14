DROP TABLE IF EXISTS oficina CASCADE;
DROP TABLE IF EXISTS veiculos CASCADE;
DROP TABLE IF EXISTS funcionarios CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;
DROP TABLE IF EXISTS fornecedores CASCADE;

CREATE TABLE veiculos(
tipo varchar(4),
marca varchar(8),
modelo varchar(8),
matricula varchar(10) primary key);

CREATE TABLE funcionarios(
numF varchar(3) primary key,
nomeF varchar(60),
contactoF varchar(9),
especializaçao varchar(11)
);

CREATE TABLE fornecedores(
contactoFor varchar(9) primary key,
nomeFor varchar(60),
materais varchar(60)); 

CREATE TABLE oficina(
nomeO varchar(60),
contactoO varchar(9) primary key,
matricula varchar(10),
numF varchar(3),
foreign key (matricula) references veiculos,
foreign key (numF) references funcionarios);

CREATE TABLE clientes(
nomeC varchar(60),
contactoC varchar(9),
matricula varchar(10),
NBI varchar(8) primary key,
foreign key (matricula) references veiculos
);