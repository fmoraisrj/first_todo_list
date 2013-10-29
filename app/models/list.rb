class List 
  
  include Mongoid::Document
  
  field :name_list, type: String
  # field :old_name, type: String
  field :date, type: DateTime, default: Time.now
  field :order,    type: Integer
  has_many :tasks, autosave: true
  belongs_to :user 

  validates :name_list, length: { minimum: 3 } 
  
  scope :all_sorted, -> { asc :order }

  scope :tasks_sorteds, -> { tasks.asc :order }
end


