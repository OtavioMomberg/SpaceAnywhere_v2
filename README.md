# 🌌 SpaceAnywhere

> Um aplicativo gratuito para explorar e aprender sobre astronomia de forma acessível e interativa.

## 📖 Sobre o projeto

O **SpaceAnywhere** é um aplicativo mobile desenvolvido com o objetivo de tornar o conhecimento sobre astronomia mais acessível, apresentando conteúdos de forma simples, visual e interativa.

A aplicação reúne curiosidades, quizzes, comparações entre objetos astronômicos, wallpapers, cálculos e traduções relacionadas ao universo.

O projeto é **completamente gratuito** e busca transformar o aprendizado de astronomia em uma experiência leve e agradável.

---

## ✨ Funcionalidades

- 🔭 **Curiosidade do dia**

  - Apresenta diariamente uma curiosidade sobre astronomia.
  - Permite acessar uma explicação mais aprofundada através da opção **"Saiba mais"**.
  - Disponibiliza as fontes utilizadas para elaboração do conteúdo.

- 🧠 **Quiz de astronomia**

  - Perguntas com 5 alternativas.
  - Uma pergunta apresentada por vez.
  - O usuário possui até 2 tentativas para responder.
  - Após um erro, a resposta correta é apresentada antes de avançar.

- 🪐 **Comparação de objetos astronômicos**

  - Permite comparar características de diferentes objetos astronômicos, como planetas e estrelas.

- 🖼️ **Wallpapers**

  - Disponibiliza wallpapers com temática espacial.
  - Permite visualizar a imagem em tamanho ampliado.
  - Permite salvar os wallpapers no dispositivo.

- ⚖️ **Calculadora de peso**

  - Permite calcular como seria o peso do usuário em diferentes planetas e objetos astronômicos.

- 🌎 **Tradução de objetos astronômicos**

  - Apresenta o nome de planetas e outros objetos astronômicos em diferentes idiomas.
  - Possibilidade de ouvir a pronúncia dos nomes.

---

# 🛠️ Tecnologias

## 📱 Frontend

- **Dart**
- **Flutter**

O aplicativo mobile utiliza Flutter como framework principal, com uma arquitetura organizada por funcionalidades (*features*).

## 🚀 Backend

- **Python**
- **FastAPI**
- **SQLAlchemy**

A API é responsável pelo fornecimento dos conteúdos consumidos pelo aplicativo.

## 🗄️ Banco de dados

- **PostgreSQL**
- **Supabase**

O banco armazena os conteúdos de curiosidades, perguntas, wallpapers, objetos astronômicos, idiomas e traduções.

---

# 🏗️ Arquitetura

O frontend é organizado utilizando uma abordagem **Feature-First**, na qual cada funcionalidade possui sua própria estrutura e responsabilidades.

A aplicação também possui áreas compartilhadas entre diferentes funcionalidades, além de um núcleo responsável pelas configurações e elementos fundamentais do aplicativo.

### Estrutura do projeto

```text
lib/
├── core/
│   ├── constants/
│   ├── di/
│   ├── routes/
│   └── themes/
│
├── features/
│   ├── calculator/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── comparison/
│   │   ├── data/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── curiosity/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   └── screens/
│   │
│   ├── quiz/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── translation/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   └── wallpaper/
│       ├── data/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       └── screens/
│
├── presentation/
│
├── shared/
│   ├── models/
│   ├── utils/
│   └── widgets/
│
└── main.dart
```

### Organização das camadas

A estrutura não força todas as *features* a possuírem todas as camadas.

As pastas `data`, `domain` e `presentation` são adicionadas conforme a complexidade e as responsabilidades de cada funcionalidade. Dessa forma, funcionalidades simples não recebem estruturas desnecessárias apenas para seguir um padrão.

- **`core/`** — configurações e elementos fundamentais da aplicação.
- **`features/`** — funcionalidades independentes do aplicativo.
- **`presentation/`** — elementos de apresentação compartilhados pelo aplicativo, como telas globais.
- **`shared/`** — componentes reutilizáveis entre diferentes funcionalidades.
- **`data/`** — modelos, repositories e acesso aos dados quando necessário.
- **`domain/`** — regras e serviços relacionados à funcionalidade.
- **`presentation/`** — telas e widgets específicos de uma funcionalidade.

---

# 🎨 Design

O SpaceAnywhere possui uma identidade visual baseada em uma estética espacial e moderna.

### Características

- 🌌 Gradiente de fundo utilizando tons escuros de azul até preto.
- 🪟 Componentes utilizando **Glassmorphism / Glass Style**.
- ✨ Interface minimalista e focada em conteúdo.
- 📱 Design pensado principalmente para dispositivos móveis.

---

# 🧭 Navegação

A navegação principal utiliza um **Drawer**, permitindo acesso às principais funcionalidades do aplicativo.

### Páginas principais

