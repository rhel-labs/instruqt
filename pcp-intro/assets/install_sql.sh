#!/bin/bash -e

# Use the following variables to control your install:

# Password for the SA user (required)
MSSQL_SA_PASSWORD='Redhat1!'

# Product ID of the version of SQL server you're installing
# Must be evaluation, developer, express, web, standard, enterprise, or your 25 digit product key
# Defaults to developer
MSSQL_PID='evaluation'

if [ -z $MSSQL_SA_PASSWORD ]
then
  echo Environment variable MSSQL_SA_PASSWORD must be set for unattended install
  exit 1
fi

echo Running dnf clean all
sleep 10
sudo dnf clean all

echo Adding Microsoft repositories...
sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/9.0/mssql-server-2019.repo

echo Running dnf update -y...
sleep 10
sudo dnf update -y

echo Installing OpenSSL
sudo dnf install -y compat-openssl11 #openldap-compat

#echo Setting default python version
#sudo alternatives --set python /usr/bin/python3

echo Download and Install SQL Server...
sudo dnf download mssql-server
#sudo rpm -Uvh --nodeps mssql-server*rpm

echo Running mssql-conf setup...
sudo MSSQL_SA_PASSWORD=$MSSQL_SA_PASSWORD \
     MSSQL_PID=$MSSQL_PID \
     /opt/mssql/bin/mssql-conf -n setup accept-eula

#Installing client tools
echo Installing mssql-tools and unixODBC developer...
curl https://packages.microsoft.com/config/rhel/9.0/prod.repo > /etc/yum.repos.d/msprod.repo
sudo ACCEPT_EULA=Y dnf install -y mssql-tools unixODBC-devel

echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc

ln -s /usr/lib64/libssl.so.10 /opt/mssql/lib/libssl.so
ln -s /usr/lib64/libcrypto.so.10 /opt/mssql/lib/libcrypto.so

# Configure firewall to allow TCP port 1433:
echo Configuring firewall-rules to allow traffic on port 1433...
sudo firewall-cmd --zone=public --add-port=1433/tcp --permanent
sudo firewall-cmd --reload

# Restart SQL Server after installing:
echo Restarting SQL Server...
sudo systemctl restart mssql-server
sudo systemctl status mssql-server --no-pager

echo Done!

### Changelog ###
#
#  20220624 [Eric]
#    - updated yum to dnf
#    - updated RHEL7/8 URLs to RHEL 9
#    - Removed python3 install and version setting as these are standard in RHEL9
