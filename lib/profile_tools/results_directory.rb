module ProfileTools
  #
  # Knows how to create a timestamped and tagged directory.
  #
  class ResultsDirectory
    DEFAULT_RESULTS_DIR = "./profile_results"

    def initialize(results_dir: DEFAULT_RESULTS_DIR)
      @results_dir = results_dir
    end

    def create(tag:)
      results_directory_name(tag).tap do |name|
        FileUtils.mkdir_p(name)
      end
    end

    private

    def results_directory_name(tag)
      File.join(@results_dir, "#{timestamp}-#{tag}")
    end

    def timestamp
      Time.now.strftime("%Y-%m-%dT%H%M%S")
    end
  end
end
