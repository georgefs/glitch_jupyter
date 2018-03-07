#!/bin/bash
# initialize script

# Exit early on errors
set -eu

# Python buffers stdout. Without this, you won't see what you "print" in the Activity Logs
export PYTHONUNBUFFERED=true

# Install Python 3 virtual env
VIRTUALENV=.data/venv

if [ ! -d $VIRTUALENV ]; then
  python3 -m venv $VIRTUALENV
fi

if [ ! -f $VIRTUALENV/bin/pip ]; then
  curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | $VIRTUALENV/bin/python
fi

export PATH=$VIRTUALENV/bin:$PATH

# Install the requirements
pip3 install -r requirements.txt

jupyter notebook --port=8000 --ip=0.0.0.0 --no-browser --notebook-dir=notebook
