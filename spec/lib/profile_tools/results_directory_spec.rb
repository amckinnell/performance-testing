require "spec_helper"

require "profile_tools/results_directory"

module ProfileTools
  RSpec.describe ResultsDirectory do
    before do
      Timecop.freeze(Time.local(2016, 5, 31, 5, 20, 45))
    end

    after do
      Timecop.return
    end

    it "creates directory when none exists" do
      Dir.mktmpdir do |tmp_dir|
        results_dir = ResultsDirectory.new(results_dir: tmp_dir).create(tag: :profile)

        expect(results_dir).to eq("#{tmp_dir}/2016-05-31T052045-profile")
      end
    end

    it "no op when directory already exists" do
      Dir.mktmpdir do |tmp_dir|
        ResultsDirectory.new(results_dir: tmp_dir).create(tag: :benchmark)

        results_dir = ResultsDirectory.new(results_dir: tmp_dir).create(tag: :benchmark)

        expect(results_dir).to eq("#{tmp_dir}/2016-05-31T052045-benchmark")
      end
    end
  end
end
