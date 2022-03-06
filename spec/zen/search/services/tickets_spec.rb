# frozen_string_literal: true

RSpec.describe Zen::Search::Services::Tickets do
  let(:subject) { Zen::Search::Services::Tickets }
  let(:indexes) { ZenSearchTestHelper::Mock.new.indexes }
  let(:ticket_index) { indexes[1] }

  # Using assignee index for to retrive ticekt values.
  let(:first_ticket) { ticket_index.assignee_index[1] }
  let(:incident_tickets) { ticket_index.id_index.values.flatten.select { |ticket| ticket.type == "incident" } }

  describe "#find_by_id" do
    it "is expected return ticket for given id" do
      expect(
        subject.find_by_id(ticket_index, "436bf9b0-1147-4c0a-8439-6f79833bff5b")
      ).to eq(first_ticket)
    end
  end

  describe "#find_by_assignee_id" do
    it "is expected return ticket for given user id" do
      expect(
        subject.find_by_assignee_id(ticket_index, 1)
      ).to eq(first_ticket)
    end
  end

  describe "#find_by_type" do
    it "is expected return ticket for given name" do
      expect(
        subject.find_by_type(ticket_index, "incident")
      ).to eq(incident_tickets)
    end
  end

  describe "#find_after_date" do
    it "is expected return all Tickets for given date" do
      expect(
        subject.find_after_date(ticket_index, Date.new(2016, 0o4, 14))
      ).to eq(ticket_index.id_index.values)
    end
  end

  describe "#find_by_subject" do
    it "is expected return only tickets with given subject" do
      expect(
        subject.find_by_subject(ticket_index, "catastrophe")
      ).to eq(ticket_index.id_index.values)
    end
  end

  describe "#find_by_tag" do
    it "is expected return only tickets with given tag" do
      expect(
        subject.find_by_tag(ticket_index, "ohio")
      ).not_to be_nil
    end
  end
end
