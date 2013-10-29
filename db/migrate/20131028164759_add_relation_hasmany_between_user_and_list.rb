class AddRelationHasmanyBetweenUserAndList < Mongoid::Migration
  def self.up
    List.all.each_with_index do |list, index|
      list.user_id = nil
      list.save!
    end
  end

  def self.down
    List.all.each_with_index do |list, index|
      list.unset(:user_id)
    end 
  end
end