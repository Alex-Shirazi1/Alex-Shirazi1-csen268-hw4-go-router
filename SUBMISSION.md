# HW4 submission checklist

- [ ] Review any newer instructions posted by the professor before submitting.
- [ ] Run flutter analyze, flutter test, and flutter build web.
- [ ] Create a personal GitHub repository and push this project yourself.
- [ ] Give mehmet@artun.com viewer access, using the professor's GitHub account or GitLab email invitation as appropriate.
- [ ] Use the local hw4-submission tag to identify the submitted commit; push the tag yourself.
- [ ] Paste the repository/tag link in Camino and verify access.
- [ ] Optionally upload an annotated screenshots PDF or link an unlisted YouTube recording.

## Screenshot checklist

Each screenshot should show the PrintRoute panel and browser URL. Annotate the behavior being demonstrated.

- [ ] /login: logged-out redirect from initial /users.
- [ ] /login/signup: nested login child and Back.
- [ ] /login/forgot: nested login child and Back.
- [ ] /users: three mock users, selected Users tab.
- [ ] /users/1: path parameter, route template, no bottom bar, Back.
- [ ] /profile: selected Profile tab and Show Detail.
- [ ] /profile/detail: root navigator detail, no bottom bar, Back.

## Recording script (under three minutes)

1. 0:00–0:20: Start logged out. Point out /login and explain initial /users was redirected by the auth guard.
2. 0:20–0:40: Tap Login. Explain the button sends a bloc event, the stream refreshes GoRouter, and redirect changes the URL to /users.
3. 0:40–1:00: Tap Alex Shirazi. Show /users/1, the /users/:userId template, and missing bottom bar. Tap Back to return to Users.
4. 1:00–1:20: Select Profile. Explain ShellRoute keeps the two-tab bar and selects the active path.
5. 1:20–1:40: Tap Show Detail. Explain parentNavigatorKey puts /profile/detail on the root navigator above the shell. Tap Back.
6. 1:40–2:00: Tap Logout. Explain the event resets auth and redirects to /login without navigation in the button.
7. 2:00–2:25: Open Forgot password and go Back; show Sign up and go Back. Explain both are children of /login.
8. 2:25–2:45: Login again. Show the clean /users URL and briefly mention query filtering and the passing tests.

## Camino fields

Accepted types reported in the supplied assignment transcript: text entry, website URL, media recording, or file upload. Paste the repo/tag URL or unlisted video URL in the appropriate field, or upload the annotated PDF. Confirm the final submission yourself. No remote repository, push, remote tag, video recording, or Camino submission is performed by this project.
