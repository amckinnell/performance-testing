#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path("../lib")

require "profile_tools/profiler_factory"

sample_hash_to_split = {
  "a" => "1",
  "b" => "2",
  "c" => "3",
  "d" => "4",
  "e" => "5",
  "f" => "6",
  "h" => "7",
  "i" => "8",
  "j" => "9",
  "k" => "0",
  "A" => "1",
  "B" => "2",
  "C" => "3",
  "D" => "4",
  "E" => "5",
  "F" => "6"
}

def slow_task(hash_to_split)
  lowercase_hash = hash_to_split.dup

  {}.tap do |h|
    h["A"] = lowercase_hash.delete("A") if lowercase_hash.include?("A")
    h["B"] = lowercase_hash.delete("B") if lowercase_hash.include?("B")
    h["C"] = lowercase_hash.delete("C") if lowercase_hash.include?("C")
    h["D"] = lowercase_hash.delete("D") if lowercase_hash.include?("D")
    h["E"] = lowercase_hash.delete("D") if lowercase_hash.include?("D")
    h["F"] = lowercase_hash.delete("F") if lowercase_hash.include?("F")
  end
end

def fast_task(hash_to_split)
  lowercase_keys = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "k"]

  lowercase = {}
  uppercase = {}

  hash_to_split.each { |k, v| lowercase_keys.include?(k) ? lowercase[k] = v : uppercase[k] = v }
end

# Profilers to choose from:
# profiler_tag = :benchmark
# profiler_tag = :ruby_prof
# profiler_tag = :memory_profiler

profiler_tag = :memory_profiler

results_dir = ProfileTools::ResultsDirectory.new(results_dir: "../profile_results").create(tag: profiler_tag)
profiler = ProfileTools::ProfilerFactory.create(profiler: profiler_tag, results_dir: results_dir)

profiler.profile do
  500.times.each { slow_task(sample_hash_to_split) }
end
