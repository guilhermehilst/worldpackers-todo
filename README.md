# README

Esse teste foi desenvolvido utilizando docker e docker-compose, nas seguintes
versões:
```bash
Docker version 18.06.1-ce
docker-compose version 1.22.0
```
Se precisar, as instruções para instala-los está em
https://docs.docker.com/install/

## Como executar a aplicação
Baixe o projeto e entre na pasta:
```bash
git clone https://github.com/guilhermehilst/worldpackers-todo.git
cd worldpackers-todo
```
Como o docker e o docker-compose instalados,  execute os seguintes comandos:
```bash
docker-compose build
```
para instalar as gems:
```bash
docker-compose run --rm web bundle install
```
para criar o banco de dados e fazer a migrações:
```bash
docker-compose run --rm web bundle exec rails db:setup
```
após tudo configurado, rode o seguinte comando para rodar a aplicação:
```bash
docker-compose up
```
para acessar a aplicação, entre no browser na seguinte url:
```
http://localhost:3000
```
para os jobs assincronos, foi utilizado o Sidekiq. Para acessar o painel do
sidekiq:
```
http://localhost:3000/sidekiq
```
para acessar os emails enviados em desenvolvimento, utilizei a gem
`mailcatcher`, os emails podem ser acessados pela url:
```
http://localhost:1080
```

## Como executar a suite de testes
Para os testes, foi escolhido as gems `rspec-rails` e `shoulda-matchers`.
Execute o seguinte comando para rodar a suite de testes:
```bash
docker-compose run --rm web bundle exec rspec
```

## Problema Proposto
 App Rails de To Do

Nesse to-do list é possível:
* Registrar um usuário / logar (só precisa de um nome, email e senha)
* Adicionar uma tarefa (que é simplesmente um campo de texto)
* Editar uma tarefa
* Remover uma tarefa
* Marcar uma tarefa como completa

Quando um usuário marcar uma tarefa como completa:
* O sistema manda um email para o usuário com uma bela frase aleatória de
"Parabéns" (inventa qualquer 5 frases aleatórias) pintada de uma cor hexadecimal
aleatória também (inventa 5 e pega uma aleatoriamente)

* Além disso, também tem que enviar um evento para o sistema de tracking. Por
simplicidade, o sistema de tracking é só uma tabelinha de eventos que tem um
tipo de evento e um campo json em que você manda dados relevantes. No caso,
guardar nesse campo json a cor e a frase aleatória do email de "Parabéns".

Algumas exigências dos usuários muito empolgados com o sistema:
* Pelo menos a operação de marcar a tarefa como completa deve ser assíncrona.
* Usar o bootstrap para o CSS
* Fazer deploy no Heroku
* Criar uma rake task que extrai um relatório CSV de todos os eventos com:
usuário, cor hexadecimal, frase e a hora que foi marcada como completa (não vale
simplesmente imprimir attributes ou o json. tem que ser cada um separado).

Faça o código exatamente como faria no dia-a-dia de trabalho. Não precisa
inventar algo para impressionar : ) Só faça com o que está confortável.
