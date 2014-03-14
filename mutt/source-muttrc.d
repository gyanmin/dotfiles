#!/bin/sh

for rc in muttrc.d/*.rc; do
  test -r "$rc" && echo "source \"$rc\""
done
