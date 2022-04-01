require "rails_helper"

RSpec.describe Admin::TenantsController, type: :routing do
  describe "routing" do
    let!(:tenant) { create(:tenant) }
    it "routes to #index" do
      expect(get: "admin/tenants").to route_to("admin/tenants#index")
    end

    it "routes to #new" do
      expect(get: "admin/tenants/new").to route_to("admin/tenants#new")
    end

    it "routes to #show" do
      expect(get: "admin/tenants/#{tenant.id}").to route_to("admin/tenants#show", id: tenant.id.to_s)
    end

    it "routes to #edit" do
      expect(get: "admin/tenants/#{tenant.id}/edit").to route_to("admin/tenants#edit", id: tenant.id.to_s)
    end

    it "routes to #create" do
      expect(post: "admin/tenants").to route_to("admin/tenants#create")
    end

    it "routes to #update via PUT" do
      expect(put: "admin/tenants/#{tenant.id}").to route_to("admin/tenants#update", id: tenant.id.to_s)
    end

    it "routes to #update via PATCH" do
      expect(patch: "admin/tenants/#{tenant.id}").to route_to("admin/tenants#update", id: tenant.id.to_s)
    end

    it "routes to #destroy" do
      expect(delete: "admin/tenants/#{tenant.id}").to route_to("admin/tenants#destroy", id: tenant.id.to_s)
    end

  end
end
