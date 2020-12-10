#!/bin/bash

service nginx restart
/etc/init.d/php7.4-fpm start
tail -f /dev/null
