# frozen_string_literal: true

RSpec.describe Zen::Search::Services::Users do
  let(:subject) { Zen::Search::Services::Users }
  let(:indexes) { ZenSearchTestHelper::Mock.new.indexes }
  let(:user_index) { indexes[0] }
  let(:first_user) { [user_index.id_index[1]] }
  let(:verified_users) { [user_index.id_index[1], user_index.id_index[2]] }
  let(:non_verified_users) { [user_index.id_index[3]] }

  describe "#find_by_id" do
    it "is expected return user for given id" do
      expect(
        subject.find_by_id(user_index, 1)
      ).to eq(first_user)
    end

    context 'when id does not exists' do
      it "is expected return []" do
        expect(
          subject.find_by_id(user_index, 25)
        ).to eq([])
      end
    end
  end

  describe "#find_by_name" do
    it "is expected return user for given name" do
      expect(
        subject.find_by_name(user_index, "Francisca Rasmussen")
      ).to eq(first_user)
    end

    context 'when name does not exists' do
      it "is expected return []" do
        expect(
          subject.find_by_name(user_index, "sample-name")
        ).to eq([])
      end
    end
  end

  describe "#find_after_date" do
    it "is expected return all users for given date" do
      expect(
        subject.find_after_date(user_index, Date.new(2016, 04, 14))
      ).to eq(user_index.id_index.values)
    end

    context 'when records after a date does not exists' do
      it "is expected return []" do
        expect(
          subject.find_after_date(user_index, Date.new(2022,01,01))
        ).to eq([])
      end
    end
    
  end

  describe "#find_verified_users" do
    it "is expected return only verified users for truthy" do
      expect(
        subject.find_verified_users(user_index, true)
      ).to eq(verified_users)
    end

    it "is expected return only non-verified users for falsey" do
      expect(
        subject.find_verified_users(user_index, false)
      ).to eq(non_verified_users)
    end

    context 'when invalid verfied value is searched' do
      it "is expected return []" do
        expect(
          subject.find_verified_users(user_index, nil)
        ).to eq([])
      end
    end
  end
end
