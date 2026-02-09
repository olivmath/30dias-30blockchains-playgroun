# ERC 20 - Arbitrum



# criar o projeto usando Foundry 2026

lib @ bibliotecas que o foundry baixar + a gente vai instalar
scripts @ scripts para fazer deploy dos contratos
src @ os nossos contratos
tests @ testes dos nossos contratos

# contrato de Token ERC20

## READ 

- name(): returns(string): LUZ Community
- symbol(): returns(string): LUZ
- decimals(): returns(uint8): 2 | 100 == 1,00, 1000 == 10,00
- totalSupply(): returns(uint256): 1.000.000 mi
- balanceOf(address): buscar no storage o saldo do `address`

@ quantos tokens seus alguém pode gastar
- allowance(owner: address, spender: address) returns(amount: uint256)
  * owner: address | quem tem os tokens
  * spender: address | quem recebeu approve para gastar tokens do owner
  * returns(amount): uint256 | quantos tokens o spender pode gastar do owner


## WRITE

@ transfere tokens do dono para alguém (somente o dono pode chamar)
- tranfer(to: address, amount: uint256): 
  * to: address | quem vai receber o token
  * amount: uint256 | a quantidade de tokens

@ alguém gasta o dinheiro de alguém
- transferFrom(from: address, to: address, amount: uint256):
  * from: address | quem está enviando o token
  * to: address | quem vai receber o token
  * amount: uint256 | a quantidade de tokens

@ vc aprova que alguém gaste seus tokens (somente o dono pode chamar)
- approve(spender: address, amount: uint256):
  * spender: address | quem pode gastar seus tokens?
  * amount: uint256 | quantos tokens ele pode gastar?


## Fluxo do dado (Approve -> TransferFrom)


Marcos: address | 10.00 LUZ
0xEduardo: address | 0 LUZ
1xEduardo: address | 0 LUZ

Marcos::>>ERC20::approve(0xEduardo, 1.00LUZ);

0xEduardo::>>ERC20::transferFrom(Marcos, 1xEduardo, 0.50LUZ);

::>>ERC20::allowance(Marcos, 0xEduardo)
<<:: 0.50 LUZ

::>>ERC20::balanceOf(Marcos)
<<:: 9.50 LUZ

Marcos::>>ERC20::approve(0xEduardo, 0LUZ); [SET]

0xEduardo::>>ERC20::transferFrom(Marcos, 0xEduardo, 0.50LUZ);
<<:: ERRO <INSUFFICIENT_ALLOWANCE>



1. ENTENDER OS REQ
2. ESCREVER O CONTRATO (USANDO BOAS PRÁTICAS)
3. ESCREVER TESTES
4.a DEPLOY TESTNET (VERIFICAÇÃO EXPLORER)
4.b TESTE DE E2E
4.c ANÁLISE SEGURANÇA (Slither, AI)
5. AUDITORIA
6. CORREÇÃO DAS VULNERABILIDADE
7. AUDITORIA
8. DEPLOY MAINNET
9. MONITORAMENTO
10. CONTRA-MEDIDA


# AMANHA

## corrigir contrato

- colocar uma funcao de mint e burn;


@ cria tokens para o usuário passado como parametro (apenas o dono do contrato)
- mint(owner: address, amount: uint256):
  * owner: address | quem vai receber os tokens?
  * amount: uint256 | quantos tokens ele vai receber?

@ queimar tokens do usuário passado como parametro
- burn(owner: address, amount: uint256):
  * owner: address | quem vai perder os tokens?
  * amount: uint256 | quantos tokens ele vai perder?


# Into

Pra quem não me conhece,
meu nome é Lucas Oliveira.
Sou casado, pai de duas meninas
e professor de matemática.
Trabalho com tecnologia há muitos anos
e já dei aula desde o
Fundamental 1 até faculdade.
Mas o que sempre me encantou
foram os pequenos.
Porque eles têm algo
que os adulto acabando perdendo:
👉 criatividade
👉 curiosidade
👉 coragem de tentar
Foi dando aulas de robótica que eu vi
que a educação pode ser:
✔ criativa
✔ divertida
✔ prática
✔ transformadora
A maioria das matérias
ensina sobre o que já aconteceu.
Mas tecnologia,
programação e robótica
ensinam a construir
o que ainda vai existir.
Mas como preparar crianças
para um futuro que
nem a gente sabe como vai ser?
A resposta não está só na tecnologia.
mas na mentalidade.
Mentalidade de construtor.
Mentalidade de resolver problemas.
Mentalidade de criar soluções.
E isso pode ser desenvolvido
desde cedo com:
raciocínio lógico
pensamento computacional
programação
IA
Talvez você esteja pensando:
"Mas eu não sou da tecnologia."
E está tudo bem.
Porque isso é novo para todo mundo.
Não importa se você é:
pedagogo
professor de português
ciências
artes
história
Todos nós estamos aprendendo.
A diferença é:
- aprender sozinho
- ou aprender com um caminho suave
Um caminho simples.
Prático.
Feito de professor pra professor
Se você quer levar STEAM
para sua sala de aula
sem precisar virar programador
Vem aprender com agente

======================================


Agora vai me dizer
Você nunca teve que dar uma
aula que não era a sua
especialidade?

Eu sei que sim.

Porque TODO professor já
passou por isso.

A realidade da escola faz
a gente, muitas vezes,
se virar nos 30.

Agora me diz…

Quantas vezes você já
ouviu na escola:

“Temos que trabalhar
STEAM”

“Precisamos falar de IA
com os alunos”

“Tem que aplicar
educação digital”

Mas ninguém te mostra
como fazer isso na
prática.

E aí bate aquele receio
de perguntar.

Porque parece que todo
mundo já sabe…

menos você.

Mas deixa eu te falar uma
coisa:

Você não foi preparado
pra isso.

Na sua graduação:

Não tinha STEAM.

Não tinha programação.

Não tinha IA na educação.

Não tinha essa cobrança.

Então está tudo bem não
saber.

O problema nunca foi não
saber.

O problema é continuar se
virando sozinho.

Tentando aprender tudo no
improviso.

Sem apoio.

Sem método.

Sem alguém pra te mostrar
o caminho.

E enquanto isso…

Os alunos mudam.

A escola cobra.

E a tecnologia avança
cada vez mais rápido.

E não — você não precisa
virar programador.

Você só precisa aprender
do jeito certo.

Do zero.

Sem julgamento.

Sem pressão.

Porque educação não
precisa de heróis
solitários.

Precisa de professores
que tenham apoio.

Que aprendam juntos.

Que tenham um caminho
claro.

E é exatamente pra isso
que a gente está aqui.

Agora me responde com
sinceridade:

Você está pronto pra
parar de se virar
sozinho…

e começar a ensinar com
segurança?
