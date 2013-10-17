# encoding: UTF-8

#spec/models/user_spec.rb
require "spec_helper"

describe User do
  subject do
    User.new
  end
  describe "validações" do
    before do
      subject.username = "Felipe"
      subject.password = "12345678"
      subject.email = "felipe@mtodolist.com"
    end

    describe " presence_of" do
      it "is vallid" do
        subject.should be_valid
      end

      it "is invalid without username" do
        subject.username = ""

        subject.should_not be_valid
      end

      it "user inválido sem password" do
        subject.password = ""
        
        subject.should_not be_valid
      end

      it "user inválido sem email" do
        subject.email = ""

        subject.should_not be_valid
      end
    end

    describe "uniqueness" do
      before do
        subject.save!
      end

      it "username deveria ser único" do
        user = User.new(username: "Felipe", password:  "abcdefghij", email:"any@g.com")

        expect{ user.save! }.to raise_error(Mongoid::Errors::Validations)
      end

      it "email deveria ser válido" do
        user = User.new(username: "Felipe", password: "abcdefghij", email: "felipe@mtodolist.com") 

        expect{ user.save! }.to raise_error(Mongoid::Errors::Validations)
      end
    end

    describe "attr_accessible" do

    end

  end
end