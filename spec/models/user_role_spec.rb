require 'rails_helper'

RSpec.describe UserRole, type: :model do
	it { should belong_to(:user) }

  describe "class methods" do 
    describe "create_regular" do
      let!(:user) { create :user}
      before(:each) do 
        user.update(current_role: nil)
        user.roles.delete_all
        expect(user.roles.regular.count).to eq 0
      end
      it "creates new regular UserRole" do 
        expect{UserRole.create_regular user: user}.to change(user.roles.regular, :count).by 1
      end
    end
    describe "create_admin" do
      let!(:user) { create :user}
      before(:each) do 
        expect(user.roles.admin.count).to eq 0
      end
      it "creates new admin UserRole" do 
        expect{UserRole.create_admin user: user}.to change(user.roles.admin, :count).by 1
      end
    end
    describe "new_regular" do
      let!(:user) { create :user}
      it "new role" do
        role = UserRole.new_regular(user: user)
        expect(role.user.id).to eq user.id
        expect(role.role).to eq "regular"
      end
    end
    describe "new_admin" do
      let!(:user) { create :user}
      it "new role" do
        role = UserRole.new_admin(user: user)
        expect(role.user.id).to eq user.id
        expect(role.role).to eq "admin"
      end
    end
  end
end
