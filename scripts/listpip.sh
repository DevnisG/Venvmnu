#!/bin/bash

function list_pip_packages() {
  echo "$MSG_PIP_LIST"
  python -m pip list
  pause
}