require 'byebug'
require 'base_helpers'
require 'mid_helpers'

describe "#count_perms_in_mid_range_noninclusive" do
  it "returns 0 when no mid range exists" do
    expect(count_perms_in_mid_range_noninclusive(13,15)).to eq(0)
    expect(count_perms_in_mid_range_noninclusive(32,63)).to eq(0)
    expect(count_perms_in_mid_range_noninclusive(71,120)).to eq(0)


    expect(count_perms_in_mid_range_noninclusive((2**30),(2**31 - 1))).to eq(0)
    expect(count_perms_in_mid_range_noninclusive((2**30 + 1),(2**31 - 1))).to eq(0)
    expect(count_perms_in_mid_range_noninclusive((2**30 + 1),(2**31))).to eq(0)

    expect(count_perms_in_mid_range_noninclusive(9223372036854770000,9223372036854775000)).to eq(0)
  end

  it 'returns correct value when num1 and num2 are consecutive binary bases' do
    expect(count_perms_in_mid_range_noninclusive(32,64)).to eq(11)
    expect(count_perms_in_mid_range_noninclusive(2**30, 2**31)).to eq(161568281)
  end

  it "returns correct value on standard input" do
    expect(count_perms_in_mid_range_noninclusive(3,31)).to eq(3)
    expect(count_perms_in_mid_range_noninclusive(3,16)).to eq(3)
    expect(count_perms_in_mid_range_noninclusive(4,16)).to eq(3)

    expect(count_perms_in_mid_range_noninclusive(2,17)).to eq(4)
    expect(count_perms_in_mid_range_noninclusive(2,16)).to eq(4)

    expect(count_perms_in_mid_range_noninclusive(10,67)).to eq(16)
    expect(count_perms_in_mid_range_noninclusive(10,67)).to eq(16)
    expect(count_perms_in_mid_range_noninclusive(16,67)).to eq(16)

    expect(count_perms_in_mid_range_noninclusive(3,70)).to eq(19)
    expect(count_perms_in_mid_range_noninclusive(4,64)).to eq(19)
    expect(count_perms_in_mid_range_noninclusive(16,64)).to eq(16)
  end
end

describe "#count_perms_in_initial_range_noninclusive" do
  it "returns 0 when no initial range exists" do
    expect(count_perms_in_initial_range_noninclusive(13,15)).to eq(0)
    expect(count_perms_in_initial_range_noninclusive(32,63)).to eq(0)
    expect(count_perms_in_initial_range_noninclusive(32,64)).to eq(0)
    expect(count_perms_in_initial_range_noninclusive(71,120)).to eq(0)


    expect(count_perms_in_initial_range_noninclusive(2**30, 2**31)).to eq(0)
    expect(count_perms_in_initial_range_noninclusive((2**30),(2**31 - 100))).to eq(0)
  end

  it "returns correct value on standard input" do
    expect(count_perms_in_initial_range_noninclusive(3,4)).to eq(0)
    expect(count_perms_in_initial_range_noninclusive(3,31)).to eq(0)
    expect(count_perms_in_initial_range_noninclusive(23,32)).to eq(4)
    expect(count_perms_in_initial_range_noninclusive(25,32)).to eq(3)
    expect(count_perms_in_initial_range_noninclusive(27,32)).to eq(3)
    expect(count_perms_in_initial_range_noninclusive(28,32)).to eq(2)
    expect(count_perms_in_initial_range_noninclusive(54,64)).to eq(4)
    expect(count_perms_in_initial_range_noninclusive(54,70)).to eq(4)

    expect(count_perms_in_initial_range_noninclusive(65,128)).to eq(20)
    expect(count_perms_in_initial_range_noninclusive(100,128)).to eq(9)
    expect(count_perms_in_initial_range_noninclusive(1000,1024)).to eq(5)

    expect(count_perms_in_initial_range_noninclusive(16639, 32768)).to eq(3311)
    expect(count_perms_in_initial_range_noninclusive(16640, 32768)).to eq(3311)
    expect(count_perms_in_initial_range_noninclusive(16643, 32768)).to eq(3311)
    expect(count_perms_in_initial_range_noninclusive(16644, 32768)).to eq(3312)
    expect(count_perms_in_initial_range_noninclusive(29998, 32768)).to eq(651)
  end
