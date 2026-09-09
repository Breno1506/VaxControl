CREATE DATABASE bd_vaxcontrol;
USE bd_vaxcontrol;

CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    email VARCHAR(50),
    senha VARCHAR(20),
    cpf CHAR(11),
    tipo_acesso VARCHAR(20)
);

CREATE TABLE empresa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(50),
    cnpj CHAR(14),
    telefone VARCHAR(15)
);

CREATE TABLE camara (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_camara VARCHAR(30),
    comprimento DECIMAL(4,2),
    temp_min DECIMAL(4,2),
    temp_max DECIMAL(4,2)
);

CREATE TABLE sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    posicao VARCHAR(30),
    status_sensor VARCHAR(15)
);

CREATE TABLE historico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(4,2),
    umidade DECIMAL(4,2),
    dt_hora DATETIME
);

INSERT INTO empresa VALUES 
(NULL, 'Posto de Saude Central', '12345678000199', '11999998888');

INSERT INTO camara VALUES 
(NULL, 'Camara Vacina HPV', 5.50, 2.00, 8.00, 1);

INSERT INTO sensor VALUES 
(NULL, 'Lado Esquerdo', 'Ativo', 1);

INSERT INTO historico VALUES 
(NULL, 10.50, 50.00, '2026-03-08 14:00:00', 1),
(NULL, 5.00, 48.00, '2026-03-08 14:05:00', 1);

SELECT 
	id, 
    CONCAT(temperatura, '°C') AS temperatura_formatada,
    CONCAT(umidade, '%') AS umidade_formatada,
    dt_hora 
FROM leitura;

SELECT 
    id,
    temperatura,
    (temperatura - 8.00) AS diferenca_da_temp_maxima
FROM leitura;