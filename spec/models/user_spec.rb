# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do

	subject(:user) { create(:user)}

	it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :email }
	it { is_expected.to validate_presence_of :password }


	it "#access_token_expired check if 2 hours of access token expiration when set 3 hours " do		
		subject.token_expiration_time = DateTime.now.in_time_zone - 3.hours
		expect(subject.access_token_expired?).to be 
	end

	it "#access_token_expired check 2 hours of access token expiration when set 1 hour" do
		subject.token_expiration_time = DateTime.now.in_time_zone - 1.hours
		expect(subject.access_token_expired?).not_to be 
	end

	describe 'before_validation' do 
		describe 'on create' do 
			describe'set_new_tenant' do
				it 'when tenant_id is present' do
					tenant_id = subject.tenant_id
					subject.send(:set_new_tenant)
					expect(subject.tenant_id).to eq(tenant_id)
				end
				it 'when tenant_id is not present' do
					expect{subject.send(:set_new_tenant)}.to change(Tenant, :count).by(1)
					expect(subject.tenant_id).to eq(Tenant.last.id)
				end
			end
		end
	end

	describe "role" do
		it "returns current role" do
			expect(subject.role).to eq subject.current_role
		end
	end

	describe "any_role_is?" do
    context "with existent role" do
      it "returns true" do
        role = UserRole.roles.keys.sample
        UserRole.create(user: subject, role: role.to_sym)
        expect(subject.send('any_role_is?', role)).to eq true
      end
    end
    context "with inexistent role" do
      before(:each) do
        subject.update(current_role: nil)
        subject.roles.delete_all
      end
      it "returns false" do
        role_to_find = UserRole.roles.keys.sample
        UserRole.roles.keys.excluding(role_to_find).each do |role|
          UserRole.create(user: subject, role: role.to_sym)
        end
        expect(subject.send('any_role_is?', role_to_find)).to eq false
      end
    end
	end
  describe "any_role_is_admin?" do
    context "with role" do
      it "returns true" do
        subject.admin!
        expect(subject.any_role_is_admin?).to eq true
      end
    end
    context "without role" do
      it "returns false" do
        subject.regular!
        expect(subject.any_role_is_admin?).to eq false
      end
    end
  end
  describe "any_role_is_regular?" do
    before(:each) do
      subject.update(current_role: nil)
      subject.roles.delete_all
    end
    context "with role" do
      it "returns true" do
        subject.regular!
        expect(subject.any_role_is_regular?).to eq true
      end
    end
    context "without role" do
      it "returns false" do
        subject.admin!
        expect(subject.any_role_is_regular?).to eq false
      end
    end
  end
  describe "admin!" do
    context "without any role as admin" do
      before(:each) do
        expect(subject.any_role_is_admin?).to eq false
        expect(subject.admin?).to eq false
        expect(subject.roles.admin.count).to eq 0
        subject.admin!
      end
      it "creates new user_role" do
        expect(subject.roles.admin.count).to eq 1
      end
      it "set current role to admin" do 
        expect(subject.admin?).to eq true
      end
    end
    context "with any role as admin" do
      before(:each) do
        UserRole.create_admin user: subject
        expect(subject.any_role_is_admin?).to eq true
        expect(subject.admin?).to eq false
        expect(subject.roles.admin.count).to eq 1
        subject.admin!
      end
      it "creates new user_role" do
        expect(subject.roles.admin.count).to eq 1
      end
      it "set current role to admin" do
        expect(subject.admin?).to eq true
      end
    end
  end
  describe "regular!" do
    before(:each) do
      subject.update current_role: nil
      subject.roles.delete_all
    end
    context "without any role as regular" do
      before(:each) do
        expect(subject.any_role_is_regular?).to eq false
        expect(subject.regular?).to eq false
        expect(subject.roles.regular.count).to eq 0
        subject.regular!
      end
      it "creates new user_role" do
        expect(subject.roles.regular.count).to eq 1
      end
      it "set current role to regular" do 
        expect(subject.regular?).to eq true
      end
    end
    context "with any role as regular" do
      before(:each) do
        UserRole.create_regular user: subject
        expect(subject.any_role_is_regular?).to eq true
        expect(subject.regular?).to eq false
        expect(subject.roles.regular.count).to eq 1
        subject.regular!
      end
      it "creates new user_role" do
        expect(subject.roles.regular.count).to eq 1
      end
      it "set current role to regular" do
        expect(subject.regular?).to eq true
      end
    end
  end

  describe "admin?" do
    before(:each) do 
      subject.regular!
      subject.admin!
      expect(subject.any_role_is_admin?).to eq true
      expect(subject.any_role_is_regular?).to eq true
    end
    it "return true if current_role is admin" do
      subject.admin!
      expect(subject.current_role.admin?).to eq true
      expect(subject.admin?).to eq true
    end
    it "return false if current_role is not admin" do
      subject.regular!
      expect(subject.current_role.admin?).to eq false
      expect(subject.admin?).to eq false
    end
  end

  describe "regular?" do
    before(:each) do 
      subject.regular!
      subject.admin!
      expect(subject.any_role_is_admin?).to eq true
      expect(subject.any_role_is_regular?).to eq true
    end
    it "return true if current_role is regular" do
      subject.regular!
      expect(subject.current_role.regular?).to eq true
      expect(subject.regular?).to eq true
    end
    it "return false if current_role is not regular" do
      subject.admin!
      expect(subject.current_role.regular?).to eq false
      expect(subject.regular?).to eq false
    end
  end
end
