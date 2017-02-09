module Outbrain
  module Api
    class Token < Base
      PATH  = "login"

      def self.create(username, password)
        Request.create(PATH, { username: username, password: password })
      end

    end
  end
end
