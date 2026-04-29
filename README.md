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
# Dados iniciais

## 1. POST /filmes/lote
```
[
  {"titulo":"O Poderoso Chefao","genero":"Drama","duracao":"2h55min","faixaEtaria":18,"imagemUrl":"https://image.tmdb.org/t/p/w500/hiKmpZMGZsrkA3cdce8a7Dpos1j.jpg"},
  {"titulo":"Duna: Parte 2","genero":"Ficcao Cientifica","duracao":"166 min","faixaEtaria":14,"imagemUrl":"https://upload.wikimedia.org/wikipedia/pt/5/52/Dune_Part_Two_poster.jpeg"},
  {"titulo":"Deadpool & Wolverine","genero":"Acao","duracao":"127 min","faixaEtaria":18,"imagemUrl":"https://image.tmdb.org/t/p/w500/8cdWjvZQUExUUTzyp4t6EDMubfO.jpg"},
  {"titulo":"Alien: Romulus","genero":"Terror","duracao":"119 min","faixaEtaria":16,"imagemUrl":"https://m.media-amazon.com/images/S/pv-target-images/fc5b932a59d80da11fb96ed4b7bb63de2891db0c343b03544e81539a4dcda313.jpg"},
  {"titulo":"Divertida Mente 2","genero":"Animacao","duracao":"100 min","faixaEtaria":0,"imagemUrl":"https://image.tmdb.org/t/p/w500/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg"},
  {"titulo":"Oppenheimer","genero":"Drama","duracao":"180 min","faixaEtaria":16,"imagemUrl":"https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg"},
  {"titulo":"Furiosa","genero":"Acao","duracao":"148 min","faixaEtaria":18,"imagemUrl":"https://image.tmdb.org/t/p/w500/iADOJ8Zymht2JPMoy3R7xceZprc.jpg"},
  {"titulo":"Interestelar","genero":"Ficcao Cientifica","duracao":"169 min","faixaEtaria":12,"imagemUrl":"https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg"},
  {"titulo":"Batman: O Cavaleiro das Trevas","genero":"Acao","duracao":"152 min","faixaEtaria":14,"imagemUrl":"https://play-lh.googleusercontent.com/b0bqoD27ib25NwPutF8Kf740iiFQ53CKUz27VBQkCQtvSfhdWQtb8vwFxxn-SzI-5ZATXXkDwf2qPODkNQ"},
  {"titulo":"Clube da Luta","genero":"Drama","duracao":"139 min","faixaEtaria":18,"imagemUrl":"https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg"},
  {"titulo":"Matrix","genero":"Ficcao Cientifica","duracao":"136 min","faixaEtaria":16,"imagemUrl":"https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg"},
  {"titulo":"Gladiador","genero":"Acao","duracao":"155 min","faixaEtaria":16,"imagemUrl":"https://image.tmdb.org/t/p/w500/ty8TGRuvJLPUmAR1H1nRIsgwvim.jpg"},
  {"titulo":"O Senhor dos Aneis: O Retorno do Rei","genero":"Aventura","duracao":"201 min","faixaEtaria":12,"imagemUrl":"https://image.tmdb.org/t/p/w500/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg"},
  {"titulo":"Parasita","genero":"Drama","duracao":"132 min","faixaEtaria":16,"imagemUrl":"https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg"},
  {"titulo":"John Wick 4","genero":"Acao","duracao":"169 min","faixaEtaria":18,"imagemUrl":"https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg"},
  {"titulo":"O Exorcista","genero":"Terror","duracao":"122 min","faixaEtaria":18,"imagemUrl":"https://image.tmdb.org/t/p/w500/4ucLGcXVVSVnsfkGtbLY4XAius8.jpg"},
  {"titulo":"Toy Story","genero":"Animacao","duracao":"81 min","faixaEtaria":0,"imagemUrl":"https://image.tmdb.org/t/p/w500/uXDfjJbdP4ijW5hWSBrPrlKpxab.jpg"},
  {"titulo":"A Origem","genero":"Ficcao Cientifica","duracao":"148 min","faixaEtaria":14,"imagemUrl":"https://image.tmdb.org/t/p/w500/ljsZTbVsrQSqZgWeep2B1QiDKuh.jpg"},
  {"titulo":"Coringa","genero":"Drama","duracao":"122 min","faixaEtaria":16,"imagemUrl":"https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg"},
  {"titulo":"Pulp Fiction","genero":"Drama","duracao":"154 min","faixaEtaria":18,"imagemUrl":"https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg"},
  {"titulo":"O Silencio dos Inocentes","genero":"Terror","duracao":"118 min","faixaEtaria":18,"imagemUrl":"https://upload.wikimedia.org/wikipedia/pt/0/0a/Silence_of_the_lambs.png"},
  {"titulo":"Shrek","genero":"Animacao","duracao":"90 min","faixaEtaria":0,"imagemUrl":"https://images3.memedroid.com/images/UPLOADED853/672e57837027d.jpeg"},
  {"titulo":"Se7en","genero":"Terror","duracao":"127 min","faixaEtaria":18,"imagemUrl":"https://image.tmdb.org/t/p/w500/6yoghtyTpznpBik8EngEmJskVUO.jpg"},
  {"titulo":"Forrest Gump","genero":"Drama","duracao":"142 min","faixaEtaria":12,"imagemUrl":"https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg"},
  {"titulo":"Vingadores: Ultimato","genero":"Acao","duracao":"181 min","faixaEtaria":12,"imagemUrl":"https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg"}
]
```

