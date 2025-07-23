<br>

# queerie_test

A modern Flutter project for movie search and detail, and robust testing.

All API using [OMDb API](https://www.omdbapi.com/).
<br>This app also implements **Flutter Clean Architecture with TDD.**

## Pre-requisites 📐

| Technology | Recommended Version | Installation Guide                                                    |
|------------|---------------------|-----------------------------------------------------------------------|
| Flutter    | v3.10.x             | [Flutter Official Docs](https://flutter.dev/docs/get-started/install) |
| Dart       | v3.0.x              | Installed automatically with Flutter                                  |

## Getting Started 🚀

- Clone this project
- Run `flutter pub get`
- Run `flutter gen-l10n` to generate localization files
- Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate freeze/mocks files
- Run `flutter run --flavor sandbox -t lib/main.dart --dart-define-from-file .env.sandbox.json` for **sandbox**
- Run `flutter run --flavor staging -t lib/main.dart --dart-define-from-file .env.staging.json` for **staging**
- Run `flutter run --flavor prod -t lib/main.dart --dart-define-from-file .env.prod.json` for **production**
- Run tests: `flutter test`
- To generate launcher icon based on Flavor: `dart run flutter_launcher_icons`
- To generate mock class: `flutter pub run build_runner build --delete-conflicting-outputs`
- To generate coverage test: `sh test_with_coverage.sh`

## Building the App

You can use Dart defines to enable feature flags or set environments:

```sh
flutter build apk --dart-define=ENV=dev
flutter build apk --dart-define=ENV=staging
flutter build apk --dart-define=ENV=prod
```

## Running Tests

```sh
flutter test
```

### With Coverage

```sh
flutter test --coverage
sh test_with_coverage.sh
```

## Useful Commands

- **Analyze code:**
  ```sh
  flutter analyze
  ```
- **Format code:**
  ```sh
  flutter format .
  ```
- **Run a specific test:**
  ```sh
  flutter test test/features/movie/pages/detail/detail_page_test.dart
  ```

## CI/CD

This project uses [GitHub Actions](.github/workflows/flutter_ci.yml) for:
- Building with different feature flags
- Running tests and collecting coverage
- (Optional) Uploading artifacts and coverage to Codecov

## Feature Flags

Feature flags are managed via Dart defines and a singleton service:

```dart
const String env = String.fromEnvironment('ENV', defaultValue: 'dev');
```

You can add more flags as needed and use them in your code for conditional features.

## TODO 📝

- [✅] Documentation
- [✅] Screenshots
- [✅] Code cleanup
- [✅] Code coverage
- [✅] Error handling
- [✅] Localization
- [✅] Dark mode support
- [✅] Performance optimization
- [✅] Code refactoring
- [✅] UI enhancements
- [✅] Unit tests
- [✅] Widget tests
- [✅] Integration tests
- [✅] Continuous integration setup
- [x] Continuous deployment setup
- [x] Integration Test
- [x] Feature flag

## Screenshots

| Home Screen                                | Menu Screen                                 | Detail Screen                                        |
|--------------------------------------------|---------------------------------------------|------------------------------------------------------|
| ![Home](assets/images/Screenshot_home.png) | ![Menu](assets/images/Screenshot_menu.png)  | ![Detail](assets/images/Screenshot_movie_detail.png) |

| Search Screen                                       | Settings Screen                                 | Filter Screen                                  |
|-----------------------------------------------------|-------------------------------------------------|------------------------------------------------|
| ![Search](assets/images/Screenshot_search_list.png) | ![Settings](assets/images/Screenshot_setting.png) | ![Detail](assets/images/Screenshot_filter.png) |

---

**Happy coding!**