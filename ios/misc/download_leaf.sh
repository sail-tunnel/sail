#!/bin/sh

set -x

WD=`pwd`

curl -OL 'https://github.com/eycorsican/leaf/releases/latest/download/libleaf-ios.zip' \
       && mv libleaf-ios.zip /tmp/ \
       && unzip -o /tmp/libleaf-ios.zip -d /tmp \
       && mv /tmp/libleaf.a PacketTunnel/libleaf/ \
       && mv /tmp/leaf.h PacketTunnel/libleaf/
