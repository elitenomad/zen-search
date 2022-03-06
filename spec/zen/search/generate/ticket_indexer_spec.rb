# frozen_string_literal: true

RSpec.describe Zen::Search::Generate::TicketIndexer do
    let(:tickets) { ZenSearchTestHelper::Mock.new.tickets}
    let(:ticket_collection) { Zen::Search::Tickets.new(tickets) }
    let(:subject) { Zen::Search::Generate::TicketIndexer.new(ticket_collection) }

    context '#index!' do 
        before do
            subject.index!
        end

        it "is expected to have id_index" do
            expect(
                subject.id_index.keys
            ).to eq(ticket_collection.to_a.map(&:id))
            expect(subject.id_index.values).to eq(ticket_collection.to_a)
        end

        it "is expected to have assignee_id_index" do
            expect(
                subject.assignee_index.keys
            ).to eq(ticket_collection.to_a.map(&:assignee_id))
        end

        it "is expected to have type_index" do
            tickets.each do |ticket|
                expect(
                    subject.type_index[ticket[:type].downcase]
                ).to eq(ticket_collection.to_a.select{|tc| tc.type == ticket[:type]} )
            end
        end

        it "is expected to have subject_index" do
            tickets.each do |ticket|
                expect(
                    subject.subject_index[ticket[:subject].downcase]
                ).to eq(ticket_collection.to_a.select{|tc| tc.subject == ticket[:subject]} )
            end
        end

        it "is expected to have tag_index" do
            tickets.each do |ticket|
                expect(
                    subject.tag_index[ticket[:tags].first.downcase]
                ).not_to be_nil
            end
        end
    end
end