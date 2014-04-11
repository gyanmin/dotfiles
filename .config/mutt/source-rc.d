#!/bin/sh -e

for rc in $HOME/.mutt/rc.d/*.rc; do
  test -r "$rc" && echo "source \"$rc\""
done

# vi: ft=sh