## 2. POST /atores/lote
```
[
  {"nome":"Marlon Brando","personagem":"Vito Corleone","idade":80,"filmeId":1},
  {"nome":"Al Pacino","personagem":"Michael Corleone","idade":84,"filmeId":1},
  {"nome":"Timothee Chalamet","personagem":"Paul Atreides","idade":29,"filmeId":2},
  {"nome":"Zendaya","personagem":"Chani","idade":28,"filmeId":2},
  {"nome":"Austin Butler","personagem":"Feyd-Rautha","idade":33,"filmeId":2},
  {"nome":"Ryan Reynolds","personagem":"Deadpool","idade":48,"filmeId":3},
  {"nome":"Hugh Jackman","personagem":"Wolverine","idade":56,"filmeId":3},
  {"nome":"Cailee Spaeny","personagem":"Rain","idade":27,"filmeId":4},
  {"nome":"David Jonsson","personagem":"Andy","idade":28,"filmeId":4},
  {"nome":"Amy Poehler","personagem":"Alegria","idade":53,"filmeId":5},
  {"nome":"Maya Hawke","personagem":"Ansiedade","idade":26,"filmeId":5},
  {"nome":"Cillian Murphy","personagem":"Robert Oppenheimer","idade":48,"filmeId":6},
  {"nome":"Robert Downey Jr","personagem":"Lewis Strauss","idade":59,"filmeId":6},
  {"nome":"Anya Taylor-Joy","personagem":"Furiosa","idade":28,"filmeId":7},
  {"nome":"Chris Hemsworth","personagem":"Dementus","idade":41,"filmeId":7},
  {"nome":"Matthew McConaughey","personagem":"Cooper","idade":55,"filmeId":8},
  {"nome":"Anne Hathaway","personagem":"Brand","idade":42,"filmeId":8},
  {"nome":"Christian Bale","personagem":"Batman","idade":50,"filmeId":9},
  {"nome":"Heath Ledger","personagem":"Coringa","idade":28,"filmeId":9},
  {"nome":"Brad Pitt","personagem":"Tyler Durden","idade":61,"filmeId":10},
  {"nome":"Edward Norton","personagem":"Narrador","idade":55,"filmeId":10},
  {"nome":"Keanu Reeves","personagem":"Neo","idade":60,"filmeId":11},
  {"nome":"Laurence Fishburne","personagem":"Morpheus","idade":63,"filmeId":11},
  {"nome":"Russell Crowe","personagem":"Maximus","idade":60,"filmeId":12},
  {"nome":"Joaquin Phoenix","personagem":"Commodus","idade":50,"filmeId":12},
  {"nome":"Viggo Mortensen","personagem":"Aragorn","idade":66,"filmeId":13},
  {"nome":"Elijah Wood","personagem":"Frodo","idade":44,"filmeId":13},
  {"nome":"Song Kang-ho","personagem":"Ki-taek","idade":57,"filmeId":14},
  {"nome":"Choi Woo-shik","personagem":"Ki-woo","idade":34,"filmeId":14},
  {"nome":"Keanu Reeves","personagem":"John Wick","idade":60,"filmeId":15},
  {"nome":"Donnie Yen","personagem":"Caine","idade":61,"filmeId":15},
  {"nome":"Linda Blair","personagem":"Regan","idade":65,"filmeId":16},
  {"nome":"Jason Miller","personagem":"Padre Karras","idade":62,"filmeId":16},
  {"nome":"Tom Hanks","personagem":"Woody","idade":68,"filmeId":17},
  {"nome":"Tim Allen","personagem":"Buzz Lightyear","idade":71,"filmeId":17},
  {"nome":"Leonardo DiCaprio","personagem":"Dom Cobb","idade":50,"filmeId":18},
  {"nome":"Elliot Page","personagem":"Ariadne","idade":37,"filmeId":18},
  {"nome":"Joaquin Phoenix","personagem":"Arthur Fleck","idade":50,"filmeId":19},
  {"nome":"Robert De Niro","personagem":"Murray Franklin","idade":81,"filmeId":19},
  {"nome":"John Travolta","personagem":"Vincent Vega","idade":71,"filmeId":20},
  {"nome":"Samuel L. Jackson","personagem":"Jules Winnfield","idade":76,"filmeId":20},
  {"nome":"Jodie Foster","personagem":"Clarice Starling","idade":62,"filmeId":21},
  {"nome":"Anthony Hopkins","personagem":"Hannibal Lecter","idade":87,"filmeId":21},
  {"nome":"Mike Myers","personagem":"Shrek","idade":61,"filmeId":22},
  {"nome":"Eddie Murphy","personagem":"Burro","idade":63,"filmeId":22},
  {"nome":"Brad Pitt","personagem":"Detetive Mills","idade":61,"filmeId":23},
  {"nome":"Morgan Freeman","personagem":"Detetive Somerset","idade":87,"filmeId":23},
  {"nome":"Tom Hanks","personagem":"Forrest Gump","idade":68,"filmeId":24},
  {"nome":"Robin Wright","personagem":"Jenny Curran","idade":58,"filmeId":24},
  {"nome":"Robert Downey Jr","personagem":"Tony Stark","idade":59,"filmeId":25},
  {"nome":"Chris Evans","personagem":"Steve Rogers","idade":43,"filmeId":25},
  {"nome":"Scarlett Johansson","personagem":"Natasha Romanoff","idade":40,"filmeId":25}
]
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