#!/usr/bin/env bash

if ! /bin/grep -q exclude=postgresql /etc/yum.repos.d/CentOS-Base.repo; then
    sed -i -r '1,/\[extras\]/ s/KEY-CentOS-6/KEY-CentOS-6\nexclude=postgresql*/' /etc/yum.repos.d/CentOS-Base.repo
    if ! [ -f /etc/yum.repos.d/pgdg-93-centos.repo ]; then
        rpm -ivh http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm
    fi
fi
yum install -y postgresql93-server
service postgresql-9.3 initdb
chkconfig postgresql-9.3 on
service postgresql-9.3 start
