require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do
  
  let(:user) { create(:user) }

   it "successfully connects" do
     # Simulate a connection opening by calling the `connect` method
    cookies.signed[:user_id] = user.id
    connect 
     # You can access the Connection object via `connection` in tests
     expect(connection.current_user).to be
  end
end