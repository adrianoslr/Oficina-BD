-- Criação e Teste do Banco de Dados Oficina
CREATE DATABASE Oficina;
USE Oficina;

-- Script de Criação
-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100)
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(50) NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    ano INT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela Funcionário
CREATE TABLE Funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2)
);

-- Tabela Serviço
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(200) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

-- Tabela Ordem de Serviço
CREATE TABLE Ordem_de_Servico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_veiculo INT,
    id_funcionario INT,
    id_servico INT,
    data_servico DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_funcionario) REFERENCES Funcionario(id_funcionario),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);


### Dados de Teste
sql
-- Inserir Clientes
INSERT INTO Cliente (nome, telefone, email) VALUES
('João Silva', '11999999999', 'joao@gmail.com'),
('Maria Oliveira', '11988888888', 'maria@gmail.com');

-- Inserir Veículos
INSERT INTO Veiculo (modelo, placa, ano, id_cliente) VALUES
('Civic', 'ABC1234', 2020, 1),
('Corolla', 'XYZ5678', 2019, 2);

-- Inserir Funcionários
INSERT INTO Funcionario (nome, cargo, salario) VALUES
('Carlos Souza', 'Mecânico', 3000.00),
('Ana Lima', 'Atendente', 2000.00);

-- Inserir Serviços
INSERT INTO Servico (descricao, preco) VALUES
('Troca de Óleo', 150.00),
('Alinhamento', 100.00);

-- Inserir Ordens de Serviço
INSERT INTO Ordem_de_Servico (id_cliente, id_veiculo, id_funcionario, id_servico, data_servico, status) VALUES
(1, 1, 1, 1, '2025-01-15', 'Concluído'),
(2, 2, 1, 2, '2025-01-16', 'Em Andamento');


## Exemplos de Queries
### Recuperações Simples
sql
-- Listar todos os clientes
SELECT * FROM Cliente;


### Filtro com WHERE
sql
-- Buscar ordens de serviço em andamento
SELECT * FROM Ordem_de_Servico WHERE status = 'Em Andamento';


### Atributos Derivados
sql
-- Calcular total com base no preço do serviço
SELECT id_os, id_servico, preco, preco * 1.1 AS total_com_imposto
FROM Servico;


### Ordenação
sql
-- Listar veículos por ano de fabricação (mais recentes primeiro)
SELECT * FROM Veiculo ORDER BY ano DESC;


### HAVING
sql
-- Serviços mais caros que R$ 120,00
SELECT id_servico, descricao, preco
FROM Servico
GROUP BY id_servico, descricao, preco
HAVING preco > 120.00;


### Junções
sql
-- Exibir detalhes das ordens de serviço com informações de clientes e veículos
SELECT 
    os.id_os, c.nome AS cliente, v.modelo AS veiculo, 
    s.descricao AS servico, os.data_servico, os.status
FROM 
    Ordem_de_Servico os
JOIN Cliente c ON os.id_cliente = c.id_cliente
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
JOIN Servico s ON os.id_servico = s.id_servico;