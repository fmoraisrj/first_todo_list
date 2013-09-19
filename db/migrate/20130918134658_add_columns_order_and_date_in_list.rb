class AddColumnsOrderAndDateInList < Mongoid::Migration
  def self.up
    List.all.each_with_index do |list, index|
      list.date = Time.now
      list.order = index
      list.save!
    end
  end

  def self.down
    List.all.each_with_index do |list, index|
      list.unset(:order)
      list.unset(:date)
    end
  end
end
