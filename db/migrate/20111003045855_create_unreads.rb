class CreateUnreads < ActiveRecord::Migration
  def change
    create_table :unreads do |t|
      t.integer :channel_id
      t.integer :log_id
      t.timestamps
    end
    add_index :unreads, :channel_id, {unique: true}
  end
end
