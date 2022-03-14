# frozen_string_literal: true

RSpec.describe Zen::Search::Generate::UserIndexer do
  let(:users) { ZenSearchTestHelper::Mock.new.users }
  let(:user_collection) { Zen::Search::Resources::Users.new(users) }
  let(:subject) { Zen::Search::Generate::UserIndexer.new(user_collection) }

  context "#index!" do
    before do
      subject.index!
    end

    it "is expected to have id_index" do
      expect(subject.id_index.keys).to eq([1, 2, 3])
      expect(subject.id_index.values).to eq(user_collection.to_a)
    end

    it "is expected to have name_index" do
      users.each do |user|
        expect(
          subject.name_index[user[:name].downcase]
        ).to eq(user_collection.to_a.select { |uc| uc.name == user[:name] })
      end
    end

    it "is expected to have verfied_index" do
      expect(subject.verfied_index[:true]).to eq(user_collection.to_a.select { |user| user.verified == true })
      expect(subject.verfied_index[:false]).to eq(user_collection.to_a.select { |user| user.verified == false })
    end
  end
end
