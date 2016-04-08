require 'spec_helper'

describe Outbrain::Api::Campaign do
  subject { Outbrain::Api::Campaign }

  describe 'PATH' do
    it 'is equal to campaigns' do
      expect(Outbrain::Api::Campaign::PATH).to eq('campaigns')
    end
  end

  describe '.find' do
    let(:campaign_id){ 'testid' }
    let(:campaign) do
      {
        "id" => campaign_id,
        "name" => "Test Campaign"
      }
    end
    let(:outbrain_campaign){ Outbrain::Api::Campaign.new(campaign) }

    it 'sends the proper request' do
      Outbrain::Request.stub(:find).with('campaigns', campaign_id, {as: subject}).and_return(outbrain_campaign)
      outbrain_campaign = Outbrain::Api::Campaign.find(campaign["id"])
      expect(outbrain_campaign["id"]).to eq(campaign["id"])
    end
  end
end
