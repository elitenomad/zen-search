# frozen_string_literal: true
require "tty-table"
RSpec.describe Zen::Search::Services::Print do
    let(:subject) { Zen::Search::Services::Print }
    expected_list_display = <<~EOF
    +----------+
    |id        |
    |name      |
    |verified  |
    |created_at|
    +----------+
    EOF
    
    expected_objects_display = <<~EOF
    +---+-------------------+-------------------------+--------+-------+
    |_id|name               |created_at               |verified|tickets|
    +---+-------------------+-------------------------+--------+-------+
    |1  |Francisca Rasmussen|2016-04-15T05:19:46-10:00|true    |[]     |
    |2  |Cross Barlow       |2016-06-23T10:31:39-10:00|true    |[]     |
    |3  |Ingrid Wagner      |2016-07-28T05:29:25-10:00|false   |[]     |
    +---+-------------------+-------------------------+--------+-------+
    EOF

    describe '.list' do 
        it "is expected to return values to stdout" do
            expect do
                subject.list(['id', 'name', 'verified', 'created_at'])
            end.to output(expected_list_display).to_stdout
        end
    end

    describe '.objects' do 
        let(:users) { ZenSearchTestHelper::Mock.new.users}
        let(:user_collection) { Zen::Search::Users.new(users) }

        it "is expected to return values to stdout" do
            expect do
                subject.objects(user_collection.to_a)
            end.to output(expected_objects_display).to_stdout
        end
    end
end