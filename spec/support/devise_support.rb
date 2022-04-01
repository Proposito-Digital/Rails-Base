# frozen_string_literal: true
# This support package contains modules for authenticaiting
# devise users for request specs.

# This module authenticates users for request specs.#
module ValidUserRequestHelper
    # Define a method which signs in as a valid user.
    def sign_in_as_a_valid_user
        # ASk factory girl to generate a valid user for us.
        @instance ||= create(:user)

        # We action the login request using the parameters before we begin.
        # The login requests will match these to the user we just created in the factory, and authenticate us.
        post user_session_path, params: {'user[email]' => @instance.email, 'user[password]' => @instance.password}
        follow_redirect!
        #post_via_redirect user_session_path, 'user[email]' => @instance.email, 'user[password]' => @instance.password
    end
end
