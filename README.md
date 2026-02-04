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

