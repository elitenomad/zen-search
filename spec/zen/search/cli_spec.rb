# frozen_string_literal: true

RSpec.describe Zen::Search::CLI do
    let(:subject) { Zen::Search::CLI.new }
    let(:files) {[
      "#{File.dirname(__FILE__)}/../../support/users.json",
      "#{File.dirname(__FILE__)}/../../support/tickets.json"
    ]}
    let(:unsupported_files) {[
      "#{File.dirname(__FILE__)}/../../support/test.json"
    ]}

    context '#load' do
      context "when ran for valid files" do
        it "is expected to call parser and loader" do
          files.each do |file|
            expect(
              Zen::Search::Parse
            ).to receive(:run).with(file)

            case file
            when /users/
              expect(
                Zen::Search::Loader
              ).to receive(:run).with(nil, 'Users')
            when /tickets/
              expect(
                Zen::Search::Loader
              ).to receive(:run).with(nil, 'Tickets')
            end
          end
          
          subject.load(files)
        end
      end

      context "when ran for in valid files" do
        it "is expected to raise error" do
          expect { 
            subject.load(unsupported_files) 
          }.to raise_error(Zen::Search::FileFormatNotSupportedError)
        end
      end
    end
  
    context ".run" do
      # Testing this function requires a 
    end

end