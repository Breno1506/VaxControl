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

CREATE TABLE histórico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(4,2),
    umidade DECIMAL(4,2),
    dt_hora DATETIME
);
