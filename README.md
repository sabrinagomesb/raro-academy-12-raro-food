# raro-food

Projeto prático para aulas dos fundamentos de modelagem de banco de dados.

## setup

Antes de iniciar a aplicação, recomenda-se a execução da seguinte sequência de comandos:

```bash
rvm use 3.1.2
cd raro-food
bundle install
rails db:create
rails db:migrate
rails db:seed
```

Para iniciar o servidor, recomenda-se a utilização do comando `./bin/dev`, pois ele garante os assets serão todos devidamente processados.

#### Alguns comandos utilizados para nossa aplicação:

Verificar versão do ruby utilizada:

```bash
rvm use 3.1.2
```

Verificar versão do Yarn

```bash
yarn -v
```

Criando uma nova aplicação rails:

```bash
rails new raro_food -c=tailwind -d=mysql -j=esbuild
```

```bash
cd raro_food
bin/rails db:create db:migrate db:seed
```

#### Adicionando Rubocop

No arquivo Gemfile:

```ruby
gem 'rubocop-rails', require: false
```

Na raiz do projeto crie um arquivo `.rubocop.yml` com o seguinte conteúdo:

```yaml
require: rubocop-rails

AllCops:
  NewCops: enable
  TargetRubyVersion: 3.1.2
```

Ao executar o comando abaixo no terminal, serão listados os erros encontrados:

```
rubocop
```

Para corrigí-los, pode ser executado o comando:

```
rubocop -A
```
