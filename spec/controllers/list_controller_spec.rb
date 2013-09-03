
require "spec_helper"

describe ListController do   
  #let é usado para me criar uma espcécie de variável que executará o que está
  #lá dentro uma vez e guarda pra sempre naquele alias(variável)
  let! :my_list do
    List.create(name_list: "eede")
  end

  let(:id) { "1" }

  let! :new_list do
    List.new {name_list:"my_new_list", item1: "my_item1", item2: "my_item2", item3: "my_item3"}
  end

  let(:wrong_id) { "a23b" }

  before do
    new_list.id = id
    List.stub(:find).and_return(new_list) 
  end

  describe "GET #index" do
    it "deveria criar uma lista" do
      # O get funciona parecido com o send onde o parametro passado
      #execeuta  o método(action) indicado no simbôlo
      get :index
      # O assigns pega a variável indicada no parâmetro da classe do teste.
      assigns(:lists).should == [my_list]
    end

    it "deveria renderizar a lista de lists" do
      get :index
      response.should render_template("index")
    end
  end

  describe "GET #new" do 
    it "deveria criar uma lista nova" do
      get :new
      assigns(:list).should be_new_record
    end

    it "deveria renderizar a tela de criar uma lista nova" do
      get :new
      response.should render_template("new")
    end
  end

  describe "GET #create" do 
    it "deveria salvar uma lista nova" do
      get :create
      assigns(:list).should be_new_record
    end

    it "deveria redirecionar para a tela de criar uma lista nova" do
      get :new
      response.should render_template("new")
    end
  end

  describe "GET #edit" do 
    let(:list_id) { "3" }

    let :list do
      List.new(id: list_id, name_list: "list")
    end

    it "deveria editar uma lista " do
      List.should_receive(:find).with(list_id).and_return(list)
      get :edit, id: list_id
      assigns(:list).should eql list
    end

    #Todo it para enviar id falso para gerar 404

    it "deveria renderizar a tela de criar uma lista nova" do
      get :edit, id:list_id
      response.should render_template("edit")
    end
  end

  #como fazer o teste de destroy para id errado?
  describe "DELETE #destroy" do
    #let inline é legal ser usado sempre que for algo simples e pequeno
    let(:lista) { double("Lista", id: id, destroy: true) }
    
    #o bloco before é executado antes de qualquer coisas dentro do describe que ele pertence
    #before do
      #List.stub(:find).and_return(lista)
    #end

    it "deveria lançar um 'status 302'" do # porque ele encontrou a rota para qual foi redirecionado
      delete :destroy, id: wrong_id
      response.status.should eql 302 #404
    end
    #Todo it para enviar id falso para gerar exceção

    it "deveria apagar a lista" do
      #Um Stub foi utilizando aqui para o método find() pois ele não é o principal nesse teste
      List.stub(:find).and_return(lista)
      #Isso é um Mock para verificar se a lista.destroy se comportou como deveria
      lista.should_receive(:destroy)
      delete :destroy, id: id
    end

    it "deveria redirecionar para a tela com a lista" do
      List.stub(:find).and_return(lista)
      delete :destroy, id: id
      response.should redirect_to(list_index_path)
    end
  end


  describe "GET #show" do
    it "deveria mostrar a lista indicada" do
      get :show, id: new_list.id
      assigns(:list).should eql(new_list)
    end

    it "deveria renderizar :show template" do
      get :show, id: new_list.id
      response.status.should be == 200
      response.should render_template(:show)
    end

    it "deveria redirecionar para uma tela de lista de todo lists " do
     List.unstub(:find)
     get :show, id: wrong_id
     response.status.should be == 302
     #response.should redirect_to list_index_path
   end
 end

 describe "PUT #update"do

 context "valid attributes" do 
  it "located the requested @contact" do 
    put :update, id: @contact, contact: Factory.attributes_for(:contact) 
    assigns(:contact).should eq(@contact) 
  end 

  it "changes @contact's attributes" do 
    put :update, id: @contact, contact: Factory.attributes_for(:contact, firstname: "Larry", lastname: "Smith") 
    @contact.reload 
    @contact.firstname.should eq("Larry") 
    @contact.lastname.should eq("Smith") 
  end

  it "redirects to the updated contact" do 
    put :update, id: @contact, contact: Factory.attributes_for(:contact) 
    response.should redirect_to @contact 
  end
end

  it "deveria atualizar a lista indicada" do
    put :update, id: new_list.id
    assigns(:list).should eql(new_list)
  end

  it "deveria renderizar :edit(update) template" do
    put :update, id: new_list.id
    response.status.should be == 200
    response.should render_template(:edit)
  end
end

end