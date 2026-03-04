# Pokédex Global66

A Flutter app to browse Pokémon data from the [PokeAPI](https://pokeapi.co/). Browse the catalog, search by name, filter by type, view details, and save favorites.

---

## How to Run

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (^3.11.0)
- Optional: [FVM](https://fvm.app/) for version management

### Setup & Run

```bash
# Install dependencies
flutter pub get

# Run the app (use fvm if you use FVM)
flutter run
# or
fvm flutter run
```

### Run Tests

```bash
flutter test
```

---

## Architecture

The project follows a **layered / clean architecture** structure:

```
lib/
├── config/           # App configuration
│   ├── providers/    # Riverpod state management
│   ├── router/       # GoRouter navigation
│   ├── theme/        # App theme
│   └── preferences/  # Local preferences (used for show the onboarding)
│
├── data/             # Data layer
│   ├── datasources/  # API implementation (PokeAPI via Dio)
│   ├── repositories/ # Repository implementations
│   ├── mappers/      # API response → domain mapping
│   └── models/       # API-specific models
│
├── domain/           # Business logic
│   ├── entities/     # Domain models (Pokemon, PokemonListItem)
│   ├── datasources/  # Abstract data source contracts
│   └── repositories/ # Abstract repository contracts
│
├── presentation/     # UI layer
│   ├── screens/      # Full-screen views
│   └── widgets/      # Reusable UI components
│
├── l10n/             # Localization (en, es)
└── utils/            # Helpers, clippers
```

### Key Patterns

- **Riverpod** for state management (providers, notifiers)
- **GoRouter** for declarative routing
- **Repository pattern** to abstract data sources
- **Freezed** for immutable domain entities

---

## Navigation

- **Home** (`/`) – Pokémon catalog
- **Favorites** (`/favoritos`) – Saved Pokémon
- **Pokémon detail** (`/pokemon/:name`) – Individual Pokémon
- **Regions** (`/regiones`) – Placeholder
- **Profile** (`/perfil`) – Placeholder

---

## Functionalities & API Endpoints

### Functionalities

| Feature | How it works |
|---------|--------------|
| **Pokémon list** | Loads Pokémon in pages of 10 via infinite scroll. Fetches from `/pokemon` PokeAPI endpoint with `offset` and `limit`. To show image and types, the `/pokemon/:name` endpoint is called since the initial endpoint only returns the name. It's not the optimal and efficient way but it was neccesary since the inital endpoint missed those attributes.|
| **Search** | Debounced text input triggers an API call: fetches the full Pokémon list (up to 1500), filters by name client-side, then fetches details for each match via `/pokemon/{name}`. Again, it's necessary to call that endpoint for showing the attributes.|
| **Type filter** | Multi-select filter by Pokémon type (fire, water, grass, etc.). Filters loaded items client-side. |
| **Pokémon detail** | Fetches Pokémon data, species (description, gender rate), and type damage relations to show weaknesses. Combines `/pokemon/:name`, `/pokemon-species/:name`, and `/type/:typeName`. |
| **Favorites** | Toggle favorite status with a heart icon. Stored locally in SharedPreferences. Favorites screen loads details for each saved name. |
| **Onboarding** | Two-step tour shown on first launch. Completion flag stored in SharedPreferences. |
| **Localization** | English and Spanish via ARB files. App locale follows device settings. |

### PokeAPI Endpoints Used

Base URL: `https://pokeapi.co/api/v2`

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/pokemon?offset={n}&limit={n}` | GET | Paginated list of Pokémon (name, URL). Used for catalog and infinite scroll. |
| `/pokemon/{name}` | GET | Full Pokémon data: stats, sprites, types, abilities, weight, height. Used for detail screen and list items. |
| `/pokemon-species/{name}` | GET | Species data: flavor text (description), gender rate, evolution chain. Used for detail screen. |
| `/type/{typeName}` | GET | Type damage relations (`double_damage_from`). Used to show weaknesses for the detail screen. |

---

## Tech Stack

- **Flutter** – UI framework
- **Riverpod** – State management
- **GoRouter** – Navigation
- **Dio** – HTTP client
- **Freezed** – Immutable models
- **SharedPreferences** – Local storage
- **flutter_svg** – SVG assets

---

## Security

- **API**: All requests use HTTPS to PokeAPI. No API keys or credentials are required; the API is public and read-only.
- **Local storage**: Favorites and onboarding preferences are stored in SharedPreferences (unencrypted). The data is non-sensitive (Pokémon names, a boolean flag).
- **No authentication**: The app does not collect or store user credentials.
- **Build artifacts**: Signing keystores and `key.properties` are excluded from version control (see `.gitignore`) when signing the app to release.
