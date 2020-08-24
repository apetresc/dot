#!/bin/sh -ex

emerge --sync
emerge --update --deep --with-bdeps=y --newuse @world
emerge --depclean
