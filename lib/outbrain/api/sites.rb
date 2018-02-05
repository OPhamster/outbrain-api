require "outbrain/api/publisher"
require "outbrain/api/section"

module Outbrain
  module Api
    class Sites < Base
      coerce_key :blockedPublishers, Array[Publisher]
      coerce_key :blockedSections, Array[Section]
    end
  end
end
