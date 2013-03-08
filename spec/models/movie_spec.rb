require "spec_helper"

describe Movie do
  it "returns rating list" do
  expect(Movie.all_ratings).to eq(["G", "PG", "PG-13", "NC-17", "R"])
  end
end
