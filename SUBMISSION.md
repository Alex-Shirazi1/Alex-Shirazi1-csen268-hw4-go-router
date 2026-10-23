# HW4 submission checklist

- Review the Book Club change and verification results before publishing.
- Push the reviewed commit to the existing HW4 repository.
- Ensure the professor can access the repository (homework guidelines specify mehmet@artun.com).
- Point the submission tag at the reviewed final commit; the previous tag represents the old Users demo until updated.
- Submit the repository/tag link and any requested screenshots or recording yourself.

## Recording / screenshot flow

1. Open the app logged out: Login, no bottom navigation.
2. Tap Login: `/byAuthor`, author-sorted rows and selected By Author tab.
3. Tap a book: `/byAuthor/detail`, selected book details and back button, no bottom bar.
4. Back: `/byAuthor`.
5. Select By Title: `/byTitle`, title-sorted rows.
6. Tap a book: `/byTitle/detail`; back returns to `/byTitle`.
7. Select Profile: `/profile`, Profile tab selected; tap Logout to return to `/login`.
8. Explain that auth events refresh GoRouter and redirect, and that the ShellRoute owns the tabs.

The browser URL can demonstrate the path without adding debug labels to the prototype UI. Tests also cover direct detail URLs with no selection, protected routes while logged out, auth errors, home redirection, and unknown-route recovery.
