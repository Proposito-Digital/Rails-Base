# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:tenant){ create(:tenant)}

  let!(:valid_attributes) { attributes_for(:user)}

  let!(:invalid_attributes) {{ name: "" }}

  let!(:user_admin) { create :user_admin}
  
  let!(:users){ create_list :user, 12, tenant: tenant }

 
  before(:each) do
    sign_in user_admin
  end

  describe "#update password" do
    let!(:other_user) {create(:user)}

    let!(:new_password) {
      {
        id: users.sample.to_param, 
        password: "teste@1234", 
        password_confirmation: "teste@1234", 
        current_password: "teste@123" 
      }
    }

    let!(:new_incorrect_password) {
      {
        id: users.sample.to_param, 
        password: "teste@1234", 
        password_confirmation: "teste@1234", 
        current_password: "asdsadasdasdad" 
      }
    }

    let!(:other_user_new_password) {
      {
        password: "teste@1234", 
        password_confirmation: "teste@1234", 
        current_password: "teste@123" 
      }
    }

    let!(:other_user_new_incorrect_password) {
      {
        password: "teste@1234", 
        password_confirmation: "teste@1234", 
        current_password: "asdsadasdasdad" 
      }
    }

    it "user try update your password with a correct current_password" do  
      request.env["HTTP_REFERER"] = "index"  
      patch :update_password, params: {user: new_password }
      expect(flash["success"]).to eq "Senha alterada com sucesso"
    end

    it "user try update password with a incorrect current_password" do
      request.env["HTTP_REFERER"] = "index"  
      patch :update_password, params: {user: new_incorrect_password }
      expect(flash["danger"]).to eq "Erro ao editar senha"
    end

    it "user can't update all passwords" do
      request.env["HTTP_REFERER"] = "index"  
      users.sample.admin!
      user2 = create(:user, tenant: tenant)
      other_user_new_incorrect_password['id'] = user2.to_param
      patch :update_all_passwords, params: {user: other_user_new_incorrect_password }
      expect(flash["danger"]).to eq "Erro ao editar senha"
    end
    
    it "user can update all passwords" do  
      request.env["HTTP_REFERER"] = "index"  
      users.sample.admin!
      user2 = create(:user, tenant: tenant)
      other_user_new_password['id'] = user2.to_param
      patch :update_all_passwords, params: {user: other_user_new_password }
      expect(flash["success"]).to eq "Senha alterada com sucesso"
    end

  end

  describe "GET #index" do
    it "assigns all users as @instances" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @instance" do
      get :show, params: {id: users.sample.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "assigns a new user as @instance" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "assigns the requested user as @instance" do
      get :edit, params: {id: users.sample.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "redirects to the list of user" do
        post :create, params: {user: valid_attributes}
        expect(response).to redirect_to(admin_users_path)
      end
    end

    context "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, params: {user: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    let!(:user_to_update) { users.sample}
    context "with valid params" do
      let!(:new_attributes) {
          {name: "john doe"}
      }
      it "updates the requested user" do
        put :update, params: {id: user_to_update.to_param, user: new_attributes}
        user_to_update.reload
        expect(user_to_update.name).to eq "john doe"
      end

      it "redirects to the user" do
        put :update, params: {id: user_to_update.to_param, user: valid_attributes}
        expect(response).to redirect_to(admin_user_path(user_to_update))
      end
    end

    context "with invalid params" do
      it "re-renders the 'edit' template" do
        put :update, params: {id: user_to_update.to_param, user: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      expect {
        delete :destroy, params: {id: users.sample.to_param}
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, params: {id: users.sample.to_param}
      expect(response).to redirect_to(admin_users_path)
    end
  end
end
