class User 
  
  include Mongoid::Document
  
  field :username, type: String
  field :password, type: String
  field :email,    type: String
  field :order,    type: Integer

   validates_presence_of :username, :password
end


