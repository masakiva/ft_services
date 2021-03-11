#!/bin/sh

mkdir /etc/telegraf
mv telegraf.conf /etc/telegraf/telegraf.conf

influxd &
telegraf
