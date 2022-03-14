# frozen_string_literal: true

RSpec.describe Zen::Search::Loader do
  let(:subject) { Zen::Search::Loader }

  context ".run" do
    let(:users) { ZenSearchTestHelper::Mock.new.users }
    let(:tickets) { ZenSearchTestHelper::Mock.new.tickets }

    let(:expected_user_collection) { Zen::Search::Resources::Users.new(users) }
    let(:expected_tickets_collection) { Zen::Search::Resources::Tickets.new(tickets) }

    describe "when called with Users" do
      it "is expected to return user collection" do
        collection = subject.run(users, "Users")
        expect(collection.count).to eq(3)

        collection.each do |zen_user|
          user = users.find { |u| u[:name] == zen_user.name }
          expect(zen_user.id).to eq(user[:_id])
          expect(zen_user.name).to eq(user[:name])
          expect(zen_user.created_at.to_s).to eq(user[:created_at])
          expect(zen_user.verified).to eq(user[:verified])
        end
      end
    end

    describe "when called with Tickets" do
      it "is expected to return ticket collection" do
        collection = subject.run(tickets, "Tickets")
        expect(collection.count).to eq(3)

        collection.each do |zen_ticket|
          ticket = tickets.find { |t| t[:_id] == zen_ticket.id }
          expect(zen_ticket.id).to eq(ticket[:_id])
          expect(zen_ticket.type).to eq(ticket[:type])
          expect(zen_ticket.subject).to eq(ticket[:subject])
          expect(zen_ticket.tags).to eq(ticket[:tags])
        end
      end
    end
  end
end
