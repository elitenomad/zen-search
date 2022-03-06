# frozen_string_literal: true

require "tty-table"
RSpec.describe Zen::Search::Services::Print do
  let(:subject) { Zen::Search::Services::Print }
  expected_no_results_found = <<~EOF
  No results found
  EOF
  expected_list_display = <<~EOF
    +----------+
    |id        |
    |name      |
    |verified  |
    |created_at|
    +----------+
  EOF

  describe ".list" do
    context 'when values is not empty' do
      it "is expected to return values to stdout" do
        expect do
          subject.list(%w[id name verified created_at])
        end.to output(expected_list_display).to_stdout
      end
    end
    
    context 'when values is empty' do
      it "is expected to display no results message" do
        expect do
          subject.list([])
        end.to output(expected_no_results_found).to_stdout
      end
    end
  end

  # Decided not to test the functionality of how TTY::Pager::SystemPager
  # instance methods work
  # So tested only if the Library class is called when we execute `objects` method
  describe ".objects" do
    let(:users) { ZenSearchTestHelper::Mock.new.users }
    let(:user_collection) { Zen::Search::Users.new(users) }

    context 'when results is not empty' do
      it "is expected to return values to stdout" do
        allow_any_instance_of(TTY::Pager::SystemPager).to receive(:puts)
        subject.objects(user_collection.to_a)
      end
    end

    context 'when values is empty' do
      it "is expected to display no results message" do
        expect do
          subject.objects([])
        end.to output(expected_no_results_found).to_stdout
      end
    end
    
  end
end
