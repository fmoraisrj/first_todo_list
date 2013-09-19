class Task
  include Mongoid::Document
  belongs_to :list
  field :status, type: Boolean
  field :body, type: String
  field :date, type: DateTime, default: Time.now
  field :order, type: Integer

  validates :list_id, :body, presence: true

  scope :all_sorted, -> { asc :order }
end
