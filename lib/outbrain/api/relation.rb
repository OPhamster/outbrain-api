module Outbrain
  module Api
    class Relation
      include Enumerable
      attr_accessor :relations, :errors, :totalDataCount, :totalCount, :overAllMetrics, :aggregatedBy, :details, :overallMetrics

      def initialize(options = {})
        @relations = []
        @errors = []
      end

      def each &block
        @relations.each{|relation| block.call(relation) }
      end

      def any?
        relations.any?
      end
    end
  end
end
