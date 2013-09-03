class Item
  include Mongoid::Document
  belongs_to :list
  field :status, type: Boolean
  field :body, type: String
end
