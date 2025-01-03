# README

# Ruby API
Projeto para criação de uma API com Ruby on Rails, com tratamento de dados desnormalizado transformando-os
em uma saída de dados json normalizado.

# Entrada de dados
Os dados estão padronizados por tamanho de seus valores, respeitando a seguinte tabela:

| campo            | tamanho | tipoSinal           |
|------------------|---------|---------------------|
| id usuario       | 10      | numerico            |
| nome             | 45      | texto               |
| id pedido        | 10      | numerico            |
| id produto       | 10      | numerico            |
| valor do produto | 12      | decimal             |
| data de compra   | 8       | numerico (yyyymmdd) |

# Saída de dados
A saída de dados é disponibilizada via api REST considerando a estrutura base de payload
de response. Gera uma consulta geral de pedidos e, também com os seguintes filtros:

1. id do pedido;
2. intervalo de data de compra (data início e data fim);
3. pedidos de um usuário.


# Conceitos
* Testes
* Banco de dados
* Infrestrutura
* SOLID
* Automação (Ex: Build, Coverage)
* Desenho da API
* Git

### Tecnologias usadas
```
Ruby 3.3.5
Rails - 8.0.0
O banco de dados utilizado para persistência dos dados foi SQLite.
```
### Futuras implementações:
Frontend
Infraestrutura no código (docker)

### Para rodar o projeto:
```
$ git clone https://github.com/laisnsc/normalizer_api.git

$ bundle install

$ rails db:create db:migrate
```

### Documentação dos endpoints (Postman)
```
https://documenter.getpostman.com/view/18568837/2sAY55ZxLp    
```