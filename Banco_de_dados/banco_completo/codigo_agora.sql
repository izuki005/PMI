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

-- Criação da tabela cadastro_user
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
(1, 'COMANDOS DE ENTRADA E SAÍDA', 'Aprendendo comandos de entrada e saida', 1),
(2, 'VARIÁVEIS, CONTANTES E TIPOS', 'Aprendendo sobre variáveis, contantes e tipos', 1),
(3, 'ESCOPO DE PROGRAMA', 'Aprendendo sobre escopo de Programa', 1),
(4,'COMANDOS DE SELEÇÃO','Aprendendo sobre comando de seleção',1),
(5,'COMANDOS DE REPETIÇÃO','Aprendendo sobre comandos de repetição',1);
select * from fases

-- Inserts para a tabela checkpoints
INSERT INTO checkpoints (id_checkpoint, conquista, id_fase) VALUES
(1, 'Nômade dos Dados', 1),
(2, 'Oásis das Variáveis', 2),
(3, 'Explorador dos Ventos', 3),
(4, 'Mestre dos Miragens', 4),
(5, 'Líder das Dunas', 5);
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
(1, 'Acesso a Página de Login e Cadastro'),
(2, 'Acesso às fases do mundo do Deserto'),
(3, 'Acesso às fases do mundo do Gelo'),
(4, 'Acesso às fases do mundo da Floresta'),
(5, 'Acesso às fases do mundo do Vulcão'),
(6, 'Acesso ao iventario do jogador'),
(7, 'Acesso ao sistema de loja'),
(8, 'Acesso ao sistema de crafting'), 
(9, 'Acesso ao sistema de missões'),
(10, 'Acesso às estatísticas do jogador'),
(11, 'Acesso ao perfil do jogador'),
(12, 'Acesso às configurações de conta'),
(13, 'Acesso às configurações do jogo'),
(14, 'Acesso ao chat global'),
(15, 'Acesso às mensagens privadas'),
(16, 'Acesso à lista de amigos'),
(17, 'Acesso ao sistema de clãs'),
(18, 'Acesso às estatísticas globais do jogo'),
(19, 'Acesso ao painel de controle do jogo'),
(20, 'Acesso às configurações de administrador'),
(21, 'Acesso à página de relatórios'),
(22, 'Acesso à página de análise de dados'),
(23, 'Acesso ao sistema de banimento'),
(24, 'Acesso ao sistema de recompensas'),
(25, 'Acesso ao sistema de monitoramento de servidores');
select * from acessos

-- Inserts para a tabela permissao
INSERT INTO permissao (id_user, id_acesso) VALUES
(1, 19), -- Admin Matheus com acesso ao painel de controle do jogo
(1, 21), -- Admin Matheus com acesso à página de relatórios
(2, 19), -- Admin Kawan com acesso ao painel de controle do jogo
(2, 21), -- Admin Kawan com acesso à página de relatórios
(3, 2), -- Usuário Arthur com acesso às fases do mundo do Deserto
(3, 3), -- Usuário Arthur com acesso às fases do mundo do Gelo
(3, 4), -- Usuário Arthur com acesso às fases do mundo da Floresta
(3, 5), -- Usuário Arthur com acesso às fases do mundo do Vulcão
(3, 6), -- Usuário Arthur com acesso ao inventário do jogador
(3, 7), -- Usuário Arthur com acesso ao sistema de loja
(3, 8), -- Usuário Arthur com acesso ao sistema de crafting
(3, 9), -- Usuário Arthur com acesso ao sistema de missões
(3, 10), -- Usuário Arthur com acesso às estatísticas do jogador
(3, 11), -- Usuário Arthur com acesso ao perfil do jogador
(3, 12), -- Usuário Arthur com acesso às configurações de conta
(3, 13), -- Usuário Arthur com acesso às configurações do jogo
(3, 14), -- Usuário Arthur com acesso ao chat global
(3, 15), -- Usuário Arthur com acesso às mensagens privadas
(3, 16), -- Usuário Arthur com acesso à lista de amigos
(3, 17), -- Usuário Arthur com acesso ao sistema de clãs
(3, 18); -- Usuário Arthur com acesso às estatísticas globais do jogo
select * from permissao