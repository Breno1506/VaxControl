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
('Vinicius Henrique de Oliveira', 'vinic-oliver2@hotmail.com', 'Sabonete67', '54380282250', 'Cliente'),
('Kauã Santos Pacce', 'kauaSantos@gmail.com', '123456789', '87264581230', 'Suporte'),
('Breno de Oliveira Augusto', 'Tutu@hotmail.com', 'farinha123', '65498028850', 'Normal'),
('Pedro Luca Santos', 'PedroLuca@yahoo.com', 'Pedrinho132', '44607324823', 'Administrador'),
('Gabriel Pereira Lima', 'biel-pereira@gmail.com', 'skate333', '54638228850', 'Normal'),
('Daniel Henrique Ferreira', 'Daniel_marlon@hotmail.com', 'marmita5kg', '45320853790', 'Cliente');

SELECT * FROM usuario;

INSERT INTO empresa VALUES
(DEFAULT, 'DHL Supply Chain', '02836056000106', '119856462090'),
(DEFAULT, 'Luft Logistics Ltda', '87689402000123', '119536762890'),
(DEFAULT, 'Nippon Express', '51595908000126', '119256432596'),
(DEFAULT, 'Vivalog', '07803647000109', '119736922504'),
(DEFAULT, 'R.V. Imola', '05366444000169', '119980462090'),
(DEFAULT, 'VTCLOG', '24893687000108', '119556462009'),
(DEFAULT, 'Ativa Logística', '01125797000116', '119576319010');

SELECT * FROM empresa;

INSERT INTO camara (identificacao, comprimento_metros, id_empresa) VALUES
('Câmara 01', 13, 1),
('Câmara 02', 5, 1),
('Câmara 01', 5, 2),
('Câmara 03', 10, 1),
('Câmara 01', 15, 3),
('Câmara 02', 20, 3),
('Câmara 01', 10, 4),
('Câmara 01', 30, 5),
('Câmara 01', 5, 6),
('Câmara 02', 10, 6),
('Câmara 01', 50, 7),
('Câmara 02', 20, 7),
('Câmara 03', 10, 7);

SELECT * FROM camara;

INSERT INTO sensor (posicao_interna, status_, id_camara) VALUES
-- Câmara 01, empresa 1 (13m = 4 sensores - IDs 1 a 4)
('Próximo à porta', 'ativo', 1),
('Próximo às vacinas 1', 'ativo', 1),
('Próximo às vacinas 2', 'ativo', 1),
('Ponto mais distante', 'ativo', 1),

-- Câmara 02, empresa 1 (5m = 2 sensores - IDs 5 e 6)
('Próximo à porta', 'ativo', 2),
('Próximo às vacinas', 'ativo', 2),

-- Câmara 01, empresa 2 (5m = 2 sensores - IDs 7 e 8)
('Próximo à porta', 'ativo', 3),
('Próximo às vacinas', 'ativo', 3),

-- Câmara 03, empresa 1 (10m = 4 sensores - IDs 9 a 12)
('Próximo à porta', 'ativo', 4),
('Próximo às vacinas 1', 'ativo', 4),
('Próximo às vacinas 2', 'ativo', 4),
('Ponto mais distante', 'ativo', 4),

-- Câmara 01, empresa 3 (15m = 4 sensores - IDs 13 a 16)
('Próximo à porta', 'ativo', 5),
('Próximo às vacinas 1', 'ativo', 5),
('Próximo às vacinas 2', 'ativo', 5),
('Ponto mais distante', 'ativo', 5),

-- Câmara 02, empresa 3 (20m = 6 sensores - IDs 17 a 22)
('Próximo à porta', 'ativo', 6),
('Próximo às vacinas 1', 'ativo', 6),
('Próximo às vacinas 2', 'ativo', 6),
('Próximo às vacinas 3', 'ativo', 6),
('Próximo às vacinas 4', 'ativo', 6),
('Ponto mais distante', 'ativo', 6),

-- Câmara 01, empresa 4 (10m = 4 sensores - IDs 23 a 26)
('Próximo à porta', 'ativo', 7),
('Próximo às vacinas 1', 'ativo', 7),
('Próximo às vacinas 2', 'ativo', 7),
('Ponto mais distante', 'ativo', 7),

