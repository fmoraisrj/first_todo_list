# encoding: UTF-8
require "spec_helper"

describe User do
  subject do
    User.new
  end

  xit "is vallid" do
    usu = subject
    usu.username = "Felipe"
    usu.password = "123"

    usu.should be_valid
  end

  xit "is invalid without username" do
    usu = subject
    usu.username = ""

    usu.should_not be_valid
  end

  xit "user inválido sem password" do
    usu = subject
    usu.password = ""

    usu.should_not be_valid
  end
end