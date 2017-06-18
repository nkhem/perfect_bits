require 'rspec'
require 'base_helpers'

describe "base two <=> base ten conversion methods" do
  describe "#binarify" do
    it "returns a string" do
      expect(binarify(1234)).to be_kind_of(String)
    end
    it "raises error if input is wrong type" do
      expect{ binarify('1010101') }.to raise_error('input must be an integer')
    end
    it "returns correct value" do
      expect(binarify(1234)).to eq('10011010010')
    end
  end

  describe "#base_tenify" do
    it "returns an integer" do
      expect(base_tenify('10011010010')).to be_kind_of(Integer)
    end
    it "raises error if input is wrong type" do
      expect{ base_tenify(1234) }.to raise_error('input must be a String')
    end
    it "returns correct value" do
      expect(base_tenify('10011010010')).to be(1234)
    end
  end
end

describe "perfect square helper methods" do
  describe "#prev_perfect_square" do
    it "returns correct value" do
      expect(prev_perfect_square(3*3)).to be(2*2)
      expect(prev_perfect_square(1235*1235)).to be(1234*1234)
    end
  end

  describe "#is_perfect_square?" do
    it "returns correct value" do
      expect(is_perfect_square?(2*2)).to be(true)
      expect(is_perfect_square?(1234*1234)).to be(true)
    end
  end

  describe "#next_perfect_square" do
    it "returns correct value" do
      expect(next_perfect_square(2*2)).to be(3*3)
      expect(next_perfect_square(1234*1234)).to be(1235*1235)
    end
  end
end

describe "perfect bit helper methods" do

  describe "#closest_prev_perfect_bit_has_same_ones_count" do
    it "handles edges" do
      expect(closest_prev_perfect_bit_has_same_ones_count('1')).to be(false)
      expect(closest_prev_perfect_bit_has_same_ones_count('10')).to be(true)
      expect(closest_prev_perfect_bit_has_same_ones_count('100')).to be(true)
      expect(closest_prev_perfect_bit_has_same_ones_count('1000')).to be(true)
      expect(closest_prev_perfect_bit_has_same_ones_count('10000')).to be(false)
    end
    it "returns correct value" do
      expect(closest_prev_perfect_bit_has_same_ones_count('1000000')).to be(false)
      expect(closest_prev_perfect_bit_has_same_ones_count('1000000111')).to be(false)
      expect(closest_prev_perfect_bit_has_same_ones_count('1000000110')).to be(false)
      expect(closest_prev_perfect_bit_has_same_ones_count('1000001110')).to be(true)
      expect(closest_prev_perfect_bit_has_same_ones_count('1011111111')).to be(false)
      expect(closest_prev_perfect_bit_has_same_ones_count('111111111')).to be(false)
    end
  end

  describe "#closest_prev_perfect_bit_ones_count" do
    it "handles edges" do
      expect{ closest_prev_perfect_bit_ones_count('1') }.to raise_error('invalid input')
      expect(closest_prev_perfect_bit_ones_count('10')).to be(1)
      expect(closest_prev_perfect_bit_ones_count('100')).to be(1)
      expect(closest_prev_perfect_bit_ones_count('1000')).to be(1)
      expect(closest_prev_perfect_bit_ones_count('10000')).to be(1)
    end
    it "returns correct value" do
      expect(closest_prev_perfect_bit_ones_count('1000000')).to be(4)
      expect(closest_prev_perfect_bit_ones_count('1000000111')).to be(1)
      expect(closest_prev_perfect_bit_ones_count('1000000110')).to be(1)
      expect(closest_prev_perfect_bit_ones_count('1000001110')).to be(4)
      expect(closest_prev_perfect_bit_ones_count('1011111111')).to be(4)
      expect(closest_prev_perfect_bit_ones_count('111111111')).to be(4)
    end
  end

  describe "#prev_perfect_bit" do
    it "raises errors when ones count inputed is greater than the number of slots in the base two num" do
      expect(prev_perfect_bit(38, 9)).to be(nil) #'100110'
      expect(prev_perfect_bit(63, 9)).to be(nil) #'111111'
      expect(prev_perfect_bit(67, 9)).to be(nil) #'1000011'
    end
    it "returns correct value when ones count of initial input == ones_count" do
      expect(prev_perfect_bit(16639)).to be(16608)
      expect(prev_perfect_bit(1099511627776)).to be(1099511627760)
    end
    it "returns correct value with one input" do
      expect(prev_perfect_bit(4, 1)).to be(2)
      expect(prev_perfect_bit(305, 4)).to be(297)
      expect(prev_perfect_bit(312, 4)).to be(308)
      expect(prev_perfect_bit(523, 4)).to be(519)
      expect(prev_perfect_bit(16639, 4)).to be(16608)
      expect(prev_perfect_bit(16639, 9)).to be(16352)
    end
    it "handles large inputs" do
      expect(prev_perfect_bit(2**64 + 2**44 + 2**34 + 2**24 + 2**2)).to eq(2**64 + 2**44 + 2**34 + 2**24)
      expect(prev_perfect_bit(2**64 + 2**2 + 2**1 + 2**0)).to eq(2**64)
      expect(prev_perfect_bit(2**64 + 2**2 + 2**1 + 2**0, 1)).to eq(2**64)
      expect(prev_perfect_bit(2**64 + 2**10 + 2**9 + 2**8)).to eq(2**64 + 2**10 + 2**9 + 2**7)
    end
  end

  describe "#is_perfect_bit?" do
    it "returns correct value" do
      expect(is_perfect_bit?(4)).to be(true)
      expect(is_perfect_bit?(523)).to be(true)
      expect(is_perfect_bit?(1099511627776)).to be(true)

      expect(is_perfect_bit?(3)).to be(false)
      expect(is_perfect_bit?(520)).to be(false)
      expect(is_perfect_bit?(1099511627775)).to be(false)
    end
  end

  describe "#next_perfect_bit" do
    it "returns correct value" do
      expect(next_perfect_bit(4)).to be(8)
      expect(next_perfect_bit(512)).to be(519)
      expect(next_perfect_bit(1099511627775)).to be(1099511627776)
    end
  end
