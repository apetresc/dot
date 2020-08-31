#!/bin/sh -ex

emerge -y --sync
emerge --update --deep --with-bdeps=y --newuse @world
emerge --depclean
