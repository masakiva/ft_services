#!/bin/sh

#mv grafana.ini /etc/grafana.ini
#grafana-server -config /etc/grafana.ini -homepath /usr/share/grafana
#mv datasource.yaml /usr/share/grafana/conf/provisioning/datasources
grafana-server -homepath /usr/share/grafana
