require "spec_helper"

require "profiler_factory"

RSpec.describe ProfilerFactory do
  it "fails to profile when the profiler is unknown" do
    expect { ProfilerFactory.create(profiler: :unknown, results_dir: nil) }.to raise_error("Unknown profiler: unknown")
  end

  it "creates a ruby-prof profiler" do
    factory = ProfilerFactory.create(profiler: :ruby_prof, results_dir: nil)

    expect(factory).to be_a_kind_of(Profiler::RubyProfProfiler)
  end
end
