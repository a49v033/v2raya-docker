#!/bin/bash
smartdns -c /etc/v2raya/smartdns.conf
v2raya --mode=universal --webdir=/etc/v2raya-web
