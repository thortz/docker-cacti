FROM thortz/docker-xenial

# Setup
RUN apt-get update && apt-get upgrade -y && apt-get install curl wget build-essential -y

# Webserver
RUN apt-get install apache2 php libapache2-mod-php php-mysql php-xml php-ldap php-mbstring php-gd php-gmp php-snmp -y

# Cacti dependencies
RUN apt-get install snmp snmpd rrdtool -y

#Cacti-spine dependencies
RUN apt-get install libmysqlclient-dev libssl-dev libmysqlclient-dev libsnmp-dev help2man -y

WORKDIR app
###
# Cacti source download and uncompress
RUN cd /app/ && wget https://www.cacti.net/downloads/cacti-1.1.28.tar.gz && tar -xvf cacti-1.1.28.tar.gz && mv cacti-1.1.28 cacti && rm -rf cacti-1.1.28.tar.gz

# Cacti-spine source download and uncompress
RUN cd /app/ && wget https://www.cacti.net/downloads/spine/cacti-spine-1.1.28.tar.gz && tar -xvf cacti-spine-1.1.28.tar.gz && rm -rf cacti-spine-1.1.28.tar.gz
###

###
# Cacti config SQL
RUN rm -rf /app/cacti/include/config.php
ADD conf-cacti/config.php /app/cacti/include/

# Apache2 configuration for cacti
ADD conf-apache/cacti.conf /etc/apache2/sites-available/
RUN touch /app/cacti/log/cacti.log
RUN chown -R www-data:www-data /app/cacti
RUN rm -rf /etc/apache2/sites-enabled/000-default.conf
RUN /usr/sbin/a2ensite cacti.conf
RUN /usr/sbin/a2enmod rewrite
RUN ln -s /app/cacti /app/cacti/cacti

#PHP configuration
RUN echo "date.timezone = Europe/Paris" >> /etc/php/7.0/apache2/php.ini

# Cacti-spine build
RUN cd /app/cacti-spine-1.1.28/ && ./configure && make && make install
###

###
#Port expose configuration
EXPOSE 80

# Init Script
ADD startup.sh /
RUN chmod +x /startup.sh

ENTRYPOINT ["/startup.sh","startup"]
