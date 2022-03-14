# frozen_string_literal: true

RSpec.describe Zen::Search::Resources::Users do
  let(:users) { ZenSearchTestHelper::Mock.new.users }
  subject { Zen::Search::Resources::Users.new(users) }

  it { is_expected.to respond_to(:each) }

  it "is expected to return records of type Zen::Search::Resources::User" do
    subject.each do |record|
      expect(record).to be_a_kind_of(Zen::Search::Resources::User)
    end
  end

  describe "#each" do
    it "is expected not to raise error when accessed" do
      expect { subject.each { |z| z } }.not_to raise_error
    end
  end
end