end

describe "binary base helper methods" do
  describe "#prev_binary_base" do
    it "handles base cases" do
      expect(prev_binary_base(0)).to be(nil)
      expect(prev_binary_base(1)).to be(0)
      expect(prev_binary_base(2)).to be(1)
    end
    it "returns correct value with small input value" do
      expect(prev_binary_base(3)).to be(2)
      expect(prev_binary_base(4)).to be(2)
      expect(prev_binary_base(5)).to be(4)
      expect(prev_binary_base(2**10)).to eq(2**9)
    end
    it "returns correct value with large input value" do
      expect(prev_binary_base(2**2345 - 1)).to eq(2**2344)
      expect(prev_binary_base(2**2345)).to eq(2**2344)
      expect(prev_binary_base(2**2345 + 1)).to eq(2**2345)
    end
  end

  describe "#is_binary_base?" do
    it "returns correct value" do
      expect(is_binary_base?(2**0)).to be(true)
      expect(is_binary_base?(2**2345)).to be(true)
      expect(is_binary_base?(2**2345 + 1)).to be(false)
    end
  end

  describe "#next_binary_base" do
    it "handles base case properly" do
      expect(next_binary_base(0)).to eq(1)
      expect(next_binary_base(1)).to eq(2)
      expect(next_binary_base(2)).to eq(4)
    end
    it "returns correct value with small input value" do
      expect(next_binary_base(2**0)).to eq(2**1)
      expect(next_binary_base(2**9)).to eq(2**10)
    end
    it "returns correct value with large input value" do
      expect(next_binary_base(2**2345 - 1)).to eq(2**2345)
      expect(next_binary_base(2**2345)).to eq(2**2346)
      expect(next_binary_base(2**2345 + 1)).to eq(2**2346)
    end
  end

  describe "#initial_base_ten_binary_base_in_range" do
    it "returns correct value for edge cases" do
      expect(initial_base_ten_binary_base_in_range(16, 20)).to eq(16)
      expect(initial_base_ten_binary_base_in_range(16, 32)).to eq(16)
      expect(initial_base_ten_binary_base_in_range(512, 9223372036854775808)).to eq(512)
      expect(initial_base_ten_binary_base_in_range(9223372036854775808, 9223372036854776000)).to eq(9223372036854775808)

      expect(initial_base_ten_binary_base_in_range(0, 0)).to be(nil)
      expect(initial_base_ten_binary_base_in_range(0, 1)).to be(1)
      expect(initial_base_ten_binary_base_in_range(0, 2)).to be(1)
      expect(initial_base_ten_binary_base_in_range(0, 2)).to eq(1)
      expect(initial_base_ten_binary_base_in_range(1, 2)).to eq(1)
      expect(initial_base_ten_binary_base_in_range(10, 16)).to eq(16)
      expect(initial_base_ten_binary_base_in_range(500, 512)).to eq(512)
      expect(initial_base_ten_binary_base_in_range(9223372036854775000, 9223372036854775808)).to eq(9223372036854775808)
    end

    it "returns nil when does not exist" do
      expect(initial_base_ten_binary_base_in_range(17, 20)).to be(nil)
      expect(initial_base_ten_binary_base_in_range(300, 511)).to be(nil)
      expect(initial_base_ten_binary_base_in_range(9223372036854775000, 9223372036854775807)).to be(nil)
    end

    it "returns correct value with standard inputs" do
      expect(initial_base_ten_binary_base_in_range(10, 20)).to eq(16)
      expect(initial_base_ten_binary_base_in_range(500, 9223372036854775807)).to eq(512)
      expect(initial_base_ten_binary_base_in_range(10, 9223372036854775807)).to eq(16)
    end
  end

  describe "#final_binary_base_in_range" do
    it "returns correct value with edge inputs" do
      expect(final_base_ten_binary_base_in_range(10, 16)).to eq(16)
      expect(final_base_ten_binary_base_in_range(300, 512)).to eq(512)
      expect(final_base_ten_binary_base_in_range(1234, 9223372036854775808)).to eq(9223372036854775808)

      expect(final_base_ten_binary_base_in_range(16, 20)).to eq(16)
      expect(final_base_ten_binary_base_in_range(512, 600)).to eq(512)
      expect(final_base_ten_binary_base_in_range(9223372036854775808, 9223372036854776000)).to eq(9223372036854775808)
    end

    it "returns nil when does not exist" do
      expect(final_base_ten_binary_base_in_range(17, 20)).to be(nil)
      expect(final_base_ten_binary_base_in_range(300, 511)).to be(nil)
      expect(final_base_ten_binary_base_in_range(9223372036854775000, 9223372036854775807)).to be(nil)
    end

    it "returns correct value with standard inputs" do
      expect(final_base_ten_binary_base_in_range(10, 20)).to eq(16)
      expect(final_base_ten_binary_base_in_range(500, 9223372036854776000)).to eq(9223372036854775808)
    end
  end
