# CourtClick



## Adding the API key

1. Create a free account on [TMDB](https://www.themoviedb.org/) and open **Settings → API**.
2. Copy your **API Read Access Token**.
3. Create a file named `.env` in the project root (next to `pubspec.yaml`):
   ```env
   ACCESS_TOKEN=your_tmdb_read_access_token
   ```
4. Restart the app. The token is sent as a `Bearer` header on every request.

`.env` is in `.gitignore`, so your key is not committed.

## Packages used

| Package | Used for |
| --- | --- |
| `flutter_bloc` | State management (Cubits) |
| `get_it` | Dependency injection |
| `dio` | HTTP requests |
| `dartz` | `Either` type for success/failure results |
| `freezed` / `freezed_annotation` | Immutable state classes |
| `flutter_dotenv` | Loading the API key from `.env` |
| `cached_network_image` | Loading and caching movie posters |
| `shimmer` | Loading placeholders |
| `build_runner` | Code generation for `freezed` |

## Architecture

The app follows **Clean Architecture**, split by feature.

```
lib/
├── core/        # Shared code: config, DI, Dio service, errors, theme, routes, widgets
└── features/
    ├── dashboard/   # Home movie lists + movie details
    ├── search/      # Movie search
    ├── coming/      # Upcoming movies
    └── home/        # Bottom navigation
```

Each feature has the same layers:

- **presentation** – screens and widgets
- **cubit** – holds the screen state and calls use cases
- **domain** – entities, repository interfaces and use cases (pure Dart, no Flutter)
- **data** – API data sources, models and repository implementations

Data flow:

```
UI → Cubit → UseCase → Repository → RemoteDataSource → Dio → TMDB API
```

Errors are turned into `Failure` objects and returned as `Either<Failure, Data>`, so the UI can show either the data or an error message. All dependencies are registered in `lib/core/di/service_locator.dart`.
