require 'spec_helper'

describe UsersController do
  subject { User.create(id: 1, username: "Felipe", email: "felipe@g.com") }

  describe "GET 'show'" do
    xit "returns http success" do
      get :show

      response.should be_success
    end

    it "should return an user" do
      get :show, id: 1

      @user.id.should == 1
    end
  end
end