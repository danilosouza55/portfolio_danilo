# Documentação Técnica - Portfolio Danilo

## Visão Geral
Este projeto é um portfólio desenvolvido em Flutter, com suporte para Web e Android. Ele serve como uma vitrine profissional, apresentando informações, projetos e formas de contato do desenvolvedor.

- **Página de contato:** [https://danilosouza.dev.br](https://danilosouza.dev.br)
- **Tecnologia principal:** Flutter 3.24+
- **Plataformas:** Web, Android
- **Execução:** Nativa ou via Docker

---

## Estrutura do Projeto

```
portfolio_danilo/
├── android/           # Projeto Android nativo
├── assets/            # Imagens, fontes e outros recursos
├── build/             # Saída de builds
├── ios/               # Projeto iOS nativo
├── lib/               # Código fonte principal em Dart
│   ├── main.dart      # Ponto de entrada da aplicação
│   └── src/           # Componentes, páginas e lógica
├── linux/             # Projeto Linux
├── macos/             # Projeto macOS
├── test/              # Testes automatizados
├── web/               # Arquivos para build web
├── windows/           # Projeto Windows
├── pubspec.yaml       # Dependências e configurações do Flutter
├── Dockerfile         # Configuração para container Docker
└── README.md          # Documentação inicial
```

---

## Requisitos
- **Flutter:** Versão 3.24 ou superior
- **Docker:** Para execução em container (opcional)

---

## Como Executar

### Execução Nativa
1. Instale o Flutter 3.24+
2. Clone o repositório:
   ```bash
   git clone https://github.com/danilosouza55/portfolio_danilo.git
   cd portfolio_danilo
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Execute localmente:
   ```bash
   flutter run -d chrome   # Para web
   flutter run -d android # Para Android
   ```

### Execução via Docker
Para criar e publicar a imagem Docker:
```bash
docker buildx build --platform linux/amd64,linux/arm64/v8 -t danilo55555/website_portfolio:latest --push .
```

---

## Contato
Para dúvidas, sugestões ou propostas, acesse: [https://danilosouza.dev.br](https://danilosouza.dev.br)

---

## Licença
Este projeto é de uso pessoal e portfólio. Para outros usos, entre em contato com o autor.
