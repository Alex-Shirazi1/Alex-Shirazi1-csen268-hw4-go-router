# HW4 review handoff

## Where and status

Existing checkout: `/Users/alexshirazi/Desktop/Important/mobileDevClass/csen268_hw4_go_router`.
Existing remote: `Alex-Shirazi1/Alex-Shirazi1-csen268-hw4-go-router`.
Review the latest main-branch commit containing the Book Club implementation. The existing submission tag has not moved; review main rather than the old tag.

## What changed

- Replaced Users/signup/forgot/profile-detail demo routes with the seven exact assignment names: home, byAuthor, byAuthorDetail, byTitle, byTitleDetail, profile, login.
- Kept `/` as the parent GoRoute containing a ShellRoute, matching the professor's nesting. Exact `/` redirects to `/byAuthor`; child navigation does not trigger this redirect.
- Added By Author, By Title, Profile navigation and vertical book rows per the newly supplied screenshots. Login and Profile have simple Login/Logout controls. No decorative menu button with no behavior was added.
- Preserved AuthenticationBloc above MaterialApp.router, stream-to-Listenable refresh, and mock authentication. Redirect checks authenticated versus all other states on every navigation/refresh, using exact `/login` matching.
- Kept explicit cleanup of the refresh adapter; GoRouter disposal alone does not cancel its bloc subscription. The app also closes the bloc it owns.
- Reused HW3's six books, model, cropped cover assets, and detail content. Author sorting starts with Angelina Aludo (not Anthony Burgess); title sorting starts with A Clockwork Orange.
- Detail navigation uses goNamed with extra, with the nested route configuration creating the parent/back stack. Detail routes use the root navigator, hiding tabs, as in the lecture. Missing/wrong-type extra has a safe fallback.
- Removed obsolete pages/widgets and updated README/SUBMISSION.

## Verification performed

From the checkout:

```sh
../.flutter-sdk/bin/flutter pub get
../.flutter-sdk/bin/dart format --output=none --set-exit-if-changed lib test
../.flutter-sdk/bin/flutter analyze
../.flutter-sdk/bin/flutter test
../.flutter-sdk/bin/flutter build web
git diff --check
```

Results: dependencies resolved; format unchanged; analyzer reported no issues; all 17 tests passed; web release build succeeded (including Wasm dry run); diff whitespace check passed.

Tests cover auth state transitions/errors, login loading behavior, all protected paths while logged out, both tab sort orders, both detail routes and back actions, missing-extra recovery on both detail URLs, home redirect, authenticated visits to login, auth refresh redirects, logout, and unknown-path recovery.

The first run caught a home redirect checking matchedLocation, which evaluates to `/` for the parent even when visiting a child. Fixed to inspect state.uri.path == '/'. All tests passed after the fix.

Browser check used the release build and the existing SPA server handler on port 8270 in an isolated Chrome context (8268 was already occupied). Enabled Flutter semantics to inspect/click the rendered app. Walked Login -> By Author -> A Clockwork Orange detail -> back -> By Title -> Carmer and Grit detail -> back -> Profile -> Logout. Verified URLs, correct selected books, tab selection, no tabs on details/login, and return to the correct list. This was a desktop Chrome check, not an Android/iOS device run.

## Review boundaries

The posted Homework 4 PDF is authoritative for routes/auth. The latest provided screenshots supersede the old horizontal-cover HW3 captures for list/login/profile layout. No new detail screenshot was provided, so details reuse HW3 with the lecture's full-screen root-navigator behavior. The repeated Da Vinci Code prototype rows are treated as placeholders; distinct HW3 books demonstrate actual sorting. Authentication is in-memory and resets on reload; extra is not guaranteed to survive browser reload. No Camino submission was made.
