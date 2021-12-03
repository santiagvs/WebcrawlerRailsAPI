# Webcrawler Rails API

## Pequeno projeto de webcrawler/scraper utilizando:
- Ruby on Rails (API);
- Nokogiri;
- Mongoid;
- Sistema básico de autenticação por token com chave e valor [^1];
- Cache simulado usando Mongoid.

## Recursos e funcionamento

A API possui um único endpoint: ```/quotes/:tag```, onde o parâmetro é uma tag referente ao site [Quotes to Scrape](http://quotes.toscrape.com) no qual o webcrawler busca as frases de acordo com a tag passada como parâmetro. É necessário prover o token de autenticação para poder acessar e requisitar os dados.

O token se encontra em ApplicationController e por meio de um aplicativo como Postman ou Insomnia em Authorization > API Key se realiza a autenticação com a chave ```Authorization```, sendo o valor o próprio token.

O banco de dados (MongoDB, usando a gem Mongoid) armazena os seguintes campos:

- página buscada com o webcrawler;
- marcação de tempo; 
- tag 

sendo armazenados quando se faz a requisição. **Os dados da pesquisa/query são persistidos por 2 minutos no banco de dados, simulando um cache.**

### Chamada "sample"

```
    http://localhost:PORT/quotes/life

    {
        "quote": "There are only two ways to live your life. One is as though nothing is a miracle. The other is as though everything is a miracle.",
        "author": "Albert Einstein",
        "author_about": "http://quotes.toscrape.com/author/Albert-Einstein",
        "tags": [
            "inspirational",
            "life",
            "live",
            "miracle",
            "miracles"
        ]
    }
```
### Requisições e possíveis retornos

- **Esta aplicação apenas possui o método GET**.

|Código|Significado em relação à aplicação|
|-|-|
|200|_Requisição feita com sucesso, retornando as frases._|
|401|_Acesso negado por falta do token de autenticação._|
|404|_Nenhum parâmetro passado._|

### Notas e observações

[^1]: Poderia-se ter usado algumas gems ou dependências para certas funções, como JWT para gerar o token e realizar a autenticação. Tendo em vista que não possuo muita prática com essa gem e dado que é um projeto pequeno, foi melhor usar uma solução caseira da própria linguagem e do framework. Assim fica mais enxuto.