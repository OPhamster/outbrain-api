module Outbrain
  module Api
    class Relation
      include Enumerable
      attr_accessor :relations, :totalDataCount, :overAllMetrics, :aggregatedBy 

      def initialize(options = {})
        @relations = []
      end

      def each &block
        @relations.each{|relation| block.call(relation) }
      end
    end
  end
end
