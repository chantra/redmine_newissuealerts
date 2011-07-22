class AlterNewissuealertsSetDefaults < ActiveRecord::Migration
  def self.up
    change_column_default(:newissuealerts, :enabled, 0)
  end

  def self.down
    change_column_default(:newissuealerts, :enabled, nil)
  end
end
