require 'spec_helper'

describe Outbrain::Api::Budget do
  subject { Outbrain::Api::Budget }

  describe '.find' do
    let(:budget_id){ 'testid' }
    let(:budget) do
      {
        "id" => budget_id,
        "name" => "Test Budget"
      }
    end
    let(:outbrain_budget){ Outbrain::Api::Budget.new(budget) }
    it 'sends the proper request' do
      Outbrain::Request.stub(:find).with('budgets', budget_id, {as: subject}).and_return(outbrain_budget)
      outbrain_budget = Outbrain::Api::Budget.find(budget["id"])
      expect(outbrain_budget["id"]).to eq(budget["id"])
    end
  end
end
