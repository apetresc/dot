gcalcli
=======

## Initialization

At the moment, I'm just manually copying around my `~/.gcalcli_oauth` file from
machine to machine. Eventually this will stop working. When it does, it looks
like I will likely have to create my own GCloud application with GCal API
access and fill in the `client_id`/`secret_id`, since the developer hasn't been
successful in getting this past review. Oh well.

## Cron Job

### With dunst
```
*/5 * * * * export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus; export DISPLAY=:0; . $HOME/.profile; gcalcli remind 6 'dunstify --timeout=60000 --replace=5643 "gcal" "%s"'
```

