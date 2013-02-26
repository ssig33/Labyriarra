class Channel < ActiveRecord::Base
  set_table_name :channel
  has_many :logs
  has_one :unread

  def self.next_unread
    r = nil
    Channel.all.reverse.each{|c| r = c; break if c.unread?}
    r
  end

  def self.list
    list = Channel.includes(:unread).map{|x|[x,x.logs.order("id desc").first]}.sort{|a,b| a.last.created_at.to_i <=> b.last.created_at.to_i}.reverse.map{|x| x.first}
    unreads = []
    Unread.where(channel_id: list.map{|x| x.id}).each{|x| unreads << x.channel_id}
    (list.map{|x| x.id} - unreads).each{|x| Unread.create channel_id: x}
    list
  end

  def log last_id
    id = last_id.to_i rescue 0
    if id == 0
      list = self.logs.order("id desc").limit(35).includes(:nick)
    else
      list = self.logs.where("id > ?", id).order("id desc").limit(35).includes(:nick)
    end
    if list.size > 0
      u= Unread.find_or_create_by_channel_id(self.id)
      u.log_id = list.first.id
      u.save
    end
    list
  end

  def unread?
    if self.unread.log_id
      count = self.logs.where("id > ?", self.unread.log_id).count
      if count == 0
        false
      else
        count
      end
    else
      self.logs.count
    end
  rescue
    false
  end

  def unread_count
    self.logs.where("id > ?", self.unread.log_id).count rescue 0
  end
end
