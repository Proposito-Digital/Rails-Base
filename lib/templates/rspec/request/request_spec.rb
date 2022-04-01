require 'rails_helper'

RSpec.describe "<%= class_name.pluralize %>", type: :request  do
  describe "GET /<%= table_name %>" do
  	before do
        sign_in_as_a_valid_user
    end
    
    it "works! (now write some real specs)" do
      get admin_<%= index_helper %>_path
      expect(response).to have_http_status(200)
    end
  end
end