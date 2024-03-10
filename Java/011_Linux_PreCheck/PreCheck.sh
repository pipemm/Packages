#!/bin/bash

which -a pwd
pwd

which -a whoami
whoami --version
whoami --help
whoami

echo "${PATH}"

which -a bash
bash --version
bash --help
bash -c "help set"
bash -c help

which -a cat
cat --version
cat --help

which -a curl
curl --version
curl --help

which -a tee
tee --version
tee --help

which -a tar
tar --version
tar --help

which -a jq
jq --version
jq --help

