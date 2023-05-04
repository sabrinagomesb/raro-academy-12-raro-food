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
  gem 'factory_bot_rails'
  gem 'faker'
end

group :test do
  # ...
  gem 'rspec-rails'
  gem 'shoulda-matchers'
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

Crie um arquivo: `spec/support/factory_bot.rb` com o seguinte conteúdo:

```ruby
# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
```

Ative o carregamento automático do diretório de support descomentando a seguinte linha em seu `spec/rails_helper.rb`:

```ruby
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
```

### Adicionar Coverage para Testes

Adicione o seguinte trecho no `Gemfile` e execute o `bundle install`:

```ruby
group :test do
  # ...
  gem 'simplecov', require: false
end
```

No início do arquivo `spec_helper.rb` acrescentar o seguinte trecho:

```ruby
# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

# ...
```

### Adicionando Rubocop

No arquivo `Gemfile`:

```ruby
group :development do
  # ...
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
```

Na raiz do projeto crie um arquivo `.rubocop.yml` com o seguinte conteúdo:

```yaml
require:
  - rubocop-rails
  - rubocop-rspec

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
