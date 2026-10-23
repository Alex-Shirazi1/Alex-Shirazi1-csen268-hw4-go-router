# CSEN 268 HW4 — Book Club with GoRouter

Book Club implements the Homework 4 GoRouter and AuthenticationBloc requirements. It reuses HW3's six books, book model, cover assets, and detail widget. The list, login, and profile screens follow the supplied HW4 prototype captures: vertical title/author rows and By Author, By Title, and Profile bottom navigation.

## Required routes

| Name | Full path | Placement |
| --- | --- | --- |
| home | `/` | Parent of ShellRoute; exact `/` redirects to `/byAuthor` |
| byAuthor | `/byAuthor` | Shell, sorted by author |
| byAuthorDetail | `/byAuthor/detail` | Nested child, root navigator |
| byTitle | `/byTitle` | Shell, sorted by title |
| byTitleDetail | `/byTitle/detail` | Nested child, root navigator |
| profile | `/profile` | Shell, logout |
| login | `/login` | Outside shell, login |

`AuthenticationBloc` is provided above `MaterialApp.router`. Login and logout only dispatch bloc events. `StreamToListenable` listens to the bloc stream and supplies `refreshListenable`. The global redirect checks authentication on navigation and refresh: authenticated at `/login` goes to `/byAuthor`; any non-authenticated state elsewhere goes to `/login`.

The home GoRoute contains the ShellRoute, which owns the bottom navigation. Child paths are relative. Navigation uses `goNamed` and the exact route-name constants. The nested route tree builds the detail back stack. Details use `parentNavigatorKey: rootNavigatorKey`, following the lecture's full-screen detail pattern, and back returns to the corresponding sorted list.

A selected `Book` travels in `extra`. Direct detail URLs without a Book show “No book selected” and a recovery button. Authentication is an in-memory mock and resets on reload. No real credentials or backend are needed. Extra serialization across browser reloads is not promised.

The six distinct HW3 books make sorting visible; the repeated Da Vinci Code rows in the prototype are treated as placeholders. Author ordering starts with Angelina Aludo; title ordering starts with A Clockwork Orange. No signup, forgot-password, Users, or profile-detail routes remain.

## Run and verify

```sh
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web
python3 tool/serve_web.py
```

Open http://127.0.0.1:8268. The server falls back to index.html for direct routes. This checkout's local SDK is `../.flutter-sdk/bin/flutter` (and `../.flutter-sdk/bin/dart`). Dependencies include go_router 18.0.2, flutter_bloc 9.1.1, bloc 9.2.1, equatable 3.0.0, and material_ui 1.8.0; see pubspec.lock for exact resolutions.

## Reference priority

The posted three-slide Homework 4 Instructions deck defines the routes and auth behavior. The supplied HW4 prototype screenshots define the visible list/login/profile layout. The GoRouter lecture supplies the nested-navigation pattern. Earlier Users-demo plans are superseded. No specific detail screenshot was supplied, so detail content reuses HW3.
