class Nick < ActiveRecord::Base
  set_table_name :nick
  has_many :logs
end
