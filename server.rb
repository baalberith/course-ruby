#!/usr/bin/env ruby

require 'yaml'
require 'drb'
require 'dbm'

# zadanie 1

class Logger
  def initialize(file = 'logger.dbm')
    if File.exist?(file)
      @db = DBM.open(file) 
    else
      @db = DBM.new(file)
    end
  end
  
  def save(prg_id, msg)
    logs = YAML.load( @db[prg_id.to_s] )
    logs[Time.new] = msg
    @db[prg_id.to_s] = YAML.dump( logs )
  end
  
  def raport(from, to, prg_id, reg_exp)
    logs = YAML.load( @db[prg_id.to_s] )
    logs = logs.select do |time, msg|
      time >= from && time <= to && msg =~ reg_exp
    end
    
    html = "<html><body>"
    html += "<p> Raport for: #{prg_id} </p>"
    html += "<p> form: #{from.to_s} to: #{to.to_s} </p>"
    
    html += "<ul>"
    logs.each do |time, msg|
      html += "<li> #{time.to_s}: #{msg} </li>"
    end
    html += "</li>"
    
    html += "</body></html>"
  end
  
  def close
    @db.close
  end
end

DRb.start_service 'druby://:9000', Logger.new
puts "Server running at #{DRb.uri}"

trap("INT") { DRb.stop_service }
DRb.thread.join
