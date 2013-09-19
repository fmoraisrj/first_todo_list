class User 
  
  include Mongoid::Document
  
  field :username, type: String
  field :password, type: String
  field :email,    type: String
  
  validates_presence_of :username, :password
end


