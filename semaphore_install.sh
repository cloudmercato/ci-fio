#!/bin/bash

if [[ "$SEMAPHORE_AGENT_MACHINE_OS_IMAGE" == "ubuntu"* ]] ; then
    ./linux_install.sh
elif [[ "$SEMAPHORE_AGENT_MACHINE_OS_IMAGE" == "macos"* ]] ; then
    ./macos_install.sh
fi
