# frozen_string_literal: true

RSpec.describe Zen::Search::Helpers do
  let(:subject) { Zen::Search::Helpers }
  context ".fields_for" do
    describe "when type is users" do
      it "is expected to return user attributes" do
        expect(subject.fields_for("Users")).to eq(Zen::Search::Services::Constants::USER_ATTRIBUTES)
      end
    end

    describe "when type is tickets" do
      it "is expected to return ticket attributes" do
        expect(subject.fields_for("Tickets")).to eq(Zen::Search::Services::Constants::TICKET_ATTRIBUTES)
      end
    end
  end

  context ".text_index" do
    let(:idx) { {} }
    let(:options) do
      {
        "_id": 1,
        "name": "Francisca Rasmussen",
        "created_at": "2016-04-15T05:19:46-10:00",
        "verified": true
      }
    end

    # Testing for a user index only to keep tests simple
    let(:user) { Zen::Search::Resources::User.new(options) }

    it "is expected to capture the document against the given name" do
      subject.text_index(user, user.name, idx)
      expect(idx[user.name.downcase]).to eq([user])
    end
  end

  context ".tokenized_index" do
    let(:idx) { {} }
    let(:options) do
      {
        "_id": 1,
        "name": "Francisca Rasmussen",
        "created_at": "2016-04-15T05:19:46-10:00",
        "verified": true
      }
    end

    # Testing for a user index only to keep tests simple
    let(:user) { Zen::Search::Resources::User.new(options) }

    it "is expected to capture the document against the given name" do
      subject.tokenized_index(user, user.name, idx)
      user.name.split(" ").each do |t|
        expect(idx[t.downcase]).to eq([user])
      end
    end
  end
end
