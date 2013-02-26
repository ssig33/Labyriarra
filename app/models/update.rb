class Update
  require "socket"
  attr_accessor :path
  def initialize args
    self.path = args[:path]
  end
  def post name, txt
    RestClient.post(CONFIG['Endpoint'], q: ['PRIVMSG', name, txt].to_json)
  end
end
