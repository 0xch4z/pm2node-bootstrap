read app

# run index to node app
pm2 start "$app"

# start daemon
pm2 startup systemd

# monitor
pm2 monit

