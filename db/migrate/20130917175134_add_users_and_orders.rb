class AddUsersAndOrders < Mongoid::Migration
  def self.up
    # List.all.each_with_index do |list, index|
    # person.add_to_set(:aliases, "Bond")
    # list.add_to_set(:)
    # list.order = index

    # List.all.each_with_index do |list, index|
    #   list.old_name = list.name_list
    #   list.name_list = "List #{index + 1}"
    #   list.save
    # end
  end

  def self.down
    # List.all.each do |list|
    #   list.name_list = list.old_name
    #   list.unset(:old_name)
    #   list.save
    # end
  end
end