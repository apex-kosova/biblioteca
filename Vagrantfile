# Copyright © 2019 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
#
#    FILE NAME
#      vagrantfile
#
#    DESCRIPTION
#      Creates Oracle Application Express Vagrant virtual machines.
#
#    NOTES
#       DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#
#    AUTHOR
#       Simon Coter
#
#    MODIFIED   (MM/DD/YY)
#    scoter     03/04/19 - Creation
#
#    REVISION
#    20190304 - $Revision: 1.0 $
#
#

### -------------------------------------------------------------------
### Disclaimer:
###
### EXCEPT WHERE EXPRESSLY PROVIDED OTHERWISE, THE INFORMATION, SOFTWARE,
### PROVIDED ON AN \"AS IS\" AND \"AS AVAILABLE\" BASIS. ORACLE EXPRESSLY DISCLAIMS
### ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT
### LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
### PURPOSE AND NON-INFRINGEMENT. ORACLE MAKES NO WARRANTY THAT: (A) THE RESULTS
### THAT MAY BE OBTAINED FROM THE USE OF THE SOFTWARE WILL BE ACCURATE OR
### RELIABLE; OR (B) THE INFORMATION, OR OTHER MATERIAL OBTAINED WILL MEET YOUR
### EXPECTATIONS. ANY CONTENT, MATERIALS, INFORMATION OR SOFTWARE DOWNLOADED OR
### OTHERWISE OBTAINED IS DONE AT YOUR OWN DISCRETION AND RISK. ORACLE SHALL HAVE
### NO RESPONSIBILITY FOR ANY DAMAGE TO YOUR COMPUTER SYSTEM OR LOSS OF DATA THAT
### RESULTS FROM THE DOWNLOAD OF ANY CONTENT, MATERIALS, INFORMATION OR SOFTWARE.
###
### ORACLE RESERVES THE RIGHT TO MAKE CHANGES OR UPDATES TO THE SOFTWARE AT ANY
### TIME WITHOUT NOTICE.
###
### Limitation of Liability:
###
### IN NO EVENT SHALL ORACLE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
### SPECIAL OR CONSEQUENTIAL DAMAGES, OR DAMAGES FOR LOSS OF PROFITS, REVENUE,
### DATA OR USE, INCURRED BY YOU OR ANY THIRD PARTY, WHETHER IN AN ACTION IN
### CONTRACT OR TORT, ARISING FROM YOUR ACCESS TO, OR USE OF, THE SOFTWARE.
### -------------------------------------------------------------------
### This script is NOT supported by Oracle World Wide Technical Support.
### The script has been tested and appears to work as intended.

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# define hostname
NAME = "oracle-18c-apex"

unless Vagrant.has_plugin?("vagrant-reload")
  puts 'Installing vagrant-reload Plugin...'
  system('vagrant plugin install vagrant-reload')
end

unless Vagrant.has_plugin?("vagrant-proxyconf")
  puts 'Installing vagrant-proxyconf Plugin...'
  system('vagrant plugin install vagrant-proxyconf')
end

# get host time zone for setting VM time zone, if possible
# can override in env section below
offset_sec = Time.now.gmt_offset
if (offset_sec % (60 * 60)) == 0
  offset_hr = ((offset_sec / 60) / 60)
  timezone_suffix = offset_hr >= 0 ? "-#{offset_hr.to_s}" : "+#{(-offset_hr).to_s}"
  SYSTEM_TIMEZONE = 'Etc/GMT' + timezone_suffix
else
  # if host time zone isn't an integer hour offset, fall back to UTC
  SYSTEM_TIMEZONE = 'UTC'
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ol7-latest"
  config.vm.box_url = "https://yum.oracle.com/boxes/oraclelinux/latest/ol7-latest.box"
  config.vm.define NAME

  config.vm.box_check_update = false

  # change memory size
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.name = NAME
  end

  # add proxy configuration from host env - optional
  if Vagrant.has_plugin?("vagrant-proxyconf")
    puts "getting Proxy Configuration from Host..."
    if ENV["http_proxy"]
      puts "http_proxy: " + ENV["http_proxy"]
      config.proxy.http     = ENV["http_proxy"]
    end
    if ENV["https_proxy"]
      puts "https_proxy: " + ENV["https_proxy"]
      config.proxy.https    = ENV["https_proxy"]
    end
    if ENV["no_proxy"]
      config.proxy.no_proxy = ENV["no_proxy"]
    end
  end

  # VM hostname
  config.vm.hostname = NAME

  # Oracle port forwarding
  config.vm.network "forwarded_port", guest: 1521, host: 1521
  config.vm.network "forwarded_port", guest: 5500, host: 5500
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  # Provision and update Oracle Linux 7
  config.vm.provision "shell", path: "scripts/install.sh"

  # Provision Oracle Database on the first run
  config.vm.provision "shell", path: "scripts/database.sh", env:
    {
       "ORACLE_CHARACTERSET" => "AL32UTF8",
       "SYSTEM_TIMEZONE"     => SYSTEM_TIMEZONE,
       "ORACLE_PWD"          => "A%TrabInter%19"
    }

  # Provision Oracle Application Expresss on the first run
  config.vm.provision "shell", path: "scripts/apex.sh"
  # Provision Oracle Rest Data Services on the first run
  config.vm.provision "shell", path: "scripts/ords.sh"

end
