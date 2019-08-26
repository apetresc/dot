Windows Terminal
================

Like lots of Windows applications, Terminal stores its configuration in some
random subdirectory of `~/AppData/Local`, which means yada can't currently
symlink it in nicely. So the file is just in the root of the module, and needs
to be copied in manually.
