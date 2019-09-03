# Newsmutt

Newsmutt is just my own name for a distinct Neomutt configuration optimized for reading NNTP
newsgroups rather than email. But it's not actually a program; it's just Neomutt under the hood.

## Running

You can use Neomutt's `-F` flag directly:
```
$ neomutt -F ~/.config/mutt/newsmuttrc
```

But I prefer defining it as an alias.

## Configuration

The only thing this module is missing, configuration-wise, is an actual NNTP server. Personally
I use newsmutt with Gmane most often, so my alias is:
```
alias newsmutt='neomutt -F ~/.config/mutt/newsmuttrc -g "news.gmane.org"'
```

I have not really figured out the best way to handle muxing together multiple NNTP servers. I'll
cross that bridge when I get there.
