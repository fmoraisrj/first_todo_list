class AddColumnsOrderAndDateInTask < Mongoid::Migration
  def self.up
    List.all.each_with_index do |list, index|
      list.tasks.each_with_index do |task, index|
        task.date  = Time.now 
        task.order = index
      end
      list.save!
    end
  end

  def self.down
    List.all.each_with_index do |list, index|
      list.tasks.each_with_index do |task, index|
        task.unset(:date)
        task.unset(:order)
      end
    end
  end
end