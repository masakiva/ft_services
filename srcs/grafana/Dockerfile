FROM alpine:3.13

RUN apk update
RUN apk add grafana=7.3.6-r0

EXPOSE 3000

COPY grafana.ini /etc/grafana.ini
COPY influxdb-datasource.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/
COPY dashboards/ /var/lib/grafana/dashboards/
COPY init.sh .

CMD ["./init.sh"]
