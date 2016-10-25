#!/bin/bash
if [[ ! -z "$ELASTICSEARCH_PORT_9200_TCP_ADDR" ]]; then
    ADDR=$ELASTICSEARCH_PORT_9200_TCP_ADDR
elif [[ ! -z "$ELASTICSEARCH_ADDR" ]]; then
    ADDR=$ELASTICSEARCH_ADDR
else
    echo "Elasticsearch address not set.. exiting."
    exit 0
fi

mkdir -p /etc/logstash/conf.d
echo 'input {
  file { 
    path => ["/var/log/suricata/eve.json"]
    sincedb_path => ["/var/lib/logstash/"]
    codec =>   json 
    type => "SuricataIDPS" 
  }

}

filter {
  if [type] == "SuricataIDPS" {
    date {
      match => [ "timestamp", "ISO8601" ]
    }
    ruby {
      code => "if event['event_type'] == 'fileinfo'; event['fileinfo']['type']=event['fileinfo']['magic'].to_s.split(',')[0]; end;" 
    }
  }

  if [src_ip]  {
    geoip {
      source => "src_ip" 
      target => "geoip" 
      #database => "/opt/logstash/vendor/geoip/GeoLiteCity.dat" 
      add_field => [ "[geoip][coordinates]", "%{[geoip][longitude]}" ]
      add_field => [ "[geoip][coordinates]", "%{[geoip][latitude]}"  ]
    }
    mutate {
      convert => [ "[geoip][coordinates]", "float" ]
    }
    if ![geoip.ip] {
      if [dest_ip]  {
        geoip {
          source => "dest_ip" 
          target => "geoip" 
          #database => "/opt/logstash/vendor/geoip/GeoLiteCity.dat" 
          add_field => [ "[geoip][coordinates]", "%{[geoip][longitude]}" ]
          add_field => [ "[geoip][coordinates]", "%{[geoip][latitude]}"  ]
        }
        mutate {
          convert => [ "[geoip][coordinates]", "float" ]
        }
      }
    }
  }
}

output { 
  elasticsearch_http {
    host => '$ADDR'
  }
}' > /etc/logstash/conf.d/logstash.conf

/docker-entrypoint.sh
