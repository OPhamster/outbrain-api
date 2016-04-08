module Outbrain
  module Api
    class Budget < Base
      PATH='budgets'

      def self.path(id)
        "marketers/#{id}/budgets"
      end

      def self.create(attributes)
        Request.create(path(attributes.delete(:marketer_id)), {as: self, attributes: attributes})
      end

      def self.find(budget_id)
        Request.find(PATH, budget_id, { as: self })
      end

      def self.find_by(attributes={})
        marketer_id = attributes[:marketer_id]
        fail InvalidOption 'find_by requires marketer-id' unless marketer_id
        Request.all(path(marketer_id), { as: self, resource_name: 'budgets'})
      end

      def create_campaign(attributes)
        Campaign.create(attributes.merge(budgetId: id))
      end
    end
  end
end
