class ChangeMyQueue < ActiveRecord::Migration
  def change
    rename_column :queue_items, :order_id, :position
  end
end
