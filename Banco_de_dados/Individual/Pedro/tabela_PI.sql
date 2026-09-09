CREATE DATABASE bd_vaxcontrol;
USE bd_vaxcontrol;

-- Tabela de usuarios simplificada (sem contraints de checagem ou campos muito especificos)
CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    email VARCHAR(50),
    senha VARCHAR(20),
    cpf CHAR(11),
    tipo_acesso VARCHAR(20)
);

-- Tabela de empresa simples
CREATE TABLE empresa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(50),
    cnpj CHAR(14),
    telefone VARCHAR(15)
);

-- Tabela de camara simples (valores fixos sem padronização avançada)
CREATE TABLE camara (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome_camara VARCHAR(30),
    comprimento DECIMAL(4,2),
    temp_min DECIMAL(4,2),
    temp_max DECIMAL(4,2),
);

-- Tabela de sensor simples (sem validação de status)
CREATE TABLE sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    posicao VARCHAR(30),
    status_sensor VARCHAR(15),
);

-- Tabela de leituras simples
CREATE TABLE leitura (
    id INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(4,2),
    umidade DECIMAL(4,2),
    dt_hora DATETIME,
);

-- Inserts de teste
INSERT INTO empresa VALUES 
(NULL, 'Posto de Saude Central', '12345678000199', '11999998888');

INSERT INTO camara VALUES 
(NULL, 'Camara Vacina HPV', 5.50, 2.00, 8.00, 1);

INSERT INTO sensor VALUES 
(NULL, 'Lado Esquerdo', 'Ativo', 1);

INSERT INTO leitura VALUES 
(NULL, 10.50, 50.00, '2026-03-08 14:00:00', 1),
(NULL, 5.00, 48.00, '2026-03-08 14:05:00', 1);

-- Select concatenando '°C' na temperatura
SELECT 
    id, 
    CONCAT(temperatura, '°C') AS temperatura_formatada,
    CONCAT(umidade, '%') AS umidade_formatada,
    dt_hora 
FROM leitura;

-- Select com operacao aritmetica simples (Calculando variação em relação à temp máxima de 8°C)
SELECT 
    id,
    temperatura,
    (temperatura - 8.00) AS diferenca_da_temp_maxima
FROM leitura;