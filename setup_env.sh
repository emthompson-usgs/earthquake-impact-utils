#!/bin/bash

VENV=impact
PYVER=3.5

DEPARRAY=(numpy matplotlib cartopy pandas fiona shapely pytest pytest-cov pytest-mpl jupyter pycrypto paramiko beautifulsoup4)


#turn off whatever other virtual environment user might be in
source deactivate
    
#remove any previous virtual environments called pager
conda remove --name $VENV --all -y
    
#create a new virtual environment called $VENV with the below list of dependencies installed into it
conda create --name $VENV --yes --channel conda-forge python=3.5 ${DEPARRAY[*]} -y

#activate the new environment
source activate $VENV

#install some items separately
conda install -y psutil

#do pip installs of those things that are not available via conda.
pip install flake8
pip install pep8-naming

curl --max-time 60 --retry 3 -L https://github.com/gem/oq-engine/archive/master.zip -o openquake.zip
pip -v install --no-deps openquake.zip
rm openquake.zip

#tell the user they have to activate this environment
echo "Type 'source activate ${VENV}' to use this new virtual environment."
