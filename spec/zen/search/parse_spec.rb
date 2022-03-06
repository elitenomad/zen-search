# frozen_string_literal: true

RSpec.describe Zen::Search::Parse do
    let(:subject) { Zen::Search::Parse }

    context '.run' do
        let(:path) { File.dirname(__FILE__) + '/../../support/users.json' }

        # Initial format after parsing
        let(:expected_result) {[
            {"_id"=>1, "name"=>"Francisca Rasmussen", "created_at"=>"2016-04-15T05:19:46-10:00", "verified"=>true},
            {"_id"=>2, "name"=>"Cross Barlow", "created_at"=>"2016-06-23T10:31:39-10:00", "verified"=>true},
            {"_id"=>3, "name"=>"Ingrid Wagner", "created_at"=>"2016-07-28T05:29:25-10:00", "verified"=>false},
        ]}

        describe 'when called' do
            it "is expected to read and parse the file and return data" do
                expect(subject.run(path)).to eq(expected_result)  
            end
        end

        describe "when file is not present" do
            it "is expected to raise FileNotExistsError" do
              path = File.dirname(__FILE__) + "/../../support/test.json"
              expect { subject.run(path) }.to raise_error(Zen::Search::FileNotExistsError)
            end
          end
  
        describe "when file format is not supported" do
            it "is expected to raise FileFormatNotSupportedError" do
              path = File.dirname(__FILE__) + "/../../support/test.csv"
              expect { subject.run(path) }.to raise_error(Zen::Search::FileFormatNotSupportedError)
            end
        end
    end
  end
  