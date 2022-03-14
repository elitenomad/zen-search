# frozen_string_literal: true

RSpec.describe Zen::Search::Services::Core do
  let(:indexes) { ZenSearchTestHelper::Mock.new.indexes }
  let(:subject) { Zen::Search::Services::Core.new(indexes[0], indexes[1]) }

  describe "#display_fields_for" do
    context "when Users is passed as Type" do
      it "is expected to call Zen::Search::Services::Fields list method" do
        expect(
          Zen::Search::Services::Fields
        ).to receive(:list)
        subject.display_fields_for("Users")
      end
    end

    context "when Tickets is passed as Type" do
      it "is expected to call Zen::Search::Services::Fields list method" do
        expect(
          Zen::Search::Services::Fields
        ).to receive(:list)
        subject.display_fields_for("Tickets")
      end
    end
  end

  context "Users" do
    describe "#display_user_by_id" do
      context "when called by a valid id" do
        it "is expected to call find_by_id and objects method" do
          expect(
            Zen::Search::Services::Users
          ).to receive(:find_by_id).with(indexes[0], 1)
          expect(
            Zen::Search::Services::Print
          ).to receive(:objects)

          subject.search_user({id: 1})
        end
      end
    end

    describe "#display_user_by_name" do
      context "when called by a valid name" do
        it "is expected to call find_by_id and objects method" do
          expect(
            Zen::Search::Services::Users
          ).to receive(:find_by_name).with(indexes[0], "francisca")
          expect(
            Zen::Search::Services::Print
          ).to receive(:objects)

          subject.search_user({name: "francisca"})
        end
      end
    end

    describe "#display_verified_users" do
      context "when called by a bool value (true|false)" do
        it "is expected to call find_verified_users and objects method" do
          expect(
            Zen::Search::Services::Users
          ).to receive(:find_by_verified).with(indexes[0], true)
          expect(
            Zen::Search::Services::Print
          ).to receive(:objects)

          subject.search_user({verified: true})
        end
      end
    end

    describe "#display_users_from_date" do
      context "when called by a date" do
        let(:time) { DateTime.now }
        it "is expected to call find_after_date and objects method" do
          expect(
            Zen::Search::Services::Users
          ).to receive(:find_by_created_at).with(indexes[0], time)
          expect(
            Zen::Search::Services::Print
          ).to receive(:objects)

          subject.search_user({created_at: time})
        end
      end
    end
  end

  context "Tickets" do
    describe "#display_ticket_by_id" do
      context "when called by a valid id" do
        it "is expected to call find_by_id and objects method" do
          expect(
            Zen::Search::Services::Tickets
          ).to receive(:find_by_id).with(indexes[1], 1)
          expect(
            Zen::Search::Services::Print
          ).to receive(:objects)

          subject.search_ticket({id: 1})
        end
      end
    end

    describe "#display_tickets_by_type" do
      context "when called by a valid type" do
        it "is expected to call find_by_id and objects method" do
          expect(
            Zen::Search::Services::Tickets
          ).to receive(:find_by_type).with(indexes[1], "problem")
          expect(
            Zen::Search::Services::Print
          ).to receive(:objects)

          subject.search_ticket({type: "problem"})
        end
      end
    end

    describe "#display_tickets_by_subject" do
      context "when called by a subject" do
        it "is expected to call find_by_id and objects method" do
          expect(
            Zen::Search::Services::Tickets
          ).to receive(:find_by_subject).with(indexes[1], "no problemo")
          expect(
            Zen::Search::Services::Print
          ).to receive(:objects)

          subject.search_ticket({subject: "no problemo"})
        end
      end
    end

    describe "#display_tickets_from_date" do
      context "when called by a date" do
        let(:time) { DateTime.now }

        it "is expected to call find_after_date and objects method" do
          expect(
            Zen::Search::Services::Tickets
          ).to receive(:find_by_created_at).with(indexes[1], time)
          expect(
            Zen::Search::Services::Print
          ).to receive(:objects)

          subject.search_ticket({created_at: time})
        end
      end
    end

    describe "#display_tickets_by_assignee_id" do
      context "when called by a user id" do
        it "is expected to call find_by_assignee_id and objects method" do
          expect(
            Zen::Search::Services::Tickets
          ).to receive(:find_by_assignee_id).with(indexes[1], 1)
          expect(
            Zen::Search::Services::Print
          ).to receive(:objects)

          subject.search_ticket({assignee_id: 1})
        end
      end
    end

    describe "#display_tickets_by_tag" do
      context "when called by a tag" do
        it "is expected to call find_by_tag and objects method" do
          expect(
            Zen::Search::Services::Tickets
          ).to receive(:find_by_tag).with(indexes[1], "tag")
          expect(
            Zen::Search::Services::Print
          ).to receive(:objects)

          subject.search_ticket({tag: "tag"})
        end
      end
    end
  end
end
