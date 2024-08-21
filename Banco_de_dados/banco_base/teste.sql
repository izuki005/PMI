create database teste
use teste
CREATE TABLE cadastro (
    id_cadastro INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(50) NOT NULL
);

select id_cadastro, nome, email, senha from cadastro

INSERT INTO cadastro (nome, email, senha) VALUES ('João da Silva', 'joao@email.com', 'senha123');
INSERT INTO cadastro (nome, email, senha) VALUES ('Maria Oliveira', 'maria@email.com', 'senha456');
INSERT INTO cadastro (nome, email, senha) VALUES ('Pedro Santos', 'pedro@email.com', 'senha789');
INSERT INTO cadastro (nome, email, senha) VALUES ('Ana Souza', 'ana@email.com', 'senha321');
INSERT INTO cadastro (nome, email, senha) VALUES ('Carlos Ferreira', 'carlos@email.com', 'senha654');

drop table cadastro