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

### Adicionando Unit Test

Adicione o seguinte trecho no `Gemfile`:

```ruby
group :development, :test do
  # ....
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'faker'
end
```

Execute os seguintes comandos:

```bash
bin/rails generate rspec:install
bin/rails db:migrate db:test:prepare
bin/rails generate rspec:model State
```

No arquivo gerado `rails_helper.rb`

```ruby
#...
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
```

### Adicionando Rubocop

No arquivo `Gemfile`:

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

```bash
rubocop
```

Para corrigí-los, pode ser executado o comando:

```bash
rubocop -A
```
