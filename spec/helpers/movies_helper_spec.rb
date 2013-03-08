require "spec_helper"

describe MoviesHelper do
  describe "oddness" do
    it "returns odd for an odd number" do
      helper.oddness(3).should eq("odd")
    end
    it "returns even for an even number" do
      helper.oddness(2).should eq("even")
    end
  end
end
