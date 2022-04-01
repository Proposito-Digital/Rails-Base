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
 
  xit "successfully connects with params" do
     # Simulate a connection opening by calling the `connect` method
    connect params: { user_id: 42 }
 
    # You can access the Connection object via `connection` in tests
    assert_equal connection.user_id, "42"
  end

  xit "rejects connection" do
      assert_reject_connection do
        connect
      end
  end
end