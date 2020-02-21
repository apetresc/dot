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
     pull the `new->inbox,unread` trick that I do with Gmailieer, because
     there's no central server that I need to be careful about race conditions
     with.
  4. **Read them with neomutt**

     You can use neomutt's `-F` flag directly: 
     ```
     $ neomutt -F ~/.config/mutt/newsmuttrc
     ```
     But I prefer defining it as an alias.

## TODO

- [ ] Would be very cool to set up [muchsync](http://www.muchsync.org/) so I can
  sync up read status between computers.
