require "rails_helper"

<% module_namespacing do -%>
RSpec.xdescribe Admin::<%= controller_class_name %>Controller, type: :routing do
  describe "routing" do

<% unless options[:singleton] -%>
    it "routes to #index" do
      expect(:get => "/admin/<%= table_name %>").to route_to("admin/<%= table_name %>#index")
    end

<% end -%>
    it "routes to #new" do
      expect(:get => "/admin/<%= table_name %>/new").to route_to("admin/<%= table_name %>#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/<%= table_name %>/1").to route_to("admin/<%= table_name %>#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/<%= table_name %>/1/edit").to route_to("admin/<%= table_name %>#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/<%= table_name %>").to route_to("admin/<%= table_name %>#create")
    end

    it "routes to #update" do
      expect(:put => "/admin/<%= table_name %>/1").to route_to("admin/<%= table_name %>#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/<%= table_name %>/1").to route_to("admin/<%= table_name %>#destroy", :id => "1")
    end

  end
end
<% end -%>