end

describe "combinatoric helper methods" do
  describe "#factorial" do
    it "handles base case properly" do
      expect(factorial(0)).to be(1)
      expect(factorial(1)).to be(1)
    end
    it "returns correct value" do
      expect(factorial(4)).to be(24)
      expect(factorial(20)).to be(2432902008176640000)
    end
  end

  describe "#prev_permutation" do
    it "handles base case properly" do
      expect(prev_permutation('1')).to eq(nil)
      expect(prev_permutation('10')).to eq(nil)
      expect(prev_permutation('100000')).to eq(nil)
      expect(prev_permutation('100111')).to eq(nil)
      expect(prev_permutation('1111')).to eq(nil)
    end
    it "returns correct value" do
      expect(prev_permutation('10010')).to eq('10001')
      expect(prev_permutation('1001010101')).to eq('1001010011')
    end
  end

  describe "#uniq_permutations_count" do
  end

  describe "#uniq_permutations_count_w_set_ones_and_zeroes" do
  end

  describe "#prev_permutations_count" do
    it "raises error if given an imperfect bit" do
      expect{ prev_permutations_count(40, 1) }.to raise_error('only accepts perfect bits')
      expect{ prev_permutations_count(127, 1) }.to raise_error('only accepts perfect bits')
      expect{ prev_permutations_count(16640, 9) }.to raise_error('only accepts perfect bits')
    end

    it "returns 0 when no lesser permutations exist" do
      expect(prev_permutations_count(39, 4)).to be(0)
      expect(prev_permutations_count(71, 4)).to be(0)
      expect(prev_permutations_count(32775, 4)).to be(0)
      expect(prev_permutations_count(1048831, 9)).to be(0)

      expect(prev_permutations_count(2**0, 1)).to be(0)
      expect(prev_permutations_count(2**1, 1)).to be(0)
      expect(prev_permutations_count(2**2, 1)).to be(0)
      expect(prev_permutations_count(2**5, 1)).to be(0)
      expect(prev_permutations_count(2**14, 1)).to be(0)

      expect(prev_permutations_count((2**1 - 1), 1)).to be(0)
      expect(prev_permutations_count((2**16 - 1), 16)).to be(0)
      expect(prev_permutations_count((2**64 - 1), 64)).to be(0)
    end

    it "returns correct value when second arg is the ones count of the binary representation of the first arg" do
      expect(prev_permutations_count(39, 4)).to be(0)
      expect(prev_permutations_count(53, 4)).to be(5)
      expect(prev_permutations_count(60, 4)).to be(9)
      expect(prev_permutations_count(71, 4)).to be(0)
      expect(prev_permutations_count(99, 4)).to be(10)
      expect(prev_permutations_count(120, 4)).to be(19)
      expect(prev_permutations_count(267, 4)).to be(1)
      expect(prev_permutations_count(512, 1)).to be(0)
      expect(prev_permutations_count(519, 4)).to be(0)
      expect(prev_permutations_count(16639, 9)).to be(0)
      expect(prev_permutations_count(16643, 4)).to be(56)
    end

    it "returns 1 when square passed as second arg is 1 and num isn't binary base" do
      expect(prev_permutations_count(267, 1)).to be(1)
      expect(prev_permutations_count(16643, 1)).to be(1)
    end

    it "returns correct value with standard input" do
      # expect(prev_permutations_count(16639, 4)).to be('asdf')
      expect(prev_permutations_count(16639, 9)).to be(0)
      # expect(prev_permutations_count(16643, 4)).to be(56)
      expect(prev_permutations_count(16643, 9)).to be(1)
    end
  end
