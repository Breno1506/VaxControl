-- Criacao e selecao do banco de dados
CREATE DATABASE vaxControl;
USE vaxControl;

-- Tabela de empresas clientes
CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR(50) NOT NULL,
    cnpjEmpresa CHAR(14) UNIQUE NOT NULL
);

-- Tabela de usuarios do sistema
CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nomeUsuario VARCHAR(50) NOT NULL,
    emailUsuario VARCHAR(50) UNIQUE NOT NULL,
    cargoUsuario VARCHAR(20),
    CONSTRAINT chkCargo CHECK (cargoUsuario IN ('Administrador', 'Operador'))
);

-- Tabela de camaras frias ou geladeiras
CREATE TABLE camaraFria (
    idCamaraFria INT PRIMARY KEY AUTO_INCREMENT,
    nomeCamaraFria VARCHAR(40) NOT NULL,
    tempMinima DECIMAL(4,2) DEFAULT 2.00,
    tempMaxima DECIMAL(4,2) DEFAULT 8.00,
    statusCamara VARCHAR(20),
    CONSTRAINT chkStatusCamara CHECK (statusCamara IN ('Ativo', 'Manutenção', 'Inativo'))
);

-- Tabela de leituras dos sensores
CREATE TABLE leituraSensor (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    temperatura DECIMAL(4,2) NOT NULL,
    umidade DECIMAL(4,2) NOT NULL,
    dtHoraLeitura DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Inserção de dados

INSERT INTO empresa (nomeEmpresa, cnpjEmpresa) VALUES
('Hospital Vital', '12345678000199'),
('Clinica Vacina Ja', '98765432000111');

INSERT INTO usuario (nomeUsuario, emailUsuario, cargoUsuario) VALUES
('Gabriel Lima', 'gabriel@vaxcontrol.com', 'Administrador'),
('Ana Souza', 'ana@vaxcontrol.com', 'Operador');

INSERT INTO camaraFria (nomeCamaraFria, tempMinima, tempMaxima, statusCamara) VALUES
('Câmara Principal A', 2.00, 8.00, 'Ativo'),
('Geladeira Auxiliar B', 2.00, 8.00, 'Manutenção');

INSERT INTO leituraSensor (temperatura, umidade) VALUES
(4.50, 55.00),
(9.20, 60.50),
(1.80, 50.20);

-- Selects

-- Selecionar todos os usuarios
SELECT * FROM usuario;

-- Selecionar camaras frias por ordem alfabetica
SELECT nomeCamaraFria, statusCamara FROM camaraFria ORDER BY nomeCamaraFria ASC;

-- Selecionar leituras exibindo a data e hora diretamente
SELECT idLeitura, temperatura, umidade, dtHoraLeitura FROM leituraSensor;

-- Verificar se a temperatura esta na faixa ideal (2°C a 8°C)
SELECT 
    idLeitura,
    temperatura,
    CASE 
        WHEN temperatura BETWEEN 2.00 AND 8.00 THEN 'Temperatura Normal'
        WHEN temperatura > 8.00 THEN 'Alerta: Temperatura Alta'
        ELSE 'Alerta: Temperatura Baixa'
    END AS statusTemperatura
FROM leituraSensor;

-- Mensagem concatenada para leituras fora do limite
SELECT 
    CONCAT('Atenção! A leitura ID ', idLeitura, ' registrou ', temperatura, '°C.') AS mensagemAlerta
FROM leituraSensor 
WHERE temperatura < 2.00 OR temperatura > 8.00;