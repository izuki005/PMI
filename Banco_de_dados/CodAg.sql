-- Dropar o banco de dados se ele já existir e criar um novo
DROP DATABASE IF EXISTS CodAg;
CREATE DATABASE CodAg;
USE CodAg
go
-- Tabela de Cadastro de Usuários
CREATE TABLE cadastro (
    id_cadastro INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(50) NOT NULL
);
go
-- Tabela de Fases
CREATE TABLE Fases (
    id_fase INT PRIMARY KEY IDENTITY(1,1),    -- ID auto-incrementado da fase
    nome NVARCHAR(255) NOT NULL,              -- Nome da fase
    descricao NVARCHAR(MAX)                   -- Descrição da fase
);
go
-- Tabela para armazenar o progresso dos usuários nas fases
CREATE TABLE UsuarioFase (
    id_usuario_fase INT PRIMARY KEY IDENTITY(1,1), -- ID auto-incrementado
    id_cadastro INT FOREIGN KEY REFERENCES cadastro(id_cadastro) ON DELETE CASCADE, -- Relacionamento com o usuário
    id_fase INT FOREIGN KEY REFERENCES Fases(id_fase) ON DELETE CASCADE,            -- Relacionamento com a fase
    completada BIT DEFAULT 0,                                     -- Status de conclusão (0 = pendente, 1 = completada)
    data_completada DATETIME                                      -- Data de conclusão (se aplicável)
);
go
CREATE TABLE conteudos (
    id_conteudo INT PRIMARY KEY IDENTITY(1,1),  -- Coluna auto-incrementada
    titulo NVARCHAR(255) NOT NULL,             -- Título do conteúdo
    descricao NVARCHAR(MAX) NOT NULL,          -- Descrição ou texto do conteúdo
    data_criacao DATETIME DEFAULT GETDATE(),   -- Data de criação, preenchida automaticamente
    autor NVARCHAR(255),                       -- Autor opcional do conteúdo
    categoria NVARCHAR(100),                    -- Categoria opcional do conteúdo
);
go
CREATE TRIGGER trg_AposCadastro
ON cadastro
AFTER INSERT
AS
BEGIN
    -- Insere automaticamente as fases do usuário na tabela UsuarioFase
    INSERT INTO UsuarioFase (id_cadastro, id_fase, completada)
    SELECT 
        i.id_cadastro,
        f.id_fase,
        0  -- Definindo 'completada' como 0 (não completada)
    FROM 
        inserted i
    CROSS JOIN 
        Fases f; -- Para cada novo usuário, insere todas as fases
