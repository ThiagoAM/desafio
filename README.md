# Desafio Carrefour

Desafio Carrefour é um aplicativo desenvolvido usando SwiftUI e segue a arquitetura MVVM (Model-View-ViewModel). O objetivo principal do aplicativo é utilizar a API de usuário do GitHub para buscar usuários com base no login fornecido pelo usuário.

## Requisitos do Sistema

- Xcode 14.3
- macOS Ventura 13.3.1

## Dependências

- Alamofire 5.7.1 (Swift Package Manager)

## Configuração

1. Clone este repositório em sua máquina local.
2. Abra o projeto no Xcode.
3. Aguarde o Xcode resolver e baixar as dependências do Alamofire automaticamente.
4. Compile e execute o projeto no simulador ou dispositivo de sua escolha.

## Funcionalidades Principais

- **Carregar e Apresentar a Lista de Usuários**: O aplicativo realiza uma chamada ao endpoint `https://api.github.com/users` para carregar a lista de usuários do GitHub. Essa lista é apresentada aos usuários, exibindo seus nomes, fotos de perfil e outras informações relevantes.

- **Suporte à Busca de Usuários**: O aplicativo permite que os usuários realizem uma busca por qualquer usuário específico do GitHub. Ao inserir um login no campo de busca, uma chamada é feita ao endpoint `https://api.github.com/users/<login>` para recuperar as informações desse usuário em particular.

- **Mostrar Repositórios Públicos de um Usuário**: Além dos detalhes do usuário, o aplicativo exibe uma lista dos repositórios públicos pertencentes a um usuário específico. Isso é feito por meio da chamada ao endpoint `https://api.github.com/users/<login>/repos`, que recupera as informações dos repositórios do usuário.

- **Tratamento de Erros das Chamadas**: O projeto implementa um tratamento de erros para lidar com situações em que as chamadas à API do GitHub falham. Isso inclui a exibição de mensagens de erro adequadas para os usuários e a apresentação de uma interface consistente em caso de falhas na comunicação.

- **Sistema de Cache com FileManager para as Respostas das Requisições**: O aplicativo utiliza o `FileManager` para implementar um sistema de cache das respostas das requisições à API do GitHub. Isso permite que, em caso de problemas de conexão ou quando a mesma requisição é feita novamente, o aplicativo possa recuperar os dados a partir do cache local em vez de realizar uma nova chamada à API.
