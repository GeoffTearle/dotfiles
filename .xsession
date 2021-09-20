#!/bin/sh

. ~/.xprofile

# Services are started with systemd
systemctl --user import-environment
systemctl --user daemon-reload
exec systemctl --user start --wait i3.service
