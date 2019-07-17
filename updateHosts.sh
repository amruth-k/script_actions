MetastoreSQLServerIP=$1
MetastoreSQLServerHost=quaerometastore

echo "$MetastoreSQLServerIP $MetastoreSQLServerHost" | sudo tee -a /etc/hosts