END;
go
-- Inserir o primeiro conteúdo sem imagem
INSERT INTO conteudos (titulo, descricao, autor, categoria)
VALUES
	(
        'Primeiro, o que é programação?', 
        'Programação de forma simples, é dizer ao computador o que fazer por meio de comandos, passos, que ele deve seguir para chegar a um objetivo.

		 A forma de fazer isso, seria o ato de programar.Para conversar com o computador que fala em outra lingua <strong style="color:#E19A2F;">010110</strong>.
		 
		 Podemos usar as linguagens de programação, entre elas temos algumas mais populares como Java Script, Java, Go, Python...', 
        'Equipe_CA', 
        'Conteudo'
    ),
	(
        'Por que Python?', 
        'Essas linguagens vão servir como uma espécie de tradutor para o computador, o nosso tradutor vai ser a linguagem de programação <strong style="color:#E19A2F;">Python</strong>. 
		
		Por meio dessa linguagem que vamos dizer ao computador o que fazer, e como fazer.', 
        'Equipe_CA', 
        'Conteudo'
    ),
	(
        'Por que Python?', 
        '<strong style="color:#E19A2F;">Python</strong>, é uma linguagem de programação que veio a ficar muito popular por sua sintaxe simples, que facilita o aprendizado. 
		
		Ela é uma linguagem bastante usada em áreas como desenvolvimento web, análise de dados e inteligência artificial.', 
        'Equipe_CA', 
        'Conteudo'
    ),
    (
        'Instalação e Ambiente de desenvolvimento', 
        'Se você quiser acompanhar e ir testando enquanto joga, vai precisar instalar o Python.', 
        'Equipe_CA', 
        'Conteudo'
    ),
    (
        'Instalação e Ambiente de desenvolvimento', 
        'Busque por Python no navegador ou por Python.org que ele irá para o site oficial. Passando o mouse por cima da área de downloads ele já vai aparecer a versão mais recente do Python.', 
        'Equipe_CA', 
        'Conteudo'
    ),
    (
        'Instalação e Ambiente de desenvolvimento', 
        'Após a instalação do Python, vamos precisar de uma IDLE, que seria um ambiente de desenvolvimento para desenvolver os nossos programas', 
        'Equipe_CA', 
        'Conteudo'
    ),
    (
        'Instalação e Ambiente de desenvolvimento', 
        'Instalando o VSCode, você pode acompanhar e testar o código enquanto joga ou depois, para criar sua lógica.', 
        'Equipe_CA', 
        'Conteudo'
    ),
	(
        'Após a preparação de nosso ambiente, vamos seguir com os exercícios. Nos ajude a exibir no console a frase inicial de todo programador.', 
        'Descrição padrão', 
        'Equipe_CA', 
        'Conteudo'
    ),
	(
        'Parabéns, você conseguiu! Vamos para a próxima etapa!', 
        'Descrição padrão', 
        'Equipe_CA', 
        'Conteudo'
    ),
	(
        'O que foi esse <strong style="color:#E19A2F;">print("</strong>Hello, Word!<strong style="color:#E19A2F;">")</strong>?', 

        'O comando <strong style="color:#E19A2F;">print( )</strong>(imprimir) dentro da linguagem Python, é uma função para a saída de dados, ele exibe na tela/console algum dado. 
		
		No caso, o que pedimos que ele mostrasse foi o texto <strong style="color:#E19A2F;">“</strong>Hello, Word!<strong style="color:#E19A2F;">”</strong> que está entre aspas. 
		
		Todo texto entre aspas simples <strong style="color:#E19A2F;">‘</strong>texto<strong style="color:#E19A2F;">’</strong> ou aspas duplas <strong style="color:#E19A2F;">“</strong>texto<strong style="color:#E19A2F;">”</strong>, é considerado um tipo de dados conhecido como <strong style="color:#E19A2F;">string</strong>.', 
        'Equipe_CA', 
        'Conteudo'
    ),
	(
     'Além desse do tipo string, existem ainda outros como:', 
     '<strong style="color:#E19A2F;">int</strong> (inteiro): Para números inteiros. Ex: 10, -5. 
	 
	 <strong style="color:#E19A2F;">float</strong> (ponto flutuante): Para números decimais. Ex: 3.14, -0.001. 
	 
	 <strong style="color:#E19A2F;">str</strong> (string): Para textos e cadeias de caracteres. Ex: "hello", "Python". 
	 
	 <strong style="color:#E19A2F;">list</strong> (lista): Para armazenar coleções de itens que podem ser modificados. Ex: [1, 2, 3], ["a", "b", "c"]', 
     'Equipe_CA', 
     'Conteudo'
	),
	 (
     'Mas em que cenário seriam utilizados esses tipos de dados?', 
     'Vamos imaginar um sistema de cadastro, cada pessoa tem seus dados pessoais Ex: 
	 
	 <strong style="color:#E19A2F;">nome</strong> =  “João Pedro” 
	 
	 <strong style="color:#E19A2F;">idade</strong> =  16 
	 
	 <strong style="color:#E19A2F;">altura</strong> =  1,70 
	 
	 Para cada informação, há um tipo de dado como no <strong style="color:#E19A2F;">nome</strong>(string), <strong style="color:#E19A2F;">idade</strong>(inteiro) e <strong style="color:#E19A2F;">altura</strong>(ponto flutuante).', 
     'Equipe_CA', 
     'Conteudo'
	),
	(
		 'Pense sobre o que aprendeu. Qual dos comandos vai exibir a frase Hello, World! no console?', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Meus parabéns, você concluiu a introdução deste mundo!', 
		 'Aprendemos que para cada informação, há um tipo de dados, podendo ser <strong style="color:#E19A2F;">inteiro</strong>, <strong style="color:#E19A2F;">ponto flutuante</strong> ou <strong style="color:#E19A2F;">string</strong> etc. 
		 
		 Aprendemos um comando para exibir valores na tela/console o <strong style="color:#E19A2F;">print()</strong>. 
		 
		 Vimos também como  fazer a instalação dos programas necessários para o uso do <strong style="color:#E19A2F;">Python</strong> e também vimos algumas áreas de uso da linguagem como análise de dados e AI.', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Você já se perguntou como algum eletrodoméstico funciona?', 
		 'Vamos usar de exemplo o <strong style="color:#E19A2F;">microondas</strong>, você coloca alguma comida para esquentar, insere o <strong style="color:#E19A2F;">tempo</strong> que você supoe que a comida ficará quente, liga, e espera o tempo acabar.

		 No final quando sua comida fica quente, ele <strong style="color:#E19A2F;">avisa</strong> fazendo bips para que você retire ela.', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Vamos por partes como aconselha nosso amigo jack', 
		 '<strong style="color:#E19A2F;">Comandos de entrada:</strong> Inserir o tempo no microondas

		 <strong style="color:#E19A2F;">Iniciar contagem descressente:</strong> Apertar o botão de ligar

		 <strong style="color:#E19A2F;">Comandos de saída:</strong> Acabou o tempo, o microondas faz os bips para avisá-lo', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Na maioria dos casos temos sempre um começo, meio e fim.', 
		 'Então há sempre <strong style="color:#E19A2F;">dados de entrada</strong>, em seguida temos o processamento da informação e depois fazemos algo como <strong style="color:#E19A2F;">exibir o valor</strong> de uma conta como em uma calculadora, <strong style="color:#E19A2F;">fazer algum barulho</strong> como os bips de um microondas etc. 
		 
		  Vamos ver isso na <strong style="color:#E19A2F;">prática</strong>', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Começaremos com uma conta, vamosinserir um valores e testar', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Meu parabéns! Você pode definir novos valores a seguir:', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Sua vez, insira novos números e teste por sí mesmo', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Pensando na nossa jornada até aqui, o comando print( )é um comando de Entrada ou Saída de dados?', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Meus parabéns! Você concluiu o segundo oásis', 
		 'Aprendemos que o comando <strong style="color:#E19A2F;">print( )</strong> é um comando de entrada.

		 Vimos também que para <strong style="color:#E19A2F;">manipular dados</strong>, desde uma conta de soma básica, temos sempre um <strong style="color:#E19A2F;">processo de entrada de dados</strong> processamento deles e por último o resultado.

		 Veja como <strong style="color:#E19A2F;">armazenar valores</strong> no próximo oásis.', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Neste oásis vamos entender sobre variáveis e tipos de dados', 
		 'Imagine que você tem várias <strong style="color:#E19A2F;">gavetas rotuladas</strong>. Uma gaveta chamada <strong style="color:#E19A2F;">"idade"</strong> contém o número <strong style="color:#E19A2F;">25</strong>, enquanto outra chamada <strong style="color:#E19A2F;">"nome"</strong> contém o texto <strong style="color:#E19A2F;">"Maria"</strong>. 

		 Sempre que precisar desses valores, basta <strong style="color:#E19A2F;">abrir a gaveta pelo nome</strong>.
		 ', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Vamos colocar em prática, declare uma variável nome e idade', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 	(
		 'O nome variável, é um nome sugestivo a mudança', 
		 'Esse nome <strong style="color:#E19A2F;">não é atoa</strong>, as variáveis podem alterar seus valores ao longo de um programa

		  Ex: 
		  nome = <strong style="color:#E19A2F;">“Bernardo”</strong>
		  nome = <strong style="color:#E19A2F;">“João”</strong>

		  A variável <strong style="color:#E19A2F;">nome</strong> recebeu <strong style="color:#E19A2F;">por último</strong> o nome <strong style="color:#E19A2F;">“João”</strong>, então esse é <strong style="color:#E19A2F;">seu valor atual.</strong>', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Vamos colocar em prática, altere o valor de nome no segundo print( )', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Existem algumas regras para se declarar uma variável, temos de seguir as boas práticas.', 
		 'Os nomes de <strong style="color:#E19A2F;">variáveis</strong> em <strong style="color:#E19A2F;">Python</strong> seguem a convenção <strong style="color:#E19A2F;">snake_case:</strong todas as letras em minúsculo, sem acentos e separadas por _ (underline) entre palavras.

		 <strong style="color:#E19A2F;">Evite nomes muitos simples</strong>, com apenas uma letra, deixe claro o valor que você pretende armazenar. 

		 <strong style="color:#E19A2F;">Exemplo errado:</strong> s = 1.400
		 <strong style="color:#E19A2F;">Exemplo correto:</strong> salario_minimo = 1.400', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Variáveis podem receber resultados como a soma de dois valores', 
		'<strong style="color:#E19A2F;">valor1</strong> = 10
		 <strong style="color:#E19A2F;">valor2</strong> = 16
		 <strong style="color:#E19A2F;">resultado</strong> = valor1 + valor2

		 Dessa forma <strong style="color:#E19A2F;">armazenamos resultados</strong> de contas matemáticas, a variável <strong style="color:#E19A2F;">resultado</strong> agora tem a soma de <strong style="color:#E19A2F;">valor1 e valor2</strong>, ou seja, o valor da variável é <strong style="color:#E19A2F;">26</strong>.
		 Podemos <strong style="color:#E19A2F;">aumentar</strong> ainda mais o valor <strong style="color:#E19A2F;">Ex: resultado</strong> = resultado + 4
		 Agora o valor da <strong style="color:#E19A2F;">variável resultado</strong> está recebendo a soma de <strong style="color:#E19A2F;">26 + 4</strong>, que é <strong style="color:#E19A2F;">30</strong>', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Meus parabéns! Você concluiu mais um oásis!', 
		 'Aprendemos sobre <strong style="color:#E19A2F;">variáveis</strong> e seus diferentes <strong style="color:#E19A2F;">tipos de dados</strong>.

		 Apredemos a <strong style="color:#E19A2F;">guardar novos valores</strong> e de que é possível guardar resultados de contas matemáticas assim como a exibilos em uma frase.', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Que decisão eu devo tomar agora? Vou pela esquerda ou direita?', 
		 'Programas utilizam valores <strong style="color:#E19A2F;">booleanos</strong> para decidir se certas linhas de código devem ser <strong style="color:#E19A2F;">executadas</strong> ou <strong style="color:#E19A2F;">ignoradas</strong>.', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Usamos uma estrutura condicional if para criar um código que reage a diversas situações,  essa estrutura se identificada pela palavra-chave if.', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 	(
		 'A instrução if executa o código somente quando a condição é avaliada como verdadeira.', 
		 'É como afirmar: se algo for verdadeiro, então execute esta ação.<br>
		 Para tornar a condição verdadeira, podemos usar diretamente o valor booleano True e exibir "Hello World" no console.', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Vamos lá, torne a condição verdadeira e exiba Hello World no console.', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'E se quisermos que o código seja ignorado? Nesse caso, a condição precisa ser avaliada como falsa.', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
		 'Qual a palavra chave para uma declaração if?', 
		 'Descrição padrão', 
		 'Equipe_CA', 
		 'Conteudo'
	 ),
	 (
    'O que esse comando exibe no console?<br>if&nbsp;&nbsp;True:<br>&nbsp;&nbsp;&nbsp;&nbsp;print("Vou ser impresso")', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
	),
	(
    'O que esse comando exibe no console?<br>if&nbsp;&nbsp;False:<br>&nbsp;&nbsp;&nbsp;&nbsp;print(“Vou ser impresso”)', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
	),
	(
    'O que decide se um bloco de código vai ser executado?', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
	),
	(
    'Bom trabalho! Você concluiu o quarto oásis!', 
    'Aprendemos que um <strong style="color:#E19A2F;">if&nbsp;&nbsp;True:</strong> executa seu bloco de código, que um <strong style="color:#E19A2F;">if&nbsp;&nbsp;False:</strong> ignora o bloco de código, pois um define a condição como <strong style="color:#E19A2F;">verdadeira</strong> e outro como <strong style="color:#E19A2F;">falsa</strong>.<br><br>Vimos também que a palavra chave para criar uma condição é if.<br><br>Continue avançando e fazendo novas descobertas!', 
    'Equipe_CA', 
    'Conteudo'
	),
	(
    'O que são Loops?', 
    'Loops (ou laços) são estruturas que repetem um bloco de código enquanto uma condição for verdadeira. Eles são muito úteis para automatizar tarefas repetitivas.', 
    'Equipe_CA', 
    'Conteudo'
	),
	(
    'Por que não repetir tudo na mão?', 
    'Repetir o mesmo código várias vezes pode até funcionar, mas dá muito trabalho e fica complicado quando queremos fazer algo maior. É aí que os loops ajudam!', 
    'Equipe_CA', 
    'Conteudo'
	),
	(
    'Vamos dizer que eu quero repetir esse print 5 vezes.', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
),
(
    'Escrever algumas linhas tudo bem, mas se forem 1000 linhas de código?', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
),
(
    'Com um loop, basta escrever uma vez:', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
),
(
    'O loop irá imprimir "Olá, mundo!" 1000 vezes com esse único comando.', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
),
(
    'O que é o loop for de forma bem simples?', 
    'Imagine que você precisa repetir uma tarefa várias vezes, como dizer "Oi!" para 10 pessoas.<br><br>Em vez de falar "Oi!" 10 vezes manualmente, você pode usar um loop for para fazer isso automaticamente.', 
    'Equipe_CA', 
    'Conteudo'
),
(
    'Como funciona?', 
    'O loop for segue três passos principais:<br><br>1. Escolhe uma lista de coisas para repetir (números, nomes, etc.).<br><br>2. Faz algo para cada item dessa lista.<br><br>3. Para quando terminar a lista.', 
    'Equipe_CA', 
    'Conteudo'
),
(
    'Se você quiser imprimir os números de 1 a 5, o loop for faz assim:', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
),
(
    'Saída:', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
),
(
    'Traduzindo:', 
    'range(1, 6) cria os números de 1 até 5.<br><br>O for vai "passear" por cada número, um de cada vez.<br><br>O print mostra o número atual.', 
    'Equipe_CA', 
    'Conteudo'
),
(
    'Para criar um loop for, começamos com a palavra "for", escolhemos um nome para uma variável (como i), colocamos "in" logo depois e, por último, usamos "range()" para dizer quantas vezes o loop vai rodar.', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
),
(
    'Determine quantas vezes o loop irá repetir o print exemplo:<br>range(2), range(3) etc', 
    'Descrição padrão', 
    'Equipe_CA', 
    'Conteudo'
);

INSERT INTO conteudos (titulo, descricao, autor, categoria)
VALUES
(
    'Meus parabéns! Você finalizou o último oásis<br>Continue nos próximos mundos e aprenda mais!', 
    'Você descobriu as bases essenciais para se aventurar na programação: comandos de entrada e saída, que permitem a interação com o usuário; variáveis e tipos de dados, que armazenam e organizam informações; condições, que ajudam a tomar decisões; e, finalmente, os loops, que tornam possível repetir tarefas de forma inteligente.<br><br>Sua jornada está apenas começando. Continue firme e descubra tudo o que está por vir. O próximo mundo aguarda você!', 
    'Equipe_CA', 
    'Conteudo'
);
go
-- Inserir dados na tabela Fases
INSERT INTO Fases (nome, descricao) 
VALUES 
('Oasis 1: Introdução', 'Introdução ao sistema e visão geral do conteúdo.'),
('Oasis 2: Comandos de Entrada e Saída', 'Uso de comandos para entrada e saída de dados.'),
('Oasis 3: Variáveis e Tipos de Dados', 'Conceitos básicos sobre variáveis e tipos de dados.'),
('Oasis 4: Loops', 'Estruturas de repetição para execução de tarefas iterativas.'),
('Oasis 5: Funções', 'Definição e uso de funções para organizar o código.');
go
select * from Fases
go
select * from conteudos
drop table conteudos
drop table Fases
SELECT 
    UF.id_usuario_fase,
    UF.id_cadastro,
    F.nome AS nome_fase,
    UF.completada,
    UF.data_completada
FROM 
    UsuarioFase UF
JOIN 
    Fases F ON UF.id_fase = F.id_fase
WHERE 
    UF.id_cadastro = 1;