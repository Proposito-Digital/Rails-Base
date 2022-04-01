require 'rails_helper'

describe Admin::TenantsController, type: :controller do
    let!(:tenant){ create :tenant  }
    let!(:tenant2){ create :tenant }
    let!(:user){ create :user_admin }

    before(:each) do
        sign_in user
    end

    describe "#change_current_tenant" do
      it "change the current_tenant" do
        patch :change_current_tenant, params: {id: tenant2.id}, session: {admin_tenant_id: tenant.id}
        expect(ActsAsTenant.current_tenant).to eq(tenant2)
        expect(flash["success"]).to eq "Tenant mudado com sucesso."
      end
    end

    describe "#disable_current_tenant" do
      it "removes tenant in session" do
        patch :disable_current_tenant, session: {admin_tenant_id: tenant.id}
        expect(@request.session[:admin_tenant_id]).to eq(nil)
        expect(flash["success"]).to eq "Tenant mudado com sucesso."
      end
    end

    describe "DELETE #destroy" do
        it "destroys the requested tenant" do
            tenant = create(:tenant)
          expect {
            delete :destroy, params: {id: tenant.to_param}
          }.to change(Tenant, :count).by(-1)
        end

        it "redirects to the tenants list" do
          delete :destroy, params: {id: tenant.to_param}
          expect(response).to redirect_to(admin_tenants_path())
        end
      end
end