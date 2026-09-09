CREATE DATABASE tabelasPi;

USE tabelasPi;

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome_completo VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
senha VARCHAR(100) NOT NULL,
identificador VARCHAR(15) 
CONSTRAINT chCheck CHECK (identificador IN ('cliente', 'suporte', 'administrador'))
);

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nomeEmpresa VARCHAR(50),
cnpj CHAR(14) UNIQUE, 
telefone VARCHAR(12) UNIQUE 
);

CREATE TABLE camara(
id INT PRIMARY KEY AUTO_INCREMENT,
identificacao VARCHAR(50) NOT NULL, 
comprimento_metros DECIMAL (4,2), 
temp_minima DECIMAL(4,2) DEFAULT 2.00, 
temp_maxima DECIMAL(4,2) DEFAULT 8.00
);

CREATE TABLE sensor(
id INT PRIMARY KEY AUTO_INCREMENT,
status_ VARCHAR(20) DEFAULT 'ativo' 
CONSTRAINT chStatus CHECK (status_ IN ('ativo', 'inativo', 'concerto'))
);


CREATE TABLE leitura( 
id INT PRIMARY KEY AUTO_INCREMENT, 
temperatura DECIMAL(4,2),
dataHora DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuario (nome_completo, email, senha, identificador) VALUES
('Carlos Silva', 'carlos.silva@email.com', 'Senha123@', 'cliente'),
('Mariana Lima', 'mariana.lima@email.com', 'Admin456#', 'administrador');

INSERT INTO empresa (nomeEmpresa, cnpj, telefone) VALUES
('TechLog Soluções', '12345678000199', '11987654321'),
('PharmaCold Brasil', '98765432000111', '11912345678');

INSERT INTO camara (identificacao, comprimento_metros, temp_minima, temp_maxima) VALUES
('Câmara Fria A1', 5.50, 2.00, 8.00),
('Câmara Fria B2', 8.25, 2.00, 6.00);

INSERT INTO sensor (status_) VALUES
('ativo'),
('inativo');

INSERT INTO leitura (temperatura) VALUES
(4.50),
(5.20);

SELECT *  FROM usuario;

SELECT *  FROM sensor, leitura;

SELECT
idEmpresa,
CONCAT('Nome da empresa: ', nomeEmpresa, '  -  ', 'Nome do usuario: ', cnpj) AS junção
FROM empresa
WHERE idEmpresa = 1;

SELECT idUsuario, nome_completo, email, identificador FROM usuario;