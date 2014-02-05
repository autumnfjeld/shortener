class AddVisits < ActiveRecord::Migration
  def change
    add_column :url_pairs, :visits, :integer, default: 0
  end
end
