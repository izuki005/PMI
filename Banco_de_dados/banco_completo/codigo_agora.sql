drop database codigo_agora
create database codigo_agora
go
use codigo_agora

create table mundos(
id_mundo int primary key not null,
nome varchar(10) not null,
descricao_mundo varchar(50)
);
go

create table fases(
id_fase int primary key not null,
nome_fase varchar(30),
descricao_fase varchar(50),
id_mundo int,
FOREIGN KEY (id_mundo) REFERENCES mundos(id_mundo),
);
go

create table checkpoints(
id_checkpoint int primary key,
conquista varchar(50),
id_fase int,
FOREIGN KEY (id_fase) REFERENCES fases(id_fase),
);
go

create table pontuacao (
id_pontuacao int primary key,
pontos_fixos int,
ponto_gerados int,
);
go

create table acessos(
id_acesso int primary key,
tipos_acessos varchar(100)
);
go

-- Cria��o da tabela cadastro_user
CREATE TABLE cadastro_user (
    id_user int primary key,
    nome varchar(50),
    email varchar(50),
    senha varchar(50),
    tipo_usuario varchar(1) CHECK (tipo_usuario IN ('u', 'a')),
    id_pontuacao int,
    id_permissao int,
    id_checkpoint int,
    FOREIGN KEY (id_pontuacao) REFERENCES pontuacao(id_pontuacao),
    FOREIGN KEY (id_checkpoint) REFERENCES checkpoints(id_checkpoint)
);

create table permissao(
id_user int,
id_acesso int,
);
go
ALTER TABLE permissao
ADD CONSTRAINT fk_permissao_cadastro_user FOREIGN KEY (id_user) REFERENCES cadastro_user(id_user);

-- Inserts para a tabela mundos
INSERT INTO mundos (id_mundo, nome, descricao_mundo) VALUES
(1, 'Deserto', 'descricao_deserto'),
(2, 'Gelo', 'descricao_gelo'),
(3, 'Floresta','descricao_floresta'),
(4, 'Vulcao','descricao_vulcao');
select * from mundos

-- Inserts para a tabela fases
INSERT INTO fases (id_fase, nome_fase, descricao_fase, id_mundo) VALUES
(1, 'COMANDOS DE ENTRADA E SA�DA', 'Aprendendo comandos de entrada e saida', 1),
(2, 'VARI�VEIS, CONTANTES E TIPOS', 'Aprendendo sobre vari�veis, contantes e tipos', 1),
(3, 'ESCOPO DE PROGRAMA', 'Aprendendo sobre escopo de Programa', 1),
(4,'COMANDOS DE SELE��O','Aprendendo sobre comando de sele��o',1),
(5,'COMANDOS DE REPETI��O','Aprendendo sobre comandos de repeti��o',1);
select * from fases

-- Inserts para a tabela checkpoints
INSERT INTO checkpoints (id_checkpoint, conquista, id_fase) VALUES
(1, 'N�made dos Dados', 1),
(2, 'O�sis das Vari�veis', 2),
(3, 'Explorador dos Ventos', 3),
(4, 'Mestre dos Miragens', 4),
(5, 'L�der das Dunas', 5);
select * from checkpoints

-- Inserts para a tabela pontuacao
INSERT INTO pontuacao (id_pontuacao, pontos_fixos, ponto_gerados) VALUES
(1, 100, 50),
(2, 200, 75),
(3, 300, 90);
select * from pontuacao

-- Inserts para a tabela cadastro_user
-- Note que os inserts para esta tabela dependem de dados preexistentes nas outras tabelas referenciadas por chaves estrangeiras.
INSERT INTO cadastro_user (id_user, nome, email, senha,tipo_usuario, id_pontuacao, id_permissao, id_checkpoint) VALUES
(1, 'Matheus', 'usuario1@example.com', 'senha123','a', 1, 1, 1),
(2, 'Kawan', 'usuario2@example.com', 'senha456','a', 2, 1, 2),
(3, 'Arthur', 'usuario3@example.com', 'senha789','u', 3, 2, 3);
select * from cadastro_user

-- Inserts para a tabela acessos
INSERT INTO acessos (id_acesso, tipos_acessos) VALUES
(1, 'Acesso a P�gina de Login e Cadastro'),
(2, 'Acesso �s fases do mundo do Deserto'),
(3, 'Acesso �s fases do mundo do Gelo'),
(4, 'Acesso �s fases do mundo da Floresta'),
(5, 'Acesso �s fases do mundo do Vulc�o'),
(6, 'Acesso ao iventario do jogador'),
(7, 'Acesso ao sistema de loja'),
(8, 'Acesso ao sistema de crafting'), 
(9, 'Acesso ao sistema de miss�es'),
(10, 'Acesso �s estat�sticas do jogador'),
(11, 'Acesso ao perfil do jogador'),
(12, 'Acesso �s configura��es de conta'),
(13, 'Acesso �s configura��es do jogo'),
(14, 'Acesso ao chat global'),
(15, 'Acesso �s mensagens privadas'),
(16, 'Acesso � lista de amigos'),
(17, 'Acesso ao sistema de cl�s'),
(18, 'Acesso �s estat�sticas globais do jogo'),
(19, 'Acesso ao painel de controle do jogo'),
(20, 'Acesso �s configura��es de administrador'),
(21, 'Acesso � p�gina de relat�rios'),
(22, 'Acesso � p�gina de an�lise de dados'),
(23, 'Acesso ao sistema de banimento'),
(24, 'Acesso ao sistema de recompensas'),
(25, 'Acesso ao sistema de monitoramento de servidores');
select * from acessos

-- Inserts para a tabela permissao
INSERT INTO permissao (id_user, id_acesso) VALUES
(1, 19), -- Admin Matheus com acesso ao painel de controle do jogo
(1, 21), -- Admin Matheus com acesso � p�gina de relat�rios
(2, 19), -- Admin Kawan com acesso ao painel de controle do jogo
(2, 21), -- Admin Kawan com acesso � p�gina de relat�rios
(3, 2), -- Usu�rio Arthur com acesso �s fases do mundo do Deserto
(3, 3), -- Usu�rio Arthur com acesso �s fases do mundo do Gelo
(3, 4), -- Usu�rio Arthur com acesso �s fases do mundo da Floresta
(3, 5), -- Usu�rio Arthur com acesso �s fases do mundo do Vulc�o
(3, 6), -- Usu�rio Arthur com acesso ao invent�rio do jogador
(3, 7), -- Usu�rio Arthur com acesso ao sistema de loja
(3, 8), -- Usu�rio Arthur com acesso ao sistema de crafting
(3, 9), -- Usu�rio Arthur com acesso ao sistema de miss�es
(3, 10), -- Usu�rio Arthur com acesso �s estat�sticas do jogador
(3, 11), -- Usu�rio Arthur com acesso ao perfil do jogador
(3, 12), -- Usu�rio Arthur com acesso �s configura��es de conta
(3, 13), -- Usu�rio Arthur com acesso �s configura��es do jogo
(3, 14), -- Usu�rio Arthur com acesso ao chat global
(3, 15), -- Usu�rio Arthur com acesso �s mensagens privadas
(3, 16), -- Usu�rio Arthur com acesso � lista de amigos
(3, 17), -- Usu�rio Arthur com acesso ao sistema de cl�s
(3, 18); -- Usu�rio Arthur com acesso �s estat�sticas globais do jogo
select * from permissao