-- Câmara 01, empresa 5 (30m = 8 sensores - IDs 27 a 34)
('Próximo à porta', 'ativo', 8),
('Próximo às vacinas 1', 'ativo', 8),
('Próximo às vacinas 2', 'ativo', 8),
('Próximo às vacinas 3', 'ativo', 8),
('Próximo às vacinas 4', 'ativo', 8),
('Próximo às vacinas 5', 'ativo', 8),
('Próximo às vacinas 6', 'ativo', 8),
('Ponto mais distante', 'ativo', 8),

-- Câmara 01, empresa 6 (5m = 2 sensores - IDs 35 e 36)
('Próximo à porta', 'ativo', 9),
('Próximo às vacinas', 'ativo', 9),

-- Câmara 02, empresa 6 (10m = 4 sensores - IDs 37 a 40)
('Próximo à porta', 'ativo', 10),
('Próximo às vacinas 1', 'ativo', 10),
('Próximo às vacinas 2', 'ativo', 10),
('Ponto mais distante', 'ativo', 10),

-- Câmara 01, empresa 7 (50m = 12 sensores - IDs 41 a 52)
('Próximo à porta', 'ativo', 11),
('Próximo às vacinas 1', 'ativo', 11),
('Próximo às vacinas 2', 'ativo', 11),
('Próximo às vacinas 3', 'ativo', 11),
('Próximo às vacinas 4', 'ativo', 11),
('Próximo às vacinas 5', 'ativo', 11),
('Próximo às vacinas 6', 'ativo', 11),
('Próximo às vacinas 7', 'ativo', 11),
('Próximo às vacinas 8', 'ativo', 11),
('Próximo às vacinas 9', 'ativo', 11),
('Próximo às vacinas 10', 'ativo', 11),
('Ponto mais distante', 'ativo', 11),

-- Câmara 02, empresa 7 (20m = 6 sensores - IDs 53 a 58)
('Próximo à porta', 'ativo', 12),
('Próximo às vacinas 1', 'ativo', 12),
('Próximo às vacinas 2', 'ativo', 12),
('Próximo às vacinas 3', 'ativo', 12),
('Próximo às vacinas 4', 'ativo', 12),
('Ponto mais distante', 'ativo', 12),

-- Câmara 03, Empresa 7 (10m = 4 sensores - IDs 59 a 62)
('Próximo à porta', 'ativo', 13),
('Próximo às vacinas 1', 'ativo', 13),
('Próximo às vacinas 2', 'ativo', 13),
('Ponto mais distante', 'ativo', 13);


INSERT INTO leitura (temperatura, umidade, id_sensor) VALUES
-- Leituras da Câmara 1 (Sensores 1 a 4)
(7.80, 1), -- Sensor da porta (mais quente)
(4.50, 2), -- Sensor vacina 1 (normal)
(4.20, 3), -- Sensor vacina 2 (normal)
(2.30, 4), -- Sensor distante (mais frio)

-- Leituras da Câmara 2 (Sensores 5 e 6)
(6.50, 5), -- Sensor da porta
(3.80, 6), -- Sensor vacina

-- Leituras da Câmara 3 (Sensores 7 e 8)
(7.10, 7), 
(4.10, 8),

-- Leituras da Câmara 4 (Sensores 9 a 12)
(6.80, 9),
(5.00, 10),
(4.90, 11),
(2.80, 12),

-- Leituras simulando a Câmara 11 gigante de 50 metros (Sensores 41 a 52)
(8.20, 41), -- ALERTA - Porta aberta, passou de 8°C
(6.50, 42),
(5.80, 43),
(5.50, 44),
(5.10, 45),
(4.80, 46),
(4.50, 47),
(4.00, 48),
(3.50, 49),
(3.10, 50),
(2.50, 51),
(1.80, 52); -- ALERTA - Ponto distante super resfriado, abaixo de 2°C



-- (TEMPERATURA IDEAL DAS VACINAS HPV 2°C A 8°C) -- UTILIZAR O CONCAT X°C EM TODOS SELECTS
-- TENTAR FAZER UM SELECT CONCATENANDO OU USANDO OPERAÇÕES ARITMÉTICAS
