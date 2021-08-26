#!/usr/bin/ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

#######################################################################

require 'yaml'

# Load configuration file
config_file = 'vagrantfiles/config.yaml'

if File.exists?(config_file)
  config = YAML.load_file(config_file)
  # p config.inspect
else
  puts "WARNING: Configuration file (#{config_file}) was NOT found!"
end

#######################################################################

fullHosts = ""
onlyCM = ""
onlyEN = ""
onlySN = ""

roles = config['nodes']

roles.each do |rol, nodes|
    nodes.each do |node|
      short_domain = ''

      if node['hostname'].index(".") != nil
        short_domain = node['hostname'][0..node['hostname'].index(".")-1]
      end

      line = "#{node['ip']}\t#{node['hostname']} #{short_domain}\n"

      if rol == "cm"
        onlyCM << line
      end

      if rol == "en"
        onlyEN << line
      end

      if rol == "sn"
        onlySN << line
      end

      fullHosts << line
    end
end

fullHosts = "\n<!-- BEGIN ANSIBLE MANAGED BLOCK -->\n" <<
            fullHosts <<
            "<!-- END ANSIBLE MANAGED BLOCK -->\n\n"

#######################################################################

hosts_file = "files/hosts"

## Central Manager

File.delete("files/hosts_cm") if File.exist?("files/hosts_cm")

File.write("files/hosts_cm", onlyCM, mode: "w")

## Execute Nodes

File.delete("files/hosts_en") if File.exist?("files/hosts_en")

File.write("files/hosts_en", onlyEN, mode: "w")

## Submit Nodes

File.delete("files/hosts_sn") if File.exist?("files/hosts_sn")

File.write("files/hosts_sn", onlySN, mode: "w")

## Full hosts

File.delete(hosts_file) if File.exist?(hosts_file)

File.write(hosts_file, fullHosts, mode: "a")

#######################################################################