end

describe "miscellaneous helper methods" do
  describe "#no_binary_bases_in_range?" do
    it "handles edges properly" do
      expect(no_binary_bases_in_range?(0, 0)).to be(true)
      expect(no_binary_bases_in_range?(0, 1)).to be(false)
      expect(no_binary_bases_in_range?(0, 2)).to be(false)
      expect(no_binary_bases_in_range?(1, 1)).to be(false)
      expect(no_binary_bases_in_range?(1, 2)).to be(false)

      expect(no_binary_bases_in_range?(15, 15)).to be(true)
      expect(no_binary_bases_in_range?(16, 16)).to be(false)

      expect(no_binary_bases_in_range?(16, 30)).to be(false)
      expect(no_binary_bases_in_range?(20, 32)).to be(false)

      expect(no_binary_bases_in_range?(511, 512)).to be(false)
      expect(no_binary_bases_in_range?(512, 513)).to be(false)
    end
    it "returns correct value on standard input" do
      expect(no_binary_bases_in_range?(20, 40)).to be(false)
      expect(no_binary_bases_in_range?(511, 513)).to be(false)

      expect(no_binary_bases_in_range?(20, 31)).to be(true)
      expect(no_binary_bases_in_range?(511, 513)).to be(false)
    end
  end

  describe "#has_min_two_binary_bases_in_range?" do
    it "returns false when no bases in range" do
      expect(has_min_two_binary_bases_in_range?(20, 20)).to be(false)
      expect(has_min_two_binary_bases_in_range?(20, 21)).to be(false)
      expect(has_min_two_binary_bases_in_range?(20, 31)).to be(false)
      expect(has_min_two_binary_bases_in_range?(263, 300)).to be(false)
    end
    it "returns false when one base in range" do
      expect(has_min_two_binary_bases_in_range?(20, 40)).to be(false)
      expect(has_min_two_binary_bases_in_range?(32, 40)).to be(false)
      expect(has_min_two_binary_bases_in_range?(256, 300)).to be(false)
      expect(has_min_two_binary_bases_in_range?(200, 256)).to be(false)
    end

    it "returns true when input values are binary bases, and no binary bases exist between" do
      expect(has_min_two_binary_bases_in_range?(16, 32)).to be(true)
      expect(has_min_two_binary_bases_in_range?(256, 512)).to be(true)
    end

    it "returns true when one input value is binary base, and one binary base exists mid range" do
      expect(has_min_two_binary_bases_in_range?(16, 40)).to be(true)
      expect(has_min_two_binary_bases_in_range?(200, 512)).to be(true)
    end

    it "returns true when exactly two binary bases exist mid range" do
      expect(has_min_two_binary_bases_in_range?(250, 600)).to be(true)
      expect(has_min_two_binary_bases_in_range?(10, 40)).to be(true)
    end

    it "returns correct value on standard input" do
      expect(has_min_two_binary_bases_in_range?(300, 500)).to be(false)
      expect(has_min_two_binary_bases_in_range?(1234, 9223372036854775808)).to be(true)
      expect(has_min_two_binary_bases_in_range?(1234, 9223372036854775000)).to be(true)
      expect(has_min_two_binary_bases_in_range?(9223372036854775000, 9223372036854776000)).to be(false)
    end
  end

  describe "#static_chunk" do
    it "returns binary representation of input when is a binary base" do
      expect(static_chunk(2**0)).to eq('1')
      expect(static_chunk(2**1)).to eq('10')
      expect(static_chunk(2**2)).to eq('100')
      expect(static_chunk(2**3)).to eq('1000')
      expect(static_chunk(2**14)).to eq('100000000000000')
    end
    it "returns '' when binary representation of input is exclusively ones" do
      expect(static_chunk(2**1 - 1)).to eq('1')
      expect(static_chunk(2**2 - 1)).to eq('11')
      expect(static_chunk(2**3 - 1)).to eq('111')
      expect(static_chunk(2**14 - 1)).to eq('11111111111111')
    end
    it "returns correct value on standard input" do
      expect(static_chunk(5)).to eq('10')
      expect(static_chunk(6)).to eq('1')
      expect(static_chunk(9)).to eq('100')
      expect(static_chunk(16639)).to eq('1000000')
      expect(static_chunk(16640)).to eq('100000')
      expect(static_chunk(16643)).to eq('100000')
      expect(static_chunk(922)).to eq('1')
      expect(static_chunk(9223372)).to eq('1000')
      expect(static_chunk(922337203685477500)).to eq('1')
    end
  end

  describe "#dynamic_chunk" do
    it "returns '' when input is binary base" do
      expect(dynamic_chunk(2**0)).to eq('')
      expect(dynamic_chunk(2**1)).to eq('')
      expect(dynamic_chunk(2**2)).to eq('')
      expect(dynamic_chunk(2**3)).to eq('')
      expect(dynamic_chunk(2**14)).to eq('')
    end
    it "returns '' when binary representation of input is exclusively ones" do
      expect(dynamic_chunk(2**1 - 1)).to eq('')
      expect(dynamic_chunk(2**2 - 1)).to eq('')
      expect(dynamic_chunk(2**3 - 1)).to eq('')
      expect(dynamic_chunk(2**14 - 1)).to eq('')
    end
    it "returns correct value on standard input" do
      expect(dynamic_chunk(5)).to eq('1')
      expect(dynamic_chunk(6)).to eq('10')
      expect(dynamic_chunk(9)).to eq('1')
      expect(dynamic_chunk(16639)).to eq('11111111')
      expect(dynamic_chunk(16640)).to eq('100000000')
      expect(dynamic_chunk(16643)).to eq('100000011')
      expect(dynamic_chunk(922)).to eq('110011010')
      expect(dynamic_chunk(9223372)).to eq('11001011110011001100')
      expect(dynamic_chunk(922337203685477500)).to eq('10011001100110011001100110011001100110011001100110001111100')
    end

    it "#static_chunk and #dynamic_chunk complement each other" do
      expect(static_chunk(5) + dynamic_chunk(5)).to eq(5.to_s(2))
      expect(static_chunk(6) + dynamic_chunk(6)).to eq(6.to_s(2))
      expect(static_chunk(16639) + dynamic_chunk(16639)).to eq(16639.to_s(2))
      expect(static_chunk(16640) + dynamic_chunk(16640)).to eq(16640.to_s(2))
      expect(static_chunk(16643) + dynamic_chunk(16643)).to eq(16643.to_s(2))
      expect(static_chunk(922337203685477500) + dynamic_chunk(922337203685477500)).to eq(922337203685477500.to_s(2))
    end
  end
end
