# frozen_string_literal: true

RSpec.describe Zen::Search::Services::Fields do
    let(:subject) { Zen::Search::Services::Fields }

    describe '.list' do 
        context 'when Users is passed as Type' do 
            it "is expected to return user attributes " do
                expect(
                    Zen::Search::Services::Print
                ).to receive(:list).with(Zen::Search::Services::Constants::USER_ATTRIBUTES)
                subject.list('Users')
            end
        end
        
        context 'when Tickets is passed as Type' do 
            it "is expected to return ticket attributes " do
                expect(
                    Zen::Search::Services::Print
                ).to receive(:list).with(Zen::Search::Services::Constants::TICKET_ATTRIBUTES)
                subject.list('Tickets')
            end
        end
    end
end