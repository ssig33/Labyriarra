class Nick < ActiveRecord::Base
  self.table_name = :nick
  has_many :logs
end
