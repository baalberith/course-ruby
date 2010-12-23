require 'drb'

class LogServer
  def save(str)
    fn = Time.new.to_s
    open(fn, 'w') { |f| f << str }
  end
  
  def self.run
    @@server = Server.new
    DRb.start service('druby://localhost:9000', @@server)
    DRb.thread.join
  end
end
