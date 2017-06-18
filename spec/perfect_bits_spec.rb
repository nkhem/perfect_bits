require 'rspec'
require 'base_helpers'
require 'mid_helpers'
require 'perfect_bits'

describe "#perfect_bits" do
  it "returns correct value on initial range" do
    # expect(perfect_bits(10,16)).to eq(2)
    # expect(perfect_bits(100, 128)).to eq(10)
    # expect(perfect_bits(1000, 1024)).to eq(6)
    # expect(perfect_bits(30000, 32768)).to eq(651)
    expect(perfect_bits(92233720, 92233720000)).to eq(10719324449)
    # expect(perfect_bits(9223372036854770000, 9223372036854775808)).to eq(1)
  end
  it "returns correct value on mid range" do
    # expect(perfect_bits(2,4)).to eq(2)
    # expect(perfect_bits(16,32)).to eq(6)
    # expect(perfect_bits(128, 256)).to eq(37)
    # expect(perfect_bits(16384, 32768)).to eq(3369)
    # expect(perfect_bits(2, 9223372036854775808)).to eq(734248687150654971)
    # expect(perfect_bits(128, 1099511627776)).to eq(103351068365)
  end
  it "returns correct value on final range" do
    # expect(perfect_bits(4,11)).to eq(2)
    expect(perfect_bits(16,28)).to eq(2)
    # expect(perfect_bits(32,46)).to eq(5)
    expect(perfect_bits(16384, 30000)).to eq(2719)
    # expect(perfect_bits(9223372036854775807, 9223372036854775815)).to eq(2)
  end
  it "returns correct value on initial range + mid range" do
    # expect(perfect_bits(10,32)).to eq(7)
    # expect(perfect_bits(30, 64)).to eq(13)
    # expect(perfect_bits(100, 256)).to eq(46)
  end
  it "returns correct value on mid range + final range" do
    # expect(perfect_bits(16,39)).to eq(7)
    # expect(perfect_bits(16,40)).to eq(6)
    # expect(perfect_bits(16,43)).to eq(8)
    expect(perfect_bits(16,44)).to eq(7)
    # expect(perfect_bits(16,45)).to eq(9)
    # expect(perfect_bits(16,46)).to eq(10)
    expect(perfect_bits(16,47)).to eq(9)
    expect(perfect_bits(16,140)).to eq(39)
  end
  it "returns correct value with standard input" do
    expect(perfect_bits(345,3456345634563)).to eq(323630413180)
    # expect(perfect_bits(92233,9223372036854775807)).to eq(734248687150636052)
    # expect(perfect_bits(922337203999999,9223372036854775807)).to eq(734138882787809686)
    expect(perfect_bits(922337203685477,92233720368547758071234)).to eq(8065424262794935589144)
    expect(perfect_bits(3456345634563,3456345634563000)).to eq(393596500205643)
  end
end
