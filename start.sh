#!/bin/bash
echo "o Starting KVM"
echo "o Started KVM, Default Password is $INSTANCE_ID"
export PS1="\u@$INSTANCE_ID~$ "
cd /app/data
exec bash --norc --noprofile
