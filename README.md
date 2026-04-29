# CineApp — Trabalho Full Stack com Dart

## Tema
Aplicação de catálogo de filmes e atores.
- **Filme** (entidade pai): id, titulo, genero, duracao, faixaEtaria, imagemUrl
- **Ator** (entidade filho): id, nome, personagem, idade, filmeId

Relacionamento 1:N — um filme possui vários atores.

## Configuração do banco de dados

Crie um arquivo `backend/.env` com a connection string do PostgreSQL:
```
postgresql://usuario:senha@host:porta/database
```

## Como rodar o backend

```bash
cd backend
dart pub get
dart run bin/server.dart
```

O servidor inicia em http://localhost:8080

## Endpoints da API

### Filmes (pai)
- GET /filmes — Listar todos
- GET /filmes/:id — Buscar por ID
- POST /filmes — Criar novo
- PUT /filmes/:id — Atualizar
- DELETE /filmes/:id — Remover

### Atores (filho)
- GET /atores — Listar todos
- GET /atores/:id — Buscar por ID
- GET /filmes/:id/atores — Listar atores de um filme
- POST /atores — Criar novo
- PUT /atores/:id — Atualizar
- DELETE /atores/:id — Remover

## Como rodar o Flutter

```bash
cd frontend
flutter pub get
flutter run -d chrome
```

## Tecnologias
- Backend: Dart + Shelf + PostgreSQL
- Frontend: Flutter + pacote http
- Documentação: Postman