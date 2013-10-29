class RemoveAllLists < Mongoid::Migration
  def self.up
    List.destroy_all
  end

  def self.down
  end
end