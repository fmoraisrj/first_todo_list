class Task
  include Mongoid::Document
  belongs_to :list
  field :status, type: Boolean
  field :body, type: String

  validates :list_id, presence: true
end
