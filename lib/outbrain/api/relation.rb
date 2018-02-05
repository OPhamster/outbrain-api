module Outbrain
  module Api
    class Relation < OpenStruct
      include Enumerable
      extend Forwardable
      def_delegator :relations, :each, :each
      def initialize(options = {})
        super
        self.errors = []
        relation = options.delete(options[:relation_name])
        Hashie::Mash.new(options).each{ |k,v| self[k] = v }
        setup_relations(relation)
      end

      def to_a
        arr = []
        each do |o|
          arr << o
        end
        return arr
      end

      private

      def setup_relations(relation)
        relation ||= [] # if nil still want array
        self.relations = relation.map { |e| relation_class.new(e) }
      end
    end
  end
end
