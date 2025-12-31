# testes_appium

Projeto de automação de testes E2E usando **Appium** (server em Node) + **Cucumber (Ruby)**, com execução facilitada via **Docker Compose**.

**Autor:** Leandro da Silva Stampini

---

## Visão geral

Este repositório foi estruturado para:

- Subir um **Appium Server** de forma reproduzível (container em `appium-node/`)
- Executar cenários **BDD** com **Cucumber** (Ruby) em `features/`
- Centralizar configurações (ex.: `appium-config.yml`, `session.json`)
- Armazenar evidências (ex.: `screenshots/`)

> Observação: este repo contém um `chromedriver-linux64/`, útil quando o alvo envolve Chrome/Android em ambiente Linux/containers.

---

## Stack

- Appium (Node)
- Cucumber (Ruby)
- Docker / Docker Compose

---

## Estrutura do projeto

- `docker-compose.yml` — orquestração dos containers
- `test-runner.Dockerfile` — imagem para executar os testes (runner)
- `appium-node/` — imagem e arquivos do Appium server
  - `appium-config.yml` — config do Appium
  - `entrypoint.sh` — inicialização do container
- `features/` — features do Cucumber
  - `step_definitions/` — steps (Ruby)
  - `support/` — hooks e env do Cucumber
- `session.json` — capabilities / sessão (quando aplicável)
- `screenshots/` — evidências geradas

---

## Pré-requisitos

### Para rodar via Docker (recomendado)

- Docker Desktop instalado e funcionando
- Docker Compose (no Docker Desktop já vem integrado)

### Para rodar local (sem Docker)

- Ruby (recomendado Ruby 3.x)
- Bundler
- Node.js (se for subir Appium localmente)
- Appium instalado (`npm i -g appium`) e drivers necessários

---

## Como executar (Docker Compose)

### 1) Subir o Appium Server

No diretório raiz do projeto:

```bash
docker compose up -d
```

Para ver logs:

```bash
docker compose logs -f
```

Para derrubar:

```bash
docker compose down
```

### 2) Rodar os testes (runner)

Este repo possui um `test-runner.Dockerfile`. Dependendo de como seu `docker-compose.yml` está definido, você pode executar o serviço de runner assim:

```bash
docker compose run --rm test-runner
```

Se o nome do serviço for diferente, liste os serviços:

```bash
docker compose config --services
```

---

## Como executar (local)

### 1) Instalar dependências Ruby

```bash
bundle install
```

### 2) Rodar Cucumber

Rodar tudo:

```bash
bundle exec cucumber
```

Rodar um feature específico:

```bash
bundle exec cucumber features/google_search.feature
```

Rodar por tag (se houver):

```bash
bundle exec cucumber --tags @smoke
```

---

## Configuração

### Appium

- Config principal: `appium-node/appium-config.yml`
- Capabilities/sessão (quando usado): `session.json`

> Se você estiver testando em emulador/dispositivo, garanta que as capabilities estejam corretas para a plataforma (Android/iOS), app/package/activity, e que o Appium tenha o driver instalado.

### Evidências

- Screenshots e artefatos devem ficar em `screenshots/` (ou no caminho configurado em `features/support/`).

---

## Dicas e troubleshooting

- **Container subiu, mas testes não conectam no Appium**: verifique host/porta configurados no `env.rb` e no `docker-compose.yml`.
- **Problemas com Chromedriver**: confirme compatibilidade do Chromedriver com a versão do Chrome/WebView do dispositivo.
- **Permissões no Windows (WSL/Docker Desktop)**: valide compartilhamento do diretório do projeto no Docker Desktop.

---

## Convenções

- Features em `features/*.feature`
- Steps em `features/step_definitions/*.rb`
- Hooks e setup em `features/support/`

---

## Manutenção

Para atualizar gems:

```bash
bundle update
```

Para rebuild das imagens Docker após mudanças em Dockerfiles:

```bash
docker compose build --no-cache
```

---

## Autor

Leandro da Silva Stampini
