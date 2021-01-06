#!/bin/sh

set -x

WD=`pwd`

curl -OL 'https://github.com/v2ray/domain-list-community/releases/latest/download/dlc.dat' && mv dlc.dat PacketTunnel/site.dat
