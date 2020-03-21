#!/bin/bash

if [[ ! -d ~/.virtualenvs/py3nvim ]]; then
	virtualenv -p $(which python3) ~/.virtualenvs/py3nvim
	~/.virtualenvs/py3nvim/bin/pip install pynvim
fi

if [[ ! -d ~/.virtualenvs/pynvim ]]; then
	virtualenv -p $(which python2) ~/.virtualenvs/pynvim
	~/.virtualenvs/pynvim/bin/pip install pynvim
fi


