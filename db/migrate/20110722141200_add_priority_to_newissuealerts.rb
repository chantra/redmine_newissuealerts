class AddPriorityToNewissuealerts < ActiveRecord::Migration
  def self.up
    add_column :newissuealerts, :priority, :boolean, :default => 0
  end

  def self.down
    remove_column :newissuealerts, :priority
  end
end
