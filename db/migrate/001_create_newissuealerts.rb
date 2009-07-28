class CreateNewissuealerts < ActiveRecord::Migration
  def self.up
    create_table :newissuealerts do |t|
      t.column :project_id, :integer
      t.column :mail_addresses, :string
      t.column :enabled, :boolean
    end
  end

  def self.down
    drop_table :newissuealerts
  end
end
