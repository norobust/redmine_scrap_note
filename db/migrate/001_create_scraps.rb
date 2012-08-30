class CreateScraps < ActiveRecord::Migration
  def self.up
    create_table :scraps do |t|
      t.column :journal_id, :integer
      t.column :note, :text
    end
  end

  def self.down
    drop_table :scraps
  end
end
