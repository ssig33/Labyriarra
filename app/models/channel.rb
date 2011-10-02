class Channel < ActiveRecord::Base
  set_table_name :channel
  has_many :logs

  def self.list
    Channel.all.map{|x| [x,x.logs.order("id desc").first]}.sort{|a,b| a.last.created_at.to_i <=> b.last.created_at.to_i}.map{|x| x.first}.reverse
  end

  def log last_id
    id = last_id.to_i rescue 0
    if id == 0
      self.logs.order("id desc").limit(35).includes(:nick)
    else
      self.logs.where("id > ?", id).order("id desc").limit(35).includes(:nick)
    end
  end
end
