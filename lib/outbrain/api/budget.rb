module Outbrain
  module Api
    class Budget < Base
      PATH='budgets'

      def self.path(id)
        "marketers/#{id}/budgets"
      end

      def self.create(request, attributes)
        request.create(path(attributes.delete(:marketer_id)), {as: self, attributes: attributes})
      end

      def self.find(request, budget_id)
        request.find(PATH, budget_id, { as: self })
      end

      def self.find_by(request, attributes={})
        marketer_id = attributes[:marketer_id]
        fail InvalidOption 'find_by requires marketer-id' unless marketer_id
        request.all(path(marketer_id), { as: self, resource_name: 'budgets'})
      end

      def create_campaign(request, attributes)
        Campaign.create(request, attributes.merge(budgetId: id))
      end

      def self.update(request, budget_id, attributes)
        request.update(PATH, budget_id, {as: self, attributes: attributes })
      end
    end
  end
end
