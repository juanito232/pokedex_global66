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
│   └── preferences/  # Local preferences (onboarding)
│
├── data/             # Data layer
│   ├── datasources/  # API implementation (PokeAPI via Dio)
│   ├── repositories/ # Repository implementations
│   ├── mappers/       # API response → domain mapping
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

## Main Functionalities

| Feature | Description |
|---------|-------------|
| **Pokémon list** | Paginated list of Pokémon with infinite scroll |
| **Search** | Search by name with debounced input |
| **Type filter** | Filter Pokémon by type (fire, water, etc.) |
| **Pokémon detail** | View stats, description, abilities, weaknesses, gender rate |
| **Favorites** | Mark Pokémon as favorites; persisted locally (SharedPreferences) |
| **Onboarding** | First-run tour for new users |
| **Localization** | English and Spanish support |

### Navigation

- **Home** (`/`) – Pokémon catalog
- **Favorites** (`/favoritos`) – Saved Pokémon
- **Pokémon detail** (`/pokemon/:name`) – Individual Pokémon
- **Regions** (`/regiones`) – Placeholder
- **Profile** (`/perfil`) – Placeholder

---

## Tech Stack

- **Flutter** – UI framework
- **Riverpod** – State management
- **GoRouter** – Navigation
- **Dio** – HTTP client
- **Freezed** – Immutable models
- **SharedPreferences** – Local storage
- **flutter_svg** – SVG assets
