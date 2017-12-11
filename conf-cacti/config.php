<?php

$database_type     = 'mysql';
$database_default  = 'cacti';
$database_hostname = 'db_cacti';
$database_username = 'cacti';
$database_password = 'cacti';
$database_port     = '3306';
$database_ssl      = false;

/* when the cacti server is a remote poller, then these entries point to
 *  * the main cacti server.  otherwise, these variables have no use. 
 *   * and must remain commented out. */

#$rdatabase_type     = 'mysql';
##$rdatabase_default  = 'cacti';
##$rdatabase_hostname = 'localhost';
##$rdatabase_username = 'cactiuser';
##$rdatabase_password = 'cactiuser';
##$rdatabase_port     = '3306';
##$rdatabase_ssl      = false;
#
#       //$scripts_path = '/var/www/html/cacti/scripts';
#       //$resource_path = '/var/www/html/cacti/resource/';
#
