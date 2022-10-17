#!/usr/bin/env sh

sudo nsenter -t1 -m -u -n -i /bin/bash || sudo nsenter -t1 -m -u -n -i /bin/sh
