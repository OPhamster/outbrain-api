module Outbrain
  module Api
    class Token < Base
      PATH  = "login"

      def self.fetch(request, user_name, user_password)
        credentials = {user_name: user_name, user_password: user_password}
        token = request.get(PATH, credentials)
      end
    end
  end
end
