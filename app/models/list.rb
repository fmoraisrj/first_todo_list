class List
  include Mongoid::Document
  field :name_list, type: String
  field :item1, type: String
  field :item2, type: String
  field :item3, type: String
end
