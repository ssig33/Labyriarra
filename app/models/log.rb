class Log < ActiveRecord::Base
  set_table_name :log
  belongs_to :nick
  belongs_to :channel

  def html
    str = CGI.escapeHTML self.log.dup
    str.gsub!(/\u0003([0-9][0-9]*)/, "<span class='irc_color_\\1'>")
    URI.extract(str.dup, %w[http https ftp]){|uri|str.gsub!(uri, %Q{<a href="#{uri}" target="_blank">#{uri}</a>})}
    count = str.scan(/<\span|<span/).size
    str += "</span>" if count % 2 == 1
    "<span class='nick'>#{self.nick.name}:</span> #{str}"
  end
end
