require 'workplace.rb'

RSpec.describe "A loop" do
  it "given 2 and 2, return 4" do
    expect(for_system(2, 2)).to eq(4)
  end
  it "given 3 and 3, return 6" do
    expect(for_system(3, 2)).to eq(6)
  end
end
