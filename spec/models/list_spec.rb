# encoding: UTF-8
require "spec_helper"

# describe User do
#   it "orders by last name" do
#     lindeman = User.create!(first_name: "Andy", last_name: "Lindeman")
#     chelimsky = User.create!(first_name: "David", last_name: "Chelimsky")
#     expect(User.ordered_by_last_name).to eq([chelimsky, lindeman])
#   end
# end

describe List do 
  subject do
    List.new
  end

  describe "validações" do
    describe "nome" do 
      it "não deveria salvar uma lista com nome menor que 3 caracteres" do
        subject.name_list = "fe"
        subject.should_not be_valid
        subject.should have(1).error_on(:name_list) 
      end

      #todo validar se o cara foi criado com todos os campos preenchidos certinhos
      it "deveria salvar uma lista" do
        subject.name_list = "felipe"
        
        subject.should be_valid
      end
    end
  end
end