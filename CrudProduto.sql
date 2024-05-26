USE MASTER
--DROP DATABASE CrudProduto
CREATE DATABASE	CrudProduto
GO
USE CrudProduto

CREATE TABLE produto(
codigo           INT            NOT NULL,
nome             VARCHAR(50)    NOT NULL,
valorUnitario    DECIMAL(7,2)   NOT NULL,
quantidade       INT            NOT NULL,
PRIMARY KEY (codigo)
)

INSERT INTO produto (codigo, nome, valorUnitario, quantidade)
VALUES (1, 'Camiseta', 29.99, 50);

INSERT INTO produto (codigo, nome, valorUnitario, quantidade)
VALUES (2, 'Calça Jeans', 59.99, 30);

INSERT INTO produto (codigo, nome, valorUnitario, quantidade)
VALUES (3, 'Tênis', 79.99, 20);

INSERT INTO produto (codigo, nome, valorUnitario, quantidade)
VALUES (4, 'Bolsa', 39.99, 15);

CREATE PROCEDURE consultarProduto
    @codigo INT
AS
BEGIN
    SELECT codigo, nome, valorUnitario, quantidade
    FROM produto
    WHERE codigo = @codigo;
END

EXEC consultarProduto @codigo = 1

CREATE FUNCTION listarProdutos()
RETURNS TABLE
AS
RETURN
(
    SELECT codigo, nome, valorUnitario, quantidade
    FROM produto
)

SELECT * FROM listarProdutos()

CREATE PROCEDURE iudProduto
    @acao VARCHAR(1),
    @codigo INT,
    @nome VARCHAR(100),
    @valorUnitario FLOAT,
    @quantidade INT,
    @saida VARCHAR(100) OUTPUT
AS
BEGIN
    IF @acao = 'I' -- Inserir
    BEGIN
        INSERT INTO produto (codigo, nome, valorUnitario, quantidade)
        VALUES (@codigo, @nome, @valorUnitario, @quantidade);
    END;
    ELSE IF @acao = 'U' -- Atualizar
    BEGIN
        UPDATE produto
        SET nome = @nome,
            valorUnitario = @valorUnitario,
            quantidade = @quantidade
        WHERE codigo = @codigo;
    END;
    ELSE IF @acao = 'D' -- Excluir
    BEGIN
        DELETE FROM produto
        WHERE codigo = @codigo;
    END;

    SET @saida = 'Operação realizada com sucesso.';
END


CREATE FUNCTION fn_produtosEstoque
(
    @quantidade INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT codigo, nome, quantidade
    FROM produto
    WHERE quantidade < @quantidade
)


CREATE FUNCTION listarProdutosEstoque
(
    @valor INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT codigo, nome, quantidade
    FROM dbo.fn_produtosEstoque(@valor)
)

SELECT * FROM listarProdutosEstoque(20)

CREATE FUNCTION fn_quantidade
(
    @QtdProdutos INT
)
RETURNS INT
AS
BEGIN
    DECLARE @qtdAbaixo INT;
    
    SELECT @qtdAbaixo = COUNT(*)
    FROM produto
    WHERE quantidade < @QtdProdutos;
    
    RETURN @qtdAbaixo;
END
 SELECT * FROM produto
 SELECT codigo, nome, valorUnitario, quantidade
    FROM produto
    WHERE codigo = 1
