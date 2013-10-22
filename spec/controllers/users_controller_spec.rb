# encoding: UTF-8
require 'spec_helper'

describe UsersController do
  subject { User.create( username: "Felipe", email: "felipe@g.com", password: "12345678") }

  before :each do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET #new" do
    before do
      get :new
    end

    it "deveria retornar um novo User" do
      assigns(:user).should be_an_instance_of User
    end 

    it "deveria renderizar a tela de signup" do
      response.should render_template("new")
    end
  end

  describe "POST #create" do
    context "atributos válidos" do
      before do
        post :create, user: { username: "Felipee", email: "felipee@g.com", password: "12345678", encrypted_password: "2121212121" }
      end

      it "deveria ser um redirecionar para a home" do
        response.status.should == 302
      end

      it "deveria dar a mensagem flash de sucesso " do
        flash[:notice].should == "Welcome to mtodolist!"
      end

      it "O encrypted_password deveria ficar vazio" do
        assigns(:user).encrypted_password.should_not == "2121212121"
      end
    end

    context "atributos inválidos" do
      before do
        post :create, user: { email: "felipee@g.com", password: "12345678" }
      end

      it "O nome deveria ser nil" do
          assigns(:user).username.should == nil
      end

      it "deveria lançar uma flash.now de error" do
        flash[:erro].should == "We can't create yout user, please correct and try again."
      end

      it "deveria renderizar a página de singup" do
        response.should render_template "new"
      end
    end
  end
end