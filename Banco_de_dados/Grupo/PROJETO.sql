CREATE DATABASE Projeto;

USE Projeto;

CREATE TABLE usuario (
id INT PRIMARY KEY AUTO_INCREMENT, 
nome_completo VARCHAR(70) NOT NULL, -- nome completo do úsuario
email VARCHAR(60) UNIQUE NOT NULL, -- email para registro/login
senha VARCHAR(30) NOT NULL,  -- senha para registro/login
cpf CHAR(11) UNIQUE NOT NULL, -- cpf para identificar o úsuario
acesso VARCHAR(20) -- Tipos de acesso para o úsuario para separar permissões/conteúdos
CONSTRAINT chCheck CHECK (acesso IN ('administrador', 'suporte', 'normal', 'cliente')) 
);

CREATE TABLE empresa(
id INT PRIMARY KEY AUTO_INCREMENT,
razao_social VARCHAR(70) NOT NULL, -- NOME DA EMPRESA
cnpj CHAR(14) UNIQUE, -- CNPJ DA EMPRESA, COM FINS DE IDENTIFICAR QUANTOS SENSORES INSTALADOS EM CÂMARAS A EMPRESA TEM E QUANTOS DASHBOARDS VÃO APARECER
telefone VARCHAR(12) UNIQUE -- TELEFONE DE CONTATO PARA O CNPJ ESPECIFICO, CASO OCORRA ALGUM PROBLEMA COM O SENSOR OU ERRO DE LEVANTAMENTOS DE DADOS
);

CREATE TABLE camara(
id INT PRIMARY KEY AUTO_INCREMENT,
identificacao VARCHAR(50) NOT NULL, -- "NOME" DA CÂMARA, PARA CASO HAJA MAIS DE UMA, O FUNCIONÁRIO CONSEGUIR DIFERENCIAR UMA DAS OUTRAS.
comprimento_metros DECIMAL (4,2), -- COMPRIMENTO EM METROS DA CÂMARA PARA SABER QUANTOS SENSORES POSICIONAR
temp_minima DECIMAL(4,2) DEFAULT 2.00, -- TEMPERATURA MINÍMA PARA CONTROLE
temp_maxima DECIMAL(4,2) DEFAULT 8.00, -- TEMPERATURA MÁXIMA PARA CONTROLE
id_empresa INT -- LIGAÇÃO COM A EMPRESA SEM UTILIZAR FOREIGN KEY 
);

CREATE TABLE sensor(
id INT PRIMARY KEY AUTO_INCREMENT,
posicao_interna VARCHAR(50), -- IDENTIFICAR ONDE ESTÁ O SENSOR(CASO HAJA 2 SENSORES NA MESMA CÂMARA, SABEMOS QUAL ESTÁ LENDO TAL TEMPERATURA/UMIDADE)
status_ VARCHAR(20) DEFAULT 'ativo' -- STATUS DO SENSOR
CONSTRAINT chStatus CHECK (status_ IN ('ativo', 'inativo', 'concerto')), -- REGRA PARA CHECAR O INSERT DO STATUS
id_camara INT -- LIGAÇÃO COM A CAMARA (AQUI VOCÊ DIZ EM QUAL CÂMARA O SENSOR ESTÁ, PODENDO HAVER MAIS DE UM SENSOR POR CÂMARA)
);


CREATE TABLE leitura( 
id INT PRIMARY KEY AUTO_INCREMENT, 
temperatura DECIMAL(4,2), -- DADOS DE TEMPERATURA QUE O SENSOR VAI NOS FORNECER
dtRegistros DATETIME DEFAULT CURRENT_TIMESTAMP, -- DATA E HORÁRIO EM QUE OS REGISTROS FORAM COMPUTADOS
id_sensor INT -- LIGAÇÃO COM O SENSOR QUE FEZ A MEDIÇÃO (SEM USAR FOREIGN KEY)
);



