require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  context "As admin" do 
    permissions :menu?, :show?, :index?, :create?, :new?, :update?, :edit?, :destroy?, :update_all_passwords?, :update_password? do
      it "grant acess" do
        expect(subject).to permit( (create :user_admin), (create :user))
      end
    end
  end
  context "As Regular" do
    permissions :menu?, :show?, :index?, :create?, :new?, :update?, :edit?, :destroy?, :update_all_passwords? do
      it "dont grant acess" do
        expect(subject).not_to permit( (create :user), (create :user))
      end
    end
    permissions :update_password? do
      it "grante access" do
        expect(subject).to permit( (create :user), (create :user))
      end
    end
  end
end
