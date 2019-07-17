MetastoreSQLServerIP=$1
MetastoreSQLServerHost=$2

echo "$MetastoreSQLServerIP $MetastoreSQLServerHost" | sudo tee -a /etc/hosts
