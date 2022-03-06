# frozen_string_literal: true

RSpec.describe Zen::Search::Generate::Indexer do
  let(:users) { ZenSearchTestHelper::Mock.new.users }
  let(:tickets) { ZenSearchTestHelper::Mock.new.tickets }
  let(:user_collection) { Zen::Search::Users.new(users) }
  let(:ticket_collection) { Zen::Search::Tickets.new(tickets) }
  let(:subject) { Zen::Search::Generate::Indexer.new(user_collection, ticket_collection) }

  context "#index!" do
    it "is expected to call UserIndexer and TicketIndexer" do
      expect(
        Zen::Search::Generate::UserIndexer
      ).to receive(:new).with(user_collection)

      expect(
        Zen::Search::Generate::TicketIndexer
      ).to receive(:new).with(ticket_collection)

      subject.index!
    end
  end
end
