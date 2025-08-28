CREATE DATABASE revenda_joaoB;

CREATE TABLE endereco(
    endereco_id SERIAL PRIMARY KEY,
    bairro VARCHAR(20) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    uf CHAR(2) NOT NULL,
    pais VARCHAR(30) NOT NULL
);

CREATE TABLE cliente(
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    cpf CHAR(12) NOT NULL UNIQUE,
    telefone VARCHAR(15) NOT NULL UNIQUE,
    email VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE fornecedor(
    fornecedor_id SERIAL PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    endereco_id INT,
    FOREIGN KEY (endereco_id) REFERENCES endereco(endereco_id)
);

CREATE TABLE produtos(
    produtos_id SERIAL PRIMARY KEY,
    preco NUMERIC(10,2) NOT NULL,
    quantidade INT NOT NULL,
    nome VARCHAR(20) NOT NULL,
    tamanho VARCHAR(7) NOT NULL
);

CREATE TABLE vendas(
    vendas_id SERIAL PRIMARY KEY,
    cliente_id INT,
    produtos_id INT,
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY (produtos_id) REFERENCES produtos(produtos_id)
);

CREATE TABLE funcionario(
    funcionario_id SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    cargo VARCHAR(20),
    cpf CHAR(12),
    data_nascimento DATE
);
CREATE VIEW clientes_ativos AS
SELECT
  c.cliente_id,
  c.nome,
  c.email
FROM clientes
JOIN clientes c ON p.id_cliente = e.endereco_id;

CREATE VIEW endereco_verdadeiro AS
SELECT
  e.endereco_id,
  e.pais,
  e.cidade,
  e.uf
FROM endereco
JOIN endereco c ON e.endereco_id = c.id_cliente;

INSERT INTO endereco (bairro, cidade, uf, pais) VALUES
('Centro', 'São Paulo', 'SP', 'Brasil'),
('Jardim América', 'São Paulo', 'SP', 'Brasil'),
('Copacabana', 'Rio de Janeiro', 'RJ', 'Brasil'),
('Boa Viagem', 'Recife', 'PE', 'Brasil'),
('Pinheiros', 'São Paulo', 'SP', 'Brasil'),
('Savassi', 'Belo Horizonte', 'MG', 'Brasil'),
('Barra', 'Salvador', 'BA', 'Brasil'),
('Moema', 'São Paulo', 'SP', 'Brasil'),
('Ipanema', 'Rio de Janeiro', 'RJ', 'Brasil'),
('Moinhos de Vento', 'Porto Alegre', 'RS', 'Brasil');

INSERT INTO cliente (nome, cpf, telefone, email) VALUES
('João Silva', '123456789012', '11999999999', 'joao@mail.com'),
('Maria Souza', '234567890123', '11988888888', 'maria@mail.com'),
('Pedro Santos', '345678901234', '11977777777', 'pedro@mail.com'),
('Ana Lima', '456789012345', '11966666666', 'ana@mail.com'),
('Carlos Pereira', '567890123456', '11955555555', 'carlos@mail.com'),
('Mariana Alves', '678901234567', '11944444444', 'mariana@mail.com'),
('Lucas Costa', '789012345678', '11933333333', 'lucas@mail.com'),
('Fernanda Rocha', '890123456789', '11922222222', 'fernanda@mail.com'),
('Bruno Melo', '901234567890', '11911111111', 'bruno@mail.com'),
('Camila Nunes', '012345678901', '11900000000', 'camila@mail.com');

INSERT INTO fornecedor (nome, cnpj, endereco_id) VALUES
('Fornecedor A', '12345678000199', 1),
('Fornecedor B', '23456789000188', 2),
('Fornecedor C', '34567890000177', 3),
('Fornecedor D', '45678900000166', 4),
('Fornecedor E', '56789000000155', 5),
('Fornecedor F', '67890000000144', 6),
('Fornecedor G', '78900000000133', 7),
('Fornecedor H', '89000000000122', 8),
('Fornecedor I', '90000000000111', 9),
('Fornecedor J', '01234567000100', 10);


INSERT INTO produtos (preco, quantidade, nome, tamanho) VALUES
(59.90, 10, 'Camiseta Polo', 'M'),
(89.90, 15, 'Calça Jeans', '42'),
(120.00, 5, 'Jaqueta Couro', 'G'),
(39.90, 20, 'Camisa Social', 'P'),
(25.00, 30, 'Meia', 'Único'),
(79.90, 8, 'Vestido', 'M'),
(55.00, 12, 'Shorts', 'G'),
(199.90, 3, 'Tênis', '42'),
(99.90, 7, 'Blusa Moletom', 'M'),
(150.00, 4, 'Relógio', 'Único');

INSERT INTO vendas (cliente_id, produtos_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO funcionario (nome, cargo, cpf, data_nascimento) VALUES
('Carlos Eduardo', 'Gerente', '123456789012', '1980-05-10'),
('Ana Paula', 'Vendedora', '234567890123', '1990-07-22'),
('Marcelo Lima', 'Estoquista', '345678901234', '1985-03-15'),
('Fernanda Souza', 'Caixa', '456789012345', '1992-11-08'),
('João Pedro', 'Supervisor', '567890123456', '1978-09-30'),
('Mariana Dias', 'Vendedora', '678901234567', '1995-12-05'),
('Lucas Oliveira', 'Gerente de Loja', '789012345678', '1983-01-20'),
('Camila Fernandes', 'Auxiliar', '890123456789', '1994-06-17'),
('Bruno Santos', 'Segurança', '901234567890', '1975-04-11'),
('Paula Almeida', 'Vendedora', '012345678901', '1991-08-25');

SELECT * FROM clientes;

SELECT * FROM fornecedores;

select uf from endereco like == RJ;

EXPLAIN
SELECT uf
FROM endereco
WHERE uf = 'RJ';

CREATE INDEX idx_uf ON endereco(uf);

alter table endereco alter column bairro int;

alter table produtos alter column quantidade varchar;

create user joao with password '123';

grant all privileges on database revenda_joaoB to joao;

create user gustavo with password '456';

grant select on funcionario to gustavo;

SELECT c.nome AS cliente, v.vendas_id
FROM cliente c
INNER JOIN vendas v ON c.cliente_id = v.cliente_id;

SELECT c.nome AS cliente, v.vendas_id
FROM cliente c
LEFT JOIN vendas v ON c.cliente_id = v.cliente_id;

SELECT c.nome AS cliente, v.vendas_id
FROM cliente c
RIGHT JOIN vendas v ON c.cliente_id = v.cliente_id;

SELECT v.vendas_id, p.nome AS produto, p.quantidade
FROM vendas v
INNER JOIN produtos p ON v.produtos_id = p.produtos_id;

SELECT v.vendas_id, p.nome AS produto, p.quantidade
FROM vendas v
LEFT JOIN produtos p ON v.produtos_id = p.produtos_id;

SELECT v.vendas_id, p.nome AS produto, p.quantidade
FROM vendas v
RIGHT JOIN produtos p ON v.produtos_id = p.produtos_id;

SELECT f.nome AS fornecedor, e.cidade
FROM fornecedor f
INNER JOIN endereco e ON f.endereco_id = e.endereco_id;

SELECT f.nome AS fornecedor, e.cidade
FROM fornecedor f
LEFT JOIN endereco e ON f.endereco_id = e.endereco_id;

SELECT f.nome AS fornecedor, e.cidade
FROM fornecedor f
RIGHT JOIN endereco e ON f.endereco_id = e.endereco_id;

SELECT c.nome AS cliente, p.nome AS produto, p.preco
FROM cliente c
INNER JOIN vendas v ON c.cliente_id = v.cliente_id
INNER JOIN produtos p ON v.produtos_id = p.produtos_id;

SELECT c.nome AS cliente, p.nome AS produto, p.preco
FROM cliente c
LEFT JOIN vendas v ON c.cliente_id = v.cliente_id
LEFT JOIN produtos p ON v.produtos_id = p.produtos_id;

SELECT c.nome AS cliente, p.nome AS produto, p.preco
FROM cliente c
RIGHT JOIN vendas v ON c.cliente_id = v.cliente_id
RIGHT JOIN produtos p ON v.produtos_id = p.produtos_id;

update all columns with null;







