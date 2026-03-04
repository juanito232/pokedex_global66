# Pokédex Global66

Aplicación Flutter para consultar datos de Pokémon desde [PokeAPI](https://pokeapi.co/). Explora el catálogo, busca por nombre, filtra por tipo, consulta detalles y guarda favoritos.

---

## Cómo ejecutar

### Requisitos previos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (^3.11.0)
- Opcional: [FVM](https://fvm.app/) para gestión de versiones

### Instalación y ejecución

```bash
# Instalar dependencias
flutter pub get

# Ejecutar la app (usa fvm si usas FVM)
flutter run
# o
fvm flutter run
```

### Ejecutar tests

```bash
flutter test
```

---

## Arquitectura

El proyecto sigue una estructura de **arquitectura en capas / limpia**:

```
lib/
├── config/           # Configuración de la app
│   ├── providers/    # Gestión de estado con Riverpod
│   ├── router/       # Navegación con GoRouter
│   ├── theme/        # Tema de la app
│   └── preferences/  # Preferencias locales (para mostrar el onboarding)
│
├── data/             # Capa de datos
│   ├── datasources/  # Implementación de API (PokeAPI vía Dio)
│   ├── repositories/ # Implementaciones de repositorios
│   ├── mappers/      # Mapeo API → dominio
│   └── models/       # Modelos específicos de la API
│
├── domain/           # Lógica de negocio
│   ├── entities/     # Modelos de dominio (Pokemon, PokemonListItem)
│   ├── datasources/  # Contratos abstractos de fuentes de datos
│   └── repositories/ # Contratos abstractos de repositorios
│
├── presentation/     # Capa de UI
│   ├── screens/      # Pantallas completas
│   └── widgets/      # Componentes reutilizables
│
├── l10n/             # Localización (en, es)
└── utils/            # Helpers, clippers
```

### Patrones principales

- **Riverpod** para gestión de estado (providers, notifiers)
- **GoRouter** para navegación declarativa
- **Patrón Repository** para abstraer datos
- **Freezed** para entidades inmutables

---

## Navegación

- **Inicio** (`/`) – Catálogo de Pokémon
- **Favoritos** (`/favoritos`) – Pokémon guardados
- **Detalle Pokémon** (`/pokemon/:name`) – Pokémon individual
- **Regiones** (`/regiones`) – Placeholder
- **Perfil** (`/perfil`) – Placeholder

---

## Funcionalidades y endpoints de API

### Funcionalidades

| Funcionalidad | Cómo funciona |
|---------------|---------------|
| **Lista de Pokémon** | Carga Pokémon en páginas de 10 con scroll infinito. Obtiene datos del endpoint `/pokemon` de PokeAPI con `offset` y `limit`. Para mostrar imagen y tipos se llama al endpoint `/pokemon/:name`, ya que el inicial solo devuelve el nombre. No es la forma más óptima pero fue necesaria porque el endpoint inicial no incluye esos atributos. |
| **Búsqueda** | El input con debounce dispara una llamada a la API: obtiene la lista completa (hasta 1500), filtra por nombre en cliente, y luego obtiene detalles de cada coincidencia vía `/pokemon/{name}`. De nuevo, es necesario llamar al endpoint para mostrar los atributos. |
| **Filtro por tipo** | Filtro multi-selección por tipo (fuego, agua, planta, etc.). Filtra los elementos cargados en el cliente. |
| **Detalle Pokémon** | Obtiene datos del Pokémon, especie (descripción, ratio de género) y relaciones de daño por tipo para mostrar debilidades. Combina `/pokemon/:name`, `/pokemon-species/:name` y `/type/:typeName`. |
| **Favoritos** | Alterna favoritos con un icono de corazón. Se guardan localmente en SharedPreferences. La pantalla de favoritos carga detalles de cada nombre guardado. |
| **Onboarding** | Tour de dos pasos en el primer inicio. La bandera de completado se guarda en SharedPreferences. |
| **Localización** | Inglés y español en archivos ARB. La app sigue el idioma del dispositivo. |

### Endpoints de PokeAPI usados

URL base: `https://pokeapi.co/api/v2`

| Endpoint | Método | Propósito |
|----------|--------|-----------|
| `/pokemon?offset={n}&limit={n}` | GET | Lista paginada de Pokémon (nombre, URL). Usado para catálogo y scroll infinito. |
| `/pokemon/{name}` | GET | Datos completos: stats, sprites, tipos, habilidades, peso, altura. Usado para detalle y elementos de lista. |
| `/pokemon-species/{name}` | GET | Datos de especie: flavor text (descripción), ratio de género, cadena de evolución. Usado para detalle. |
| `/type/{typeName}` | GET | Relaciones de daño (`double_damage_from`). Usado para mostrar debilidades en la pantalla de detalle. |

---

## Tech Stack

- **Flutter** – Framework UI
- **Riverpod** – Gestión de estado
- **GoRouter** – Navegación
- **Dio** – Cliente HTTP
- **Freezed** – Modelos inmutables
- **SharedPreferences** – Almacenamiento local
- **flutter_svg** – Assets SVG

---

## Seguridad

- **API**: Todas las peticiones usan HTTPS a PokeAPI. No se requieren API keys ni credenciales; la API es pública y de solo lectura.
- **Almacenamiento local**: Favoritos y preferencias de onboarding se guardan en SharedPreferences (sin cifrar). Los datos no son sensibles (nombres de Pokémon, una bandera booleana).
- **Sin autenticación**: La app no recopila ni almacena credenciales de usuario.
- **Artefactos de build**: Los keystores de firma y `key.properties` están excluidos del control de versiones (ver `.gitignore`) al firmar la app para release.