end

describe "#count_perms_in_final_range_inclusive" do
  it "returns 0 when no final range exists" do
    expect(count_perms_in_final_range_inclusive(13,15)).to eq(0)
    expect(count_perms_in_final_range_inclusive(33,60)).to eq(0)
    expect(count_perms_in_final_range_inclusive(71,120)).to eq(0)


    expect(count_perms_in_final_range_inclusive((2**30 + 100),(2**31 - 1))).to eq(0)
    expect(count_perms_in_final_range_inclusive((9223372036854775000),(9223372036854775807))).to eq(0)
  end

  it "returns 1 when num2 is binary base" do
    expect(count_perms_in_final_range_inclusive(2,4)).to eq(1)
    expect(count_perms_in_final_range_inclusive(3,4)).to eq(1)

    expect(count_perms_in_final_range_inclusive(3,64)).to eq(1)
    expect(count_perms_in_final_range_inclusive(32,64)).to eq(1)

    expect(count_perms_in_final_range_inclusive(2**30, 2**31)).to eq(1)
    expect(count_perms_in_final_range_inclusive(1, 2**31)).to eq(1)
  end

  it "returns correct value on standard input" do
    expect(count_perms_in_final_range_inclusive(16,28)).to eq(3)
    expect(count_perms_in_final_range_inclusive(32,54)).to eq(8)
    expect(count_perms_in_final_range_inclusive(54,70)).to eq(1)
    expect(count_perms_in_final_range_inclusive(54,86)).to eq(8)

    expect(count_perms_in_final_range_inclusive(64,100)).to eq(12)
    expect(count_perms_in_final_range_inclusive(64,119)).to eq(20)
    expect(count_perms_in_final_range_inclusive(64,120)).to eq(21)

    expect(count_perms_in_final_range_inclusive(250,300)).to eq(17)
    expect(count_perms_in_final_range_inclusive(256,300)).to eq(17)

    expect(count_perms_in_final_range_inclusive(1024,2000)).to eq(152)
    expect(count_perms_in_final_range_inclusive(8192,16000)).to eq(1483)


    expect(count_perms_in_final_range_inclusive(16384,16400)).to eq(5)
    expect(count_perms_in_final_range_inclusive(16384,16600)).to eq(56)

    expect(count_perms_in_final_range_inclusive(16384,16625)).to eq(57)
    expect(count_perms_in_final_range_inclusive(16384,16635)).to eq(57)
    expect(count_perms_in_final_range_inclusive(16384,16636)).to eq(57)
    expect(count_perms_in_final_range_inclusive(16384,16637)).to eq(57)
    expect(count_perms_in_final_range_inclusive(16384,16638)).to eq(57)
    expect(count_perms_in_final_range_inclusive(16384,16639)).to eq(58)
    expect(count_perms_in_final_range_inclusive(16384,16640)).to eq(58)
    expect(count_perms_in_final_range_inclusive(16384,16650)).to eq(63)
    expect(count_perms_in_final_range_inclusive(16384,16700)).to eq(73)

    expect(count_perms_in_final_range_inclusive(16384,16776)).to eq(84)
    expect(count_perms_in_final_range_inclusive(16384,16783)).to eq(84)
    expect(count_perms_in_final_range_inclusive(16384,16784)).to eq(85)

    expect(count_perms_in_final_range_inclusive(16384,16800)).to eq(86)
    expect(count_perms_in_final_range_inclusive(16384,17000)).to eq(115)
    expect(count_perms_in_final_range_inclusive(16384,29997)).to eq(2717)
    expect(count_perms_in_final_range_inclusive(16384,29998)).to eq(2718)
    expect(count_perms_in_final_range_inclusive(16384,30000)).to eq(2718)

    expect(count_perms_in_final_range_inclusive(9223372036854775808, 9223372040000000000)).to eq(453973524)
  end
end
