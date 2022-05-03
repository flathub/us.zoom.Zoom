#!/usr/bin/env bash

exec zypak-wrapper "$(readlink -f "$0")".real "$@"
