require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
    let!(:tenant){
        create(:tenant) 
    }
    let!(:user){
        create(:user, tenant: tenant)
    }
    before(:each) do
        sign_in user
    end
    describe "before_action" do
        describe "set_tenant" do
            let!(:tenants){create_list :tenant, 5}
            before(:each) do
                expect(ActsAsTenant.current_tenant.present?).to eq(false) 
            end
            describe "authenticate_user_tenant" do
                describe "with same tenant" do
                    it "do not raises error" do
                        expect { get :index }.not_to raise_error()
                    end
                end
            end
        end
    end
end