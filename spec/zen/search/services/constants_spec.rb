# frozen_string_literal: true

RSpec.describe Zen::Search::Services::Constants do
  let(:subject) { Zen::Search::Services::Constants }

  context "when USER_ATTRIBUTES is accessed" do
    it "is expected to return user attributes " do
      expect(subject::USER_ATTRIBUTES).to eq(%w[_id name verified created_at])
    end
  end

  context "when TICKET_ATTRIBUTES is accessed" do
    it "is expected to return ticket attributes" do
      expect(
        subject::TICKET_ATTRIBUTES
      ).to eq(%w[_id type subject assignee_id tag created_at])
    end
  end

  context "when TICKET_PRINT_ATTRIBUTES is accessed" do
    it "is expected to return print ticket attributes" do
      expect(
        subject::TICKET_PRINT_ATTRIBUTES
      ).to eq(%w[_id type subject assignee_id assignee_name tag created_at])
    end
  end
end
