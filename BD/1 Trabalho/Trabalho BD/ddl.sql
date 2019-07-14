DROP TABLE IF EXISTS pessoa CASCADE; 
DROP TABLE IF EXISTS carro CASCADE; 
DROP TABLE IF EXISTS acidente CASCADE; 
DROP TABLE IF EXISTS tem CASCADE; 
DROP TABLE IF EXISTS participacao CASCADE;

CREATE TABLE pessoa(
id_condutor varchar(3) primary key,
nome varchar(60),
endereço varchar(60)
);

CREATE TABLE carro(
niv varchar(6) primary key,
modelo varchar(25),
ano varchar(4)
);

CREATE TABLE acidente(
numero_relatorio varchar(5) primary key,
data varchar(10),
local varchar(50)
);

CREATE TABLE tem(
id_condutor varchar(3),
niv varchar(6),
primary key (id_condutor, niv),
foreign key (id_condutor) references pessoa,
foreign key (niv) references carro
);

CREATE TABLE participacao(
numero_relatorio varchar(5),
niv varchar(6),
id_condutor varchar(3),
valor_danos varchar(9),
primary key (numero_relatorio, niv),
foreign key (numero_relatorio) references acidente,
foreign key (niv) references carro
);


