# frozen_string_literal: true

RSpec.describe Zen::Search::Resources::Tickets do
  let(:tickets) { ZenSearchTestHelper::Mock.new.tickets }
  subject { Zen::Search::Resources::Tickets.new(tickets) }

  it { is_expected.to respond_to(:each) }

  it "is expected to return records of type Zen::Search::Resources::Ticket" do
    subject.each do |record|
      expect(record).to be_a_kind_of(Zen::Search::Resources::Ticket)
    end
  end

  describe "#each" do
    it "is expected not to raise error when accessed" do
      expect { subject.each { |z| z } }.not_to raise_error
    end
  end
end
