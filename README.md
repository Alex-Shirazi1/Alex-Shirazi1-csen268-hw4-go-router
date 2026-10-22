# CSEN 268 HW4 GoRouter

A standalone Flutter demo of declarative navigation, nested routes, a Users/Profile shell, and mock authentication. It follows Dr. Mehmet Artun's GoRouter lecture and router_demo course examples. The supplied assignment-page transcript contains no detailed Camino specification; the Homework Instructions deck says specific instructions will follow. This implementation follows the supplied inferred requirements, not a published rubric.

## Run

Requires Flutter 3.47 or newer and Dart 3.13 or newer.

```sh
flutter pub get
flutter run
flutter run -d chrome
```

Tap Login to use the fixed demo credentials. No backend, account creation, email delivery, or persistence is involved. Reloading the browser logs you out.

## Routes

| Name | Path | Page | Navigator and purpose |
|---|---|---|---|
| home | / | Home | Root; parent of shell |
| login | /login | Login | Root; outside authenticated shell |
| signUp | /login/signup | Sign up | Root; nested login child with Back |
| forgotPassword | /login/forgot | Forgot password | Root; nested login child with Back |
| users | /users | Users | Shell; Users tab |
| userDetail | /users/:userId | User Detail | Root above shell; hides bottom bar |
| profile | /profile | Profile | Shell; Profile tab |
| profileDetail | /profile/detail | Profile Detail | Root above shell; hides bottom bar |
| notFound (reserved constant) | Any unmatched path | Page Not Found | Error builder on root; no explicit named route |

PrintRoute shows the route template and actual URI. For example, /users/:userId and /users/1 intentionally differ. Try /users?filter=alex while logged in to filter names case-insensitively. IDs 1, 2, and 3 are stable; an unknown ID displays User not found.

## Authentication and routing

The AuthenticationBloc and mock repository are created before the widget tree. MultiRepositoryProvider and BlocProvider supply them above MaterialApp.router. The app owns one router for its lifetime and disposes the router's StreamToListenable subscriptions when removed.

StreamToListenable listens to authentication state changes and notifies GoRouter through refreshListenable. This lets authentication update navigation without putting navigation commands into login or logout handlers.

The redirect sends AuthenticationInitial outside /login to /login, and AuthenticationAuthenticated inside /login to /users. Waiting and Error states return null, matching the supplied demo rules. This is a local teaching example, not a production authorization boundary. The app starts logged out at the requested /users location, demonstrating the guard immediately.

ShellRoute creates a second navigator and wraps Users/Profile in ScaffoldWithNavBar. Tabs use goNamed and select their index from the current path. Detail routes specify parentNavigatorKey: rootNavigatorKey, placing them above the shell with automatic AppBar Back buttons. Route hierarchy supplies the stack.

## Versions and choices

- Flutter 3.47.5 stable; Dart 3.13.4 used for verification.
- go_router 18.0.2; flutter_bloc 9.1.1; bloc 9.2.1.
- material_ui 1.8.0 (with cupertino_ui 1.1.4) matches the current GoRouter Material page implementation and professor's imports.
- Material 3 uses a deep-purple seed. InkRipple avoids an installed SDK shader incompatibility in headless tests.
- Mock users use deterministic initials instead of external images. UserAvatar also handles failed image URLs.
- flutter_web_plugins SDK usePathUrlStrategy provides clean URLs, guarded by kIsWeb.
- Mock sign-in accepts nonempty credentials, waits one second by default, and supports zero delay for tests.
- Signup and recovery are deliberately explanatory placeholders.

## Verify and serve the web build

```sh
dart format .
flutter analyze
flutter test
flutter build web
python3 tool/serve_web.py
```

Open http://127.0.0.1:8268. The server falls back to index.html for client routes. A deployed host likewise needs SPA fallback for clean URL reloads. Initial visits to protected routes redirect to Login because authentication is in memory.

Tests cover login/logout, loading state, both tabs, nested login children, root detail pages and Back, unknown routes and user IDs, query filtering, the home route, authenticated login redirects, bloc transitions, errors, and model serialization.

## Source layout

- lib/main.dart: providers, app lifecycle, MaterialApp.router, URL strategy.
- lib/navigation/routerdemo.dart: route names, keys, route tree, redirect, cleanup.
- lib/blocs/authentication/: authentication bloc, events, states.
- lib/repositories/authentication/: abstract repository and mock.
- lib/model/user.dart: serializable user and three fixed mock users.
- lib/utilities/stream_to_listenable.dart: refresh adapter.
- lib/pages/router_demo/: nine page widgets.
- lib/widgets/: route display, scaffold shell, page layout, avatars, list tiles, logout.
- test/: widget_test.dart, router_test.dart, authentication_bloc_test.dart, test_harness.dart.
- android/, ios/, web/: generated platform runners.
- tool/serve_web.py: local SPA server.
- SUBMISSION.md: submission checklist and recording script.

## References

The supplied 20_GoRouter.pdf (especially slides 8–20), 19_Flutter_Navigation.pdf, 24_Homework_Instructions.pdf, 23_Syllabus_Walkthrough.pdf, and course repo routerdemo.dart, authentication bloc, User model, StreamToListenable, and shell widgets informed this project. The course shell's unfinished tab handlers are implemented here. Official API reference: https://pub.dev/documentation/go_router/latest/go_router/ShellRoute-class.html

## Verification results

Verified on October 22, 2026: flutter analyze reported No issues found; flutter test passed all 17 tests with none skipped; flutter build web succeeded. The final web build was served locally and exercised in Chrome: Login → Users → User Detail → Back → Profile → Profile Detail → Back → Logout → Forgot password → Back → Sign up → Back → Login. Route labels, actual URLs, bottom-bar visibility, and AppBar Back behavior were checked throughout. The Users screen was visually inspected. Native Android/iOS builds were not run.

The local environment needed a writable SDK copy at ../.flutter-sdk. You may use that SDK on this machine or your normal compatible Flutter installation. cupertino_icons 1.0.9 supplies the optional iOS icon font.
