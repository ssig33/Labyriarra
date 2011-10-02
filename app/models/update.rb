class Update
  require "socket"
  attr_accessor :path
  def initialize args
    self.path = args[:path]
  end
  def post name, txt
    c =UNIXSocket.open(self.path)
    log = Log.new
    log.created_at = Time.now+9*60*60
    log.updated_at = Time.now+9*60*60
    log.log = txt
    log.nick_id = Nick.find_or_create_by_name(CONFIG["Nick"]).id
    log.channel_id = Channel.find_or_create_by_name(name).id
    log.save
    c.write "NOTIFY System::SendMessage TIARRACONTROL/1.0\r\nSender: Debu\r\nNotice: no\r\nChannel: #{name}\r\nCharset: utf-8\r\nText: #{txt}\r\n\r\n"
  end
end
