# frozen_string_literal: true

RSpec.describe Zen::Search::Updater do
  let(:subject) { Zen::Search::Updater }

  context ".run" do
    let(:users) { ZenSearchTestHelper::Mock.new.users }
    let(:tickets) { ZenSearchTestHelper::Mock.new.tickets }
    let(:user_collection) { Zen::Search::Users.new(users) }
    let(:ticket_collection) { Zen::Search::Tickets.new(tickets) }

    before(:each) do
      subject.run(user_collection, ticket_collection)
    end

    describe "when called" do
      it "is expected to update user collection with tickets" do
        user_collection.each do |user|
          expect(user.tickets.size).to eq(1)
        end
      end

      it "is expected to update ticket collection with assignee name" do
        ticket_collection.each do |ticket|
          expect(ticket.assignee_name).not_to be_nil
        end
      end
    end
  end
end
