#!/bin/bash

sudo -s /usr/share/elasticsearch/bin/elasticsearch-reconfigure-node --enrollment-token "$(< /etc/elasticsearch/enroll-token.txt)" 