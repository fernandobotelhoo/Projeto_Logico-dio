CREATE DATABASE Ecommerce;
USE Ecommerce;

-- criando tabela Pessoa
CREATE TABLE Pessoa (
    idPessoa INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    DataNascimento DATE,
    Endereco VARCHAR(80),
    Cliente_PF_idCliente_PF INT,
    Cliente_PJ_idCliente_PJ INT,
    UNIQUE (Cliente_PF_idCliente_PF, Cliente_PJ_idCliente_PJ)
);

-- criando tabela Cliente PF
CREATE TABLE Cliente_PF (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    Identificacao VARCHAR(45),
    Pagamento_Cliente_idCliente INT,
    Pagamento_Pedido_idPedido INT
);

-- criando tabela Cliente PJ
CREATE TABLE Cliente_PJ (
    idCliente_PJ INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(45) NOT NULL,
    CNPJ VARCHAR(45),
    Pagamento_Cliente_idCliente INT,
    Pagamento_Pedido_idPedido INT
);

-- criando tabela Pagamento
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    Cliente_idCliente INT,
    Pedido_idPedido INT,
    Pix VARCHAR(45),
    Cartao VARCHAR(45),
    Boleto VARCHAR(45),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente_PF(idCliente),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

-- crianado tabela Pedido
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    StatusPedido VARCHAR(45) NOT NULL,
    Descricao VARCHAR(45),
    Cliente_idCliente INT,
    Entrega_idCodigoRastreio INT,
    Frete FLOAT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente_PF(idCliente),
    FOREIGN KEY (Entrega_idCodigoRastreio) REFERENCES Entrega(idCodigoRastreio)
);

-- criando tabela Entrega
CREATE TABLE Entrega (
    idCodigoRastreio INT AUTO_INCREMENT PRIMARY KEY,
    StatusEntrega VARCHAR(45)
);

-- criando tabela Produto
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    Categoria VARCHAR(45),
    Descricao VARCHAR(45),
    Valor FLOAT
);

-- criando tabela Produto por Pedido
CREATE TABLE ProdutoPorPedido (
    Produto_idProduto INT,
    Pedido_idPedido INT,
    Quantidade INT,
    PRIMARY KEY (Produto_idProduto, Pedido_idPedido),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

-- criando tabela Fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(45),
    CNPJ VARCHAR(45),
    Telefone VARCHAR(45)
);

-- criando tabela Disponibiliza
CREATE TABLE Disponibiliza (
    Fornecedor_idFornecedor INT,
    Produto_idProduto INT,
    PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- criando tabela Estoque
CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Local VARCHAR(45)
);

-- criando tabela Verifica
CREATE TABLE Verifica (
    Produto_idProduto INT,
    Estoque_idEstoque INT,
    Quantidade INT,
    PRIMARY KEY (Produto_idProduto, Estoque_idEstoque),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque)
);

-- Tabela Terceiro Vendedor
CREATE TABLE TerceiroVendedor (
    idTerceiroVendedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(45),
    Local VARCHAR(45),
    Telefone VARCHAR(45)
);

-- Tabela Produtos por Vendedor (Terceiro)
CREATE TABLE ProdutosPorVendedor (
    Produto_idProduto INT,
    TerceiroVendedor_idTerceiroVendedor INT,
    Quantidade INT,
    PRIMARY KEY (Produto_idProduto, TerceiroVendedor_idTerceiroVendedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (TerceiroVendedor_idTerceiroVendedor) REFERENCES TerceiroVendedor(idTerceiroVendedor)
);

-- Inserção de dados de exemplo
INSERT INTO Pessoa (Nome, DataNascimento, Endereco) 
VALUES ('João Silva', '1990-05-15', 'Rua A, 123');

INSERT INTO Cliente_PF (Nome, Identificacao) 
VALUES ('Maria Oliveira', '123456789');

INSERT INTO Produto (Categoria, Descricao, Valor) 
VALUES ('Eletrônicos', 'Iphone 16 Pro Max', 9.299,00);

INSERT INTO Fornecedor (RazaoSocial, CNPJ, Telefone) 
VALUES ('Tech Distribuidora', '12345678000199', '51987654321');

INSERT INTO Estoque (Local) 
VALUES ('Armazém Central');

-- Queries mais complexas

-- 1. Quantos pedidos foram feitos por cada cliente
SELECT Cliente_idCliente, COUNT(*) AS TotalPedidos
FROM Pedido
GROUP BY Cliente_idCliente;

-- 2. Algum vendedor também é fornecedor?
SELECT TV.idTerceiroVendedor, F.idFornecedor
FROM TerceiroVendedor TV
INNER JOIN Fornecedor F ON TV.RazaoSocial = F.RazaoSocial;

-- 3. Relação de produtos, fornecedores e estoques
SELECT P.Descricao AS Produto, F.RazaoSocial AS Fornecedor, E.Local AS Estoque
FROM Produto P
INNER JOIN Disponibiliza D ON P.idProduto = D.Produto_idProduto
INNER JOIN Fornecedor F ON D.Fornecedor_idFornecedor = F.idFornecedor
INNER JOIN Verifica V ON P.idProduto = V.Produto_idProduto
INNER JOIN Estoque E ON V.Estoque_idEstoque = E.idEstoque;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos
SELECT F.RazaoSocial AS Fornecedor, P.Descricao AS Produto
FROM Fornecedor F
INNER JOIN Disponibiliza D ON F.idFornecedor = D.Fornecedor_idFornecedor
INNER JOIN Produto P ON D.Produto_idProduto = P.idProduto;

-- 5. Produtos mais caros com valor acima da média
SELECT * FROM Produto
WHERE Valor > (SELECT AVG(Valor) FROM Produto)
ORDER BY Valor DESC;
