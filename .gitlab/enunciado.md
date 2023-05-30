Prática 01 - Semana 12

Nesse exercício iremos abordar o conteúdo apresentado nesta semana 12.

Daremos continuidade ao desenvolvimento da nossa aplicação RaroFood, agora aplicando os conhecimentos adquiridos sobre Mailers, Jobs, Hotwire e Storage.

O que será considerado na avaliação dessa atividade:

1. Implementação do envio de um e-mail assíncrono para o chefe notificando que um novo prato foi adicionado a um determinado pedido. Neste e-mail devem conter as seguintes informações: código do pedido, nome e e-mail do cliente, nome, descrição e preço unitário do prato. Além disso, deverão ser fornecidos dois links: um para o pedido e outro para o prato solicitado. Caso ainda não exista, será necessário criar rotas, controllers e views (simples e sem estilização) para o redirecionamento a partir do e-mail para visualização do prato e pedido, respectivamente. Utilizem os recursos de views/partials que aprendemos para e-mail. Uma estilização para o e-mail será considerada para avaliação.

2. Implementação de um Job enfileirado em uma queue chamada dishes quando o preço unitário de um prato é atualizado. Esse Job deverá atualizar o preço unitário dos itens dos pedidos que referenciam esse prato e o preço total do pedido. Essas atualizações deverão ocorrer apenas para os pedidos que estejam com o status Iniciado (started). Organizem em uma estrutura adequada e limpa.

3. Hotwire: Você deverá atualizar a tela de cadastro de pedidos, adicionando o recurso de itens do pedido de forma dinâmica, utilizando Turbo Streams ou Stimulus Components (https://www.stimulus-components.com/docs/stimulus-rails-nested-form).

4. Storage: Implementar o upload de fotos, bem como o console de ferramentas para estilização do texto (WYSIWYG), relacionado a descrição dos pratos (Dishes). Para isso, utilize os recursos do Action Text e Active Storage.
   Documentação: https://guiarails.com.br/action_text_overview.html

Observações:
Vocês podem utilizar a versão mais recente do projeto disponibilizada no repositório abaixo, ou seguir com a implementação realizada nas atividades anteriores:
https://git.raroacademy.com.br/turmas-ruby/ruby-turma1/ruby-alunos/raro-food

Segue também o link para o RaroClass, onde adicionamos diversos recursos semelhantes aos solicitados nessa atividade:
https://github.com/wilfrank84/raroclass

Como deverá ser entregue:
Até a data de entrega do exercício, você deverá realizar um fork do repositório em sua conta privada do gitlab da Raro Academy, ou clonar sua aplicação local, realizando todo o desenvolvimento da nossa prática e publicar seu conteúdo na branch main.

Para entrega no classroom, vocês devem anexar o link para esse repositório.

Não se esqueça de dar a permissão de "developer" aos professores e monitores desta turma, caso contrário, eles não terão acesso à sua entrega.

Seu repositório deve conter todos os arquivos necessários para o devido funcionamento do seu projeto.

Ainda no seu repositório, altere o arquivo README.md adicionando uma seção onde será descrita a resolução e as premissas adotadas por você. Estas descrições serão levadas em consideração na avaliação da sua entrega, além de ajudar muito os professores.

Os professores deverão avaliar sua entrega até o último commit feito até a data limite. Caso sua entrega possua commits após a data limite, nós avaliaremos a entrega considerando as penalidades de atraso. Para avaliar sua entrega, utilizaremos o ambiente de desenvolvimento do rails.

Garanta que tudo esteja funcionando. Qualquer pré-condição para o funcionamento deve ser registrada no README do projeto.
