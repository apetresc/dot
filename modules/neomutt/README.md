# Neomutt

## MIMEmbellish

I prefer to compose and send emails in plaintext, but modern web clients like
Gmail do a terrible job rendering them (in particular, they don't really obey
`format=flowed` which means the lines will break where I broke them, which is
bad on, say, phones that can't fit even the 72 characters per line because of
all the stupid whitespace they insert.

So I make Neomutt take my plaintext email and pass it through a
[MIMEmbellish](./files/.config/mutt/scripts/MIMEmbellish) that uses Pandoc to
convert it to a multipart HTML email. So plaintext clients still get my
handcrafted text and GMail users get nicely-wrapped HTML.

## TODO
- [ ] Toggle MIMEmbellish on/off with a keyboard shortcut in Neomutt
