class Log < ActiveRecord::Base
  self.table_name = :log
  belongs_to :nick
  belongs_to :channel

  def html
    str = CGI.escapeHTML self.log.to_s.dup
    str.gsub!(/\u0003([0-9][0-9]*)(.*?)\u0003/, "<span class='irc_color_\\1'>\\2</span>")
    str.gsub!(/\u0003([0-9][0-9]*)(.*?)$/, "<span class='irc_color_\\1'>\\2</span>")
    URI.extract(str.dup, %w[http https ftp]){|uri|str.gsub!(uri, %Q{<a href="#{uri}" target="_blank">#{uri}</a>})}
    "<span class='nick'>#{self.nick.name}:</span> #{str}"
  end
end
