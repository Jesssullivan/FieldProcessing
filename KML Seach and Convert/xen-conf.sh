#!/bin/bash
#apt-get update
#
#adduser <you>
#
#nano /etc/apt/sources.list
#
#enter as a new line at the bottom of the doc:
#
#deb https://cloud.r-project.org/bin/linux/ubuntu xenial/
#deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/
# exit nano
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
apt-get install r-base
apt-get install r-base-dev
sudo apt-get install libgdal1-dev libproj-dev
apt-get update
apt-get upgrade
wget http://download.osgeo.org/gdal/2.3.1/gdal-2.3.1.tar.gz
tar xvf gdal-2.3.1.tar.gz
cd  gdal-2.3.1
./configure
sudo make
sudo make install
cd
apt-get update
apt-get upgrade
sudo apt-get update
sudo apt-get install r-base
sudo apt-get install r-base-dev
sudo apt-get install gdebi-core
wget https://download2.rstudio.org/rstudio-server-1.1.456-amd64.deb
sudo gdebi rstudio-server-1.1.456-amd64.deb
sudo su - \
-c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
sudo $ apt-get install gdebi-core
wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.7.907-amd64.deb
sudo gdebi shiny-server-1.5.7.907-amd64.deb
R
install.packages(“rgdal”)
install.packages(“dplyr”)
