gcalcli
=======

## Cron Job

### With dunst
```
*/5 * * * * export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus; export DISPLAY=:0; . $HOME/.profile; gcalcli remind 6 'dunstify --timeout=60000 --replace=5643 "gcal" "%s"'
```

