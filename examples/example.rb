#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'ruby-nessus'

# Ruby-Nessus Example
#
# This proc is called by scan.each_host in each variation of Nessus::Parse
def print_info(host)
  puts host.ip
  puts host.hostname
  puts host.os_name
  puts host.runtime

  # puts host.mac_addr
  # puts host.event_percentage_for('icmp', true)
  # puts host.ports.inspect

  host.events.each do |event|
    puts "=> #{event.name}" if event.name
    # puts event.synopsis if event.synopsis
    # puts "\n"
    # puts event.output
    # puts "\n"
    # puts event.patch_publication_date&.strftime('%A %B %d, %Y %I:%M:%S %p')
    # puts event.see_also unless event.see_also.empty?
    # puts event.synopsis if event.synopsis
    # puts event.solution if event.solution
  end
end

# From a file:
puts '+ Using a Nessus XML file:'
RubyNessus::Parse.new('example_v1.nessus') do |scan|
  scan.hosts.each(&method(:print_info))
end

puts

# From a string:
puts '+ Using an XML string:'
RubyNessus::Parse.new(nil, xml: File.read('example_v1.nessus')) do |scan|
  scan.hosts.each(&method(:print_info))
end