INSERT INTO usuario (nome_completo, email, senha, cpf, acesso) VALUES
('Bianca Ramos da Silva', 'bianca_terraria@gmail.com', 'terraria_123', '59627508501', 'Administrador'), 
('Vinicius Henrique de Oliveira', 'vinic-oliver2@hotmail.com', 'Sabonete67', '54380282250', 'Cliente'), -- primeiro cliente ( 1 empresa )
('Kauã Santos Pacce', 'kauaSantos@gmail.com', '123456789', '87264581230', 'Suporte'),
('Breno de Oliveira Augusto', 'Tutu@hotmail.com', 'farinha123', '65498028850', 'Normal'),
('Pedro Luca Santos', 'PedroLuca@yahoo.com', 'Pedrinho132', '44607324823', 'Cliente'), -- segundo cliente ( 1 empresa )
('Gabriel Pereira Lima', 'biel-pereira@gmail.com', 'skate333', '54638228850', 'Cliente'), -- terceiro cliente ( 1 empresa )
('Daniel Henrique Ferreira', 'Daniel_marlon@hotmail.com', 'marmita5kg', '45320853790', 'Cliente'); -- quarto cliente ( 1 empresa )

SELECT * FROM usuario;

INSERT INTO empresa VALUES
(DEFAULT, 'DHL Supply Chain', '02836056000106', '119856462090'),
(DEFAULT, 'Luft Logistics Ltda', '87689402000123', '119536762890'),
(DEFAULT, 'Nippon Express', '51595908000126', '119256432596'),
(DEFAULT, 'Vivalog', '07803647000109', '119736922504');

SELECT * FROM empresa;

INSERT INTO camara (identificacao, comprimento_metros, id_empresa) VALUES
('Câmara 01', 10, 1),
('Câmara 02', 5, 1),
('Câmara 01', 5, 2),
('Câmara 01', 10, 3),
('Câmara 01', 5, 4);

SELECT * FROM camara;

INSERT INTO sensor (posicao_interna, status_, id_camara) VALUES
-- Câmara 01 - Empresa 1 - 10m = 4 sensores
('Próximo à porta', 'ativo', 1),
('Próximo às vacinas 1', 'ativo', 1),
('Próximo às vacinas 2', 'ativo', 1),
('Ponto mais distante', 'concerto', 1),
-- Câmara 02 - Empresa 1 - 5m = 2 sensores
('Próximo à porta', 'ativo', 2),
('Próximo às vacinas', 'ativo', 2),
-- Câmara 01 - Empresa 2 - 5m = 2 sensores
('Próximo à porta', 'ativo', 3),
('Próximo às vacinas', 'ativo', 3),
-- Câmara 01 - Empresa 3 - 10m = 4 sensores
('Próximo à porta', 'ativo', 6),
('Próximo às vacinas 1', 'ativo', 6),
('Próximo às vacinas 2', 'inativo', 6),
('Ponto mais distante', 'ativo', 6),
-- Câmara 01 - Empresa 4 - 5m = 2 sensores 
('Próximo à porta', 'ativo', 7),
('Próximo às vacinas', 'ativo', 7);

INSERT INTO leitura (temperatura, id_sensor) VALUES
-- Câmara 01 - Empresa 1 (Sensores 1 a 4)
(7.80, 1), -- Porta (mais quente)
(4.50, 2), -- Vacinas (normal)
(4.20, 3), -- Vacinas (normal)
(2.30, 4), -- Fundo (mais frio)

-- Câmara 02 - Empresa 1 (Sensores 5 e 6)
(6.50, 5), 
(3.80, 6), 
-- Câmara 01 - Empresa 2 (Sensores 7 e 8)
(7.10, 7), 
(4.10, 8),
-- Câmara 03 - Empresa 1 (Sensores 9 a 12)
(6.80, 9),
(5.00, 10),
(4.90, 11),
(2.80, 12),
-- Câmara 01 - Empresa 3 (Sensores 13 a 16)
(8.20, 13), -- ALERTA - Porta aberta, acima de 8°C
(5.20, 14),
(4.80, 15),
(2.50, 16),
-- Câmara 01 - Empresa 5 (Sensores 17 e 18)
(6.90, 21),
(4.80, 22);

-- SELECTS

-- USUARIO
SELECT id, nome_completo, email, cpf, acesso FROM usuario;

-- EMPRESA
SELECT * FROM empresa;

-- CÂMARA
SELECT 
id, 
identificacao AS nome_da_camara, 
CONCAT(comprimento_metros, 'M') AS comprimento_metros, 
CONCAT(temp_minima, '°C'),
CONCAT(temp_maxima, '°C') 
FROM camara;

-- SENSOR
SELECT 
id,
posicao_interna AS localização,
status_ 
FROM sensor WHERE status_='ativo';

-- LEITURA
SELECT 
id,
CONCAT (temperatura,'°C') AS temperatura,
DATE_FORMAT(dtRegistros, '%d/%m/%Y %H:%i:%s') AS 'data do registro'
FROM leitura;





