# Projeto_Logico-dio
# E-commerce Database Project

Este projeto de banco de dados foi desenvolvido para modelar e gerenciar um sistema de e-commerce. Ele utiliza um esquema lógico refinado que integra informações de clientes (PJ e PF), produtos, fornecedores, pagamentos, entregas e estoques, com relacionamentos consistentes entre as tabelas.

## Funcionalidades do Banco de Dados
- **Cadastro de clientes PJ e PF:** Garantindo que cada cliente seja único (PJ ou PF).
- **Gerenciamento de pedidos:** Registro dos pedidos realizados, status e entrega associada.
- **Múltiplas formas de pagamento:** Suporte a Pix, cartão e boleto.
- **Controle de estoque e fornecedores:** Relação direta entre produtos, fornecedores e estoques.
- **Status de entrega:** Acompanhamento do código de rastreio e status da entrega.

## Queries Implementadas
1. **Recuperações Simples (`SELECT`):** Extração básica de dados como clientes, pedidos e produtos.
2. **Filtros (`WHERE`):** Consultas com filtros para localizar informações específicas, como pedidos pendentes.
3. **Atributos Derivados:** Geração de atributos derivados, como o valor total dos pedidos.
4. **Ordenação (`ORDER BY`):** Ordenação de dados, como listar clientes em ordem alfabética.
5. **Filtros com Grupos (`HAVING`):** Condições aplicadas a grupos, como total de vendas por cliente.
6. **Junções de Tabelas (`JOIN`):** Consultas mais complexas para relacionar produtos, fornecedores e estoques.

## Exemplos de Perguntas Respondidas
- Quantos pedidos foram realizados por cada cliente?
- Algum vendedor também é fornecedor?
- Qual a relação entre produtos, fornecedores e estoques?
- Quais são os nomes dos fornecedores e os produtos que eles fornecem?

## Como Usar
1. Execute o script SQL para criar o esquema do banco de dados.
2. Insira os dados de exemplo para testes.
3. Execute as queries fornecidas para responder às perguntas propostas.

## Objetivo
O objetivo é demonstrar a capacidade de modelagem de banco de dados relacional, criação de esquemas robustos e aplicação de queries SQL avançadas para análise e gerenciamento de dados em um sistema de e-commerce.