| Tela                   | Descrição                                                                |
| ---------------------- | ------------------------------------------------------------------------ |
| 🔭 `CuriosityScreen`   | Apresenta a curiosidade do dia e permite aprofundar o conteúdo.          |
| 🧠 `QuizScreen`        | Apresenta perguntas de astronomia com 5 alternativas e até 2 tentativas. |
| 🪐 `ComparisonScreen`  | Compara características de diferentes objetos astronômicos.              |
| 🖼️ `WallpaperScreen`  | Disponibiliza wallpapers espaciais para visualização e download.         |
| ⚖️ `CalculatorScreen`  | Calcula o peso do usuário em diferentes objetos astronômicos.            |
| 🌎 `TranslationScreen` | Apresenta nomes de objetos astronômicos em diferentes idiomas.           |

---

# 📄 Telas adicionais

Além das páginas acessíveis pelo Drawer, o aplicativo possui telas auxiliares:

- `SplashScreen` — tela apresentada durante a inicialização do aplicativo.
- `ExtraTextScreen` — apresenta uma versão aprofundada da curiosidade do dia.
- `FontsScreen` — apresenta as fontes utilizadas na elaboração dos conteúdos.
- `ExpandedImageScreen` — exibe um wallpaper em tamanho ampliado e permite seu download.
- `ResultPage` — apresenta o resultado de uma resposta do quiz.
- `HowInstallVoiceScreen` — explica como instalar a voz necessária para reprodução das pronúncias.

---

# 🌐 API

O aplicativo consome uma API REST desenvolvida com **FastAPI**.

## Endpoints

### `GET /api/v1/curiosity`

Retorna uma curiosidade astronômica.

```json
{
  "id": 0,
  "title": "Título exemplo",
  "short_answer": "Resposta curta exemplo",
  "long_answer": "Resposta longa exemplo",
  "content_font": [
    "https://astronomia.com"
  ]
}
```

### `GET /api/v1/quiz`

Retorna uma pergunta do quiz.

```json
{
  "id": 0,
  "question": "Pergunta exemplo?",
  "alternatives": [
    "Alternativa 1",
    "Alternativa 2",
    "Alternativa 3",
    "Alternativa 4",
    "Alternativa 5"
  ],
  "right_answer_index": 0
}
```

### `GET /api/v1/wallpaper`

Retorna informações sobre um wallpaper.

```json
{
  "id": 0,
  "thumbnail_image_url": "exemplo_thumbnail/imagem",
  "full_image_url": "exemplo_full_image/imagem"
}
```

### `GET /api/v1/translation`

> **Em desenvolvimento**

Retorna informações relacionadas à tradução de objetos astronômicos.

```json
{
  "id": 0,
  "object_translated": "Exemplo",
  "language_flag": "pt-BR"
}
```

---

# 🗄️ Banco de dados

O banco de dados utiliza **PostgreSQL através do Supabase**.

### Tabelas principais

#### `curiosity_table`

| Campo          | Tipo   |
| -------------- | ------ |
| `id`           | int    |
| `title`        | string |
| `short_answer` | string |
| `long_answer`  | string |

#### `question_table`

| Campo                | Tipo   |
| -------------------- | ------ |
| `id`                 | int    |
| `question`           | string |
| `alternatives`       | array  |
| `right_answer_index` | int    |
| `content_font`       | array  |

#### `wallpaper_table`

| Campo                 | Tipo   |
| --------------------- | ------ |
| `id`                  | int    |
| `thumbnail_image_url` | string |
| `full_image_url`      | string |

#### `astronomical_object_table`

| Campo  | Tipo            |
| ------ | --------------- |
| `id`   | int             |
| `name` | string — unique |

#### `language_table`

| Campo  | Tipo            |
| ------ | --------------- |
| `id`   | int             |
| `lang` | string — unique |

#### `translation_table`

| Campo                    | Tipo   |
| ------------------------ | ------ |
| `id`                     | int    |
| `translated`             | string |
| `language_flag`          | string |
| `astronomical_object_fk` | int    |
| `language_fk`            | int    |

---

# 🔮 Roadmap

Algumas funcionalidades planejadas para futuras versões:

- [ ] Criar uma seção para explicação de **fórmulas físicas e matemáticas**.
- [ ] Expandir o conteúdo educacional do aplicativo.
- [ ] Expandir a quantidade de objetos astronômicos disponíveis.
- [ ] Expandir a quantidade de idiomas disponíveis.
- [ ] Adicionar novos conteúdos interativos relacionados à astronomia.
- [ ] Continuar aprimorando a arquitetura e a organização interna do aplicativo.

---

# 🎯 Objetivo

O principal objetivo do SpaceAnywhere é **tornar o aprendizado sobre astronomia mais acessível, visual e interativo**, permitindo que qualquer pessoa possa explorar conhecimentos sobre o universo gratuitamente através de um aplicativo mobile.

---

## 📌 Status

🚧 **Em desenvolvimento**

O projeto encontra-se em desenvolvimento ativo, com novas funcionalidades e melhorias sendo adicionadas gradualmente.