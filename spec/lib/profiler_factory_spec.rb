require "spec_helper"

require "profiler_factory"

RSpec.describe ProfilerFactory do
  it "fails to profile when the profiler is unknown" do
    expect { create_factory(:unknown) }.to raise_error("Unknown profiler: unknown")
  end

  it "creates a ruby-prof profiler" do
    factory = create_factory(:ruby_prof)

    expect(factory).to be_a_kind_of(Profiler::RubyProfProfiler)
  end

  it "creates a benchmark profiler" do
    factory = create_factory(:benchmark)

    expect(factory).to be_a_kind_of(Profiler::BenchmarkProfiler)
  end

  def create_factory(profiler)
    ProfilerFactory.create(profiler: profiler, results_dir: ".")
  end
end
