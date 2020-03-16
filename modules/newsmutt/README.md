# Newsmutt

Newsmutt is just my own name for a distinct slrn, notmuch, and neomutt
configuration optimized for reading NNTP newsgroups rather than email. But it's
not actually a program; it's just a system of automations.

The goal is to simulate my e-mail workflow as closely as possible. It is driven
by the appropriately-named `nntpsync` script (in analogy to `mailsync`).

1. **Download raw new articles from the upstream news server**

   This is accomplished through `slrnpull`, which reads the list of groups to
   fetch (as well as the quantity) from `$HOME/.slrn/slrnpull.conf`. It has
   the format:
   ```
   # NEWSGROUP_NAME MAX_ARTICLES_TO_RETRIEVE   NUMBER_OF_DAYS_BEFORE_EXPIRE
   default 5000 365
   gmane.comp.python.general * *
    ```
2. **Convert them to Maildir**

   This is unfortunately necessary because, although notmuch can parse
   slrnpull's "numbered spool format", neomutt cannot. So I [found a Ruby
   script](https://lkml.org/lkml/2019/1/3/620) by Eric Wong (of public-inbox
   fame) that converts from one to the other (destructively, I might add).
3. **Index them with `notmuch new`**

   I use `$HOME/.news` as the notmuch database root. So far I see no reason to
   pull the `new->inbox,unread` trick that I do with Gmailieer, because there's
   no central server that I need to be careful about race conditions with.
4. **Read them with neomutt**

   You can use neomutt's `-F` flag directly: 
   ```bash
   $ neomutt -F ~/.config/mutt/newsmuttrc
   ```
   But I prefer defining it as an alias.

This is all that needs to be done to read the articles locally. However, if you
want to use this setup across several machines, it is inconvenient to reproduce
the setup on each one, especially since read/unread tracking will not carry over
the way it would with IMAP.

The solution is to use the above newsmutt setup on one "server" machine to do
the actual fetching from the NNTP server, and then run
[muchsync]([muchsync](http://www.muchsync.org/) on any number of other clients
(which have SSH access to the server) to pull and push both the Maildir and
changes to the notmuch database.

1. On a brand new client (_before_ you `yada install` this module), you need to
   initialize a new Notmuch database. (Make sure this isn't one that already
   exists! This only needs to happen once.)
   ```bash
   NOTMUCH_CONFIG="$HOME/.news/.notmuch-config" muchsync --init $HOME/.news \
     <server-ssh-hostname> -C "$HOME/.news/.notmuch-config"
   ```
   This may take quite a while to complete. You can track progress by comparing
   `du -sh ~/.news` on the server and client separately.
2. Once the `--init` is complete, you can now run `yada install newsmutt` on the
   client.
3. Run `newsmutt-sync` to generate your mailboxes.
4. Run `newsmutt` and you should be good to go! You can use the `o` macro or
   manually run `newsmutt-sync` whenever you want to push/pull changes with the
   server.
