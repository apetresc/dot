# Weechat

Note that in order to connect to the default server list I've populated, you'll
need to manually add `sec.data.session` and `sec.data.zncpass` to `sec.conf`
(which, unless you're me, you won't be able to do, so you may as well just
clear the server list and make your own).

The format for the relevant section in `sec.conf` is:

```ini
[data]
__passphrase__ = off
session = "<insert-session-name>"
zncpass = "<insert-znc-password>"
```
