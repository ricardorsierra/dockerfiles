#!/bin/bash

SSMTP_SETTINGS_PATH=/etc/ssmtp/ssmtp.conf
cp /opt/docker/ssmtp.conf ${SSMTP_SETTINGS_PATH}
/bin/sed -i "s#<SSMTP_ROOT>#${SSMTP_ROOT}#" ${SSMTP_SETTINGS_PATH}
/bin/sed -i "s@<SSMTP_MAILHUB>@${SSMTP_MAILHUB}@" ${SSMTP_SETTINGS_PATH}
/bin/sed -i "s@<SSMTP_HOSTNAME>@${SSMTP_HOSTNAME}@" ${SSMTP_SETTINGS_PATH}


DOCUMENT_ROOT=/data/web/releases/current/
SETTINGS_PATH=${DOCUMENT_ROOT}Configuration/Production/Settings.yaml

mkdir -p ${DOCUMENT_ROOT}Configuration/ ${DOCUMENT_ROOT}Data/ ${DOCUMENT_ROOT}Web/
chown -R www-data:www-data ${DOCUMENT_ROOT}Configuration/ ${DOCUMENT_ROOT}Data/ ${DOCUMENT_ROOT}Web/
chmod -R u+rwx,g+rwx ${DOCUMENT_ROOT}Configuration/ ${DOCUMENT_ROOT}Data/ ${DOCUMENT_ROOT}Web/

if [ -f ${SETTINGS_PATH}.docker ];
then
	cp ${SETTINGS_PATH}.docker ${SETTINGS_PATH}
else
	cp /opt/docker/Settings.yaml.docker ${SETTINGS_PATH}
fi

/bin/sed -i "s@<DB_HOST>@${DB_PORT_3306_TCP_ADDR}@" ${SETTINGS_PATH}
/bin/sed -i "s@<DB_PORT>@${DB_PORT_3306_TCP_PORT}@" ${SETTINGS_PATH}
/bin/sed -i "s@<DB_NAME>@${DB_ENV_MYSQL_DATABASE}@" ${SETTINGS_PATH}
/bin/sed -i "s@<DB_USER>@${DB_ENV_MYSQL_USER}@" ${SETTINGS_PATH}
/bin/sed -i "s@<DB_PASSWORD>@${DB_ENV_MYSQL_PASSWORD}@" ${SETTINGS_PATH}

/bin/sed -i "s@<ELASTICSEARCH_HOST>@${ELASTICSEARCH_PORT_9200_TCP_ADDR}@" ${SETTINGS_PATH}
/bin/sed -i "s@<ELASTICSEARCH_PORT>@${ELASTICSEARCH_PORT_9200_TCP_PORT}@" ${SETTINGS_PATH}

cd ${DOCUMENT_ROOT}
rm Configuration/PackageStates.php
find Configuration -type f -name "IncludeCachedConfigurations.php" -delete
rm Web/_Resources/Persistent/*
rm Web/_Resources/Static/Packages/*


su www-data export -c "FLOW_CONTEXT=Production ${DOCUMENT_ROOT}flow flow:cache:flush --force"
su www-data export -c "FLOW_CONTEXT=Production ${DOCUMENT_ROOT}flow doctrine:migrate --force"
su www-data export -c "FLOW_CONTEXT=Production ${DOCUMENT_ROOT}flow cache:warmup --force"

su www-data export -c "FLOW_CONTEXT=Production ${DOCUMENT_ROOT}flow nodeindex:cleanup --force"
su www-data export -c "FLOW_CONTEXT=Production ${DOCUMENT_ROOT}flow nodeindex:build --force" &


#############################
## COMMAND
#############################

if [ "$1" = 'php-fpm' ]; then
	exec php-fpm
fi

exec "$@"
