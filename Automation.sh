#! bin/bash

#updating packages
sudo apt update -y



#initializing variables

myname ='mary'
s3_bucket='upgrad-mary'
timestamp = $(date '+%d%m%Y-%H%M%S')



#installing apache2
if [ $dpkg --list |grep apache2 == 'apache2' ]
then
        systemctl enable apache2
        systemctl start apache2
else
        apt-get install apache2
fi

#creatng temp directory

tar -zvcf /tmp/${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/*.log


#uploading to s3 bucket

if [ $(dpkg --list | grep awscli) == 'awscli']
then
                aws s3\ cp /tmp/${myname}-httpd-logs-${timestamp}.tar \ s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
        else
                apt install awscli
                aws s3\ cp /tmp/${myname}-httpd-logs-${timestamp}.tar \ s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
        fi

