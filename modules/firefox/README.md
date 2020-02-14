Mozilla Firefox
===============

These files aren't in the `files/` hierarchy because they belong in Firefox's
profile directory, but profile IDs are unstable so there's no clean way to do
that. I guess this part remains slightly manual.

To enable the loading of `userChrome.css` (which was disabled by default since
Firefox 69 or so), the following needs to be set in `about:config`:
```
toolkit.legacyUserProfileCustomizations.stylesheets = True
```
