class CreateQueueItem < ActiveRecord::Migration
  def change
    create_table :queue_items do |t|
      t.references :user, index: true, foreign_key: true
      t.references :video, index: true, foreign_key: true
      t.integer :order_id
      t.timestamps
    end
  end
end
