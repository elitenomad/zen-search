# frozen_string_literal: true

RSpec.describe Zen::Search::Users do
    let(:users) { ZenSearchTestHelper::Mock.new.users}
    subject { Zen::Search::Users.new(users) }
    
    it { is_expected.to respond_to(:each) }

    it "is expected to return records of type Zen::Search::User" do
        subject.each do |record|
            expect(record).to be_a_kind_of(Zen::Search::User)
        end
    end

    describe "#each" do
        it "is expected not to raise error when accessed" do
          expect { subject.each { |z| z } }.not_to raise_error
        end
    end
end