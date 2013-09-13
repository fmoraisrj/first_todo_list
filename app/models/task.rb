class Task
  include Mongoid::Document
  belongs_to :list
  field :status, type: Boolean
  field :body, type: String
  field :date, type: DateTime
  field :order, type: Integer

  validates :list_id, presence: true
end
