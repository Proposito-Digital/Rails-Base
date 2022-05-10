require 'rails_helper'

RSpec.describe IconsHelper, type: :helper do
  describe "#menu_active?" do
    let!(:item){
      {
        name: 'Usuários',
        icon: 'bi bi-person',
        policy: :user,
        url: { controller: 'users', action: 'index' },
        active: controller_path == 'admin/users'
      }
    }
    context "not active" do
      before :each do
        allow(controller).to receive(:controller_name){ 'tenants' }
        allow(controller).to receive(:action_name){ 'index' }
      end
      it "returns nil(text = true or false)" do
        expect(helper.menu_active?(item, true)).to eq nil
        expect(helper.menu_active?(item, false)).to eq nil
      end
    end
    context "active" do
      before :each do
        allow(controller).to receive(:controller_name){ 'users' }
        allow(controller).to receive(:action_name){ 'index' }
      end
      context "text = false" do
        it "returns true" do
          expect(helper.menu_active?(item, false)).to eq true
        end
      end
      context "text = true" do
        it "returns active" do
          expect(helper.menu_active?(item, true)).to eq 'active'
        end
      end
    end
  end
end