require 'byebug'

#### base two <=> base ten conversion methods ####
def binarify(base_ten_num)
  raise 'input must be an integer' if base_ten_num.is_a?(String)
  base_ten_num.to_s(2)
end

def base_tenify(base_two_num)
  raise 'input must be a String' unless base_two_num.is_a?(String)
  base_two_num.to_i(2)
end

def binary_ones_count(base_ten_num)
  binarify(base_ten_num).count('1')
end

#### perfect square helper methods ####
def is_perfect_square?(num)
  return false if num < 1
  Math.sqrt(num) % 1 === 0
end

def next_perfect_square(num)
  return 1 if num < 1
  is_perfect_square?(num) ? next_perfect_square(num + 1) : Math.sqrt(num).ceil**2
end

def prev_perfect_square(num)
  return nil if num <= 1
  is_perfect_square?(num) ? prev_perfect_square(num - 1) : Math.sqrt(num).floor**2
end

#### perfect bit helper methods ####
def is_perfect_bit?(base_ten_num)
  is_perfect_square?(binary_ones_count(base_ten_num))
end

def is_goal_perfect_bit?(base_ten_num, ones_count)
  base_two_num = binarify(base_ten_num)
  is_perfect_bit?(base_ten_num) && base_two_num.count('1') == ones_count
end

def next_perfect_bit(base_ten_num, is_initial_recursion = true)
  return 1 if base_ten_num < 1

  if is_initial_recursion || !is_perfect_bit?(base_ten_num)
    next_num = base_ten_num + 1
    return next_perfect_bit(next_num, false)

  # cut out when hits a perfect bit that isn't the initial num
  elsif is_perfect_bit?(base_ten_num)
    return base_ten_num
  end
end

def prev_perfect_bit(base_ten_num, ones_count = nil, is_initial_recursion = true)
  return base_ten_num if is_goal_perfect_bit?(base_ten_num, ones_count) && !is_initial_recursion
  base_two_num = binarify(base_ten_num)

  return nil if !!ones_count && (ones_count > base_two_num.length) # '100110', 9
  return nil if base_ten_num < 1
  return base_tenify(base_two_num.slice(0..base_two_num.length-2)) if base_ten_num <= 8 #'100'=> '10'

  ones_count ||= closest_prev_perfect_bit_ones_count(base_two_num)
  return nil unless ones_count

  res = adjust_ones_count(base_two_num, ones_count) if base_two_num.count('1') != ones_count
  res ||= base_two_num.dup

  if base_two_num.count('1') != ones_count
    res = adjust_ones_count(base_two_num, ones_count)
    return base_tenify(res)
  elsif !has_dynamic_one?(res)
    res = drop_one_o_of_mag(base_two_num, ones_count)
    res = base_tenify(res)
    return is_goal_perfect_bit?(res, ones_count) ? res : prev_perfect_bit(res, ones_count, false)
  else
    res = base_tenify(prev_permutation(base_two_num))
    return res if is_goal_perfect_bit?(res, ones_count)
  end
end

def drop_one_o_of_mag(base_two_num, ones_count) #'10011', 4 # '1111', 1
  res_desired_length = base_two_num.length - 1
  res = ''
  res += '1' * ones_count
  res += '0' * (res_desired_length - res.length)
  res
end #=> '1111' #=> '1000'

def adjust_ones_count(base_two_num, ones_count) #'10100100', 4
  base_ten_num = base_tenify(base_two_num)
  if base_two_num.count('1') < ones_count
    add_ones(base_two_num, ones_count)
  elsif base_two_num.count('1') > ones_count
    subtract_ones(base_two_num, ones_count)
  end
end # => '100111'

def add_ones(base_two_num, ones_count) #'10100100', 4
  res = base_two_num
  should_shift_final_dynamic_one = true

  until res.count('1') == ones_count
    if has_dynamic_one?(res)
      if should_shift_final_dynamic_one #'10100010'
        temp_res = shift_final_dynamic_one_right(res)
        filled_last_zero = final_zero_idx(temp_res) < final_zero_idx(res)  ? true : false
        should_shift_final_dynamic_one = filled_last_zero ? true : false
        if filled_last_zero
          res = temp_res.dup
          next
        end
      else
        temp_res = res.dup
      end

      first_final_dyn_zero_idx = index_of_first_final_dynamic_zero(temp_res)
      temp_res[first_final_dyn_zero_idx] = '1' unless filled_last_zero
      filled_last_zero = (first_final_dyn_zero_idx == final_zero_idx(res))
      should_shift_final_dynamic_one = filled_last_zero ? true : false
      res = temp_res.dup
    else
      res = drop_one_o_of_mag(res, ones_count)
    end
  end
  res
end

def final_zero_idx(base_two_num)
  (base_two_num.length - 1) - base_two_num.reverse.index('0')
end

def final_one_idx(base_two_num)
  (base_two_num.length - 1) - base_two_num.reverse.index('1')
end

def subtract_ones(base_two_num, ones_count)
  return nil if base_two_num.length < ones_count
  res = base_two_num.dup

  until res.count('1') == ones_count
    return nil if final_one_idx(res) == 0
    res[final_one_idx(res)] = '0'
  end

  res
end

def prev_perfect_bit_expensive(base_ten_num, ones_count = nil, is_initial_recursion = true)
  return nil if base_ten_num < 1
  base_two_num = binarify(base_ten_num)

  has_wrong_ones_count = !!ones_count && (ones_count != base_two_num.count('1'))

  if is_initial_recursion || !is_perfect_bit?(base_ten_num) || has_wrong_ones_count
    prev_num = base_ten_num - 1
    return prev_perfect_bit(prev_num, ones_count, false)

  # cut out when hits a perfect bit that isn't the initial num
  elsif is_perfect_bit?(base_ten_num) && !has_wrong_ones_count
    return base_ten_num
  end
end

def closest_prev_perfect_bit_ones_count(base_two_num)
  # debugger if base_two_num == '1000000110'

  raise 'invalid input' if base_tenify(base_two_num) < 2
  return 1 if base_tenify(base_two_num) < 15
  if closest_prev_perfect_bit_has_same_ones_count(base_two_num)
    base_two_num.count('1')
  elsif base_two_num.count('1') == 1
    return prev_perfect_square(base_two_num.length - 1)
  else
    # debugger if base_two_num = binarify(1099511627776)
    return prev_perfect_square(base_two_num.count('1'))
  end
end

def closest_prev_perfect_bit_has_same_ones_count(base_two_num)
  return false if base_tenify(base_two_num) < 2 #<'10'
  return true if base_two_num.length <= 4 && base_two_num.count('1') == 1 #'100'

  wo_initial_one = base_two_num.chars.drop(1)
  wo_immediate_zeroes = wo_initial_one.index('1') ? wo_initial_one.drop(wo_initial_one.index('1')) : []
  has_room = wo_immediate_zeroes.include?('0') || wo_immediate_zeroes.length > base_two_num.count('1')
  is_perfect_square?(base_two_num.count('1')) && has_room
end


#### binary base helper methods ####
def is_binary_base?(num)
  binarify(num).count('1') == 1
end

def next_binary_base(base_ten_num)
  return 0 if base_ten_num < 0
  return 1 if base_ten_num == 0
  next_base = 2**(binary_order_of_magnitude(base_ten_num) + 1)
end

def prev_binary_base(base_ten_num)
  return nil if base_ten_num < 1
  return 0 if base_ten_num === 1
  return base_ten_num - 1 if base_ten_num < 3

  prev_base = 2**(binary_order_of_magnitude(base_ten_num))
  prev_base === base_ten_num ? prev_binary_base(prev_base - 1) : prev_base
end

def initial_base_ten_binary_base_in_range(num1, num2)
  return nil if num2 < 1
  return num1 if is_binary_base?(num1)
  next_base = next_binary_base(num1)
  return next_base if next_base <= num2
  nil
end

def final_base_ten_binary_base_in_range(num1, num2)
  return num2 if is_binary_base?(num2)
  prev_base = prev_binary_base(num2)
  return prev_base if prev_base >= num1
  nil
end


#### combinatoric helper methods ####
def factorial(n)
  (1..n).inject(:*) || 1
end

def index_of_final_dynamic_one(base_two_num)
  return nil unless base_two_num.count('0') > 0
  base_two_num_rev = base_two_num.reverse

  # index of final zero
  final_zero_idx_rev = base_two_num_rev.index('0')

  # index of closest one to the left of that
  final_one_idx_rev = base_two_num_rev.slice((final_zero_idx_rev + 1)..base_two_num_rev.length-1).index('1')
  final_one_idx = base_two_num.length - (final_zero_idx_rev + 1) - (final_one_idx_rev + 1)

  return nil if final_one_idx.zero? #'100011'
  final_one_idx
end

def index_of_first_final_dynamic_zero(base_two_num)
  if has_dynamic_one?(base_two_num)
    index_of_final_dynamic_one(base_two_num) + 1
  else
    nil
  end
end

def has_dynamic_one?(base_two_num)
  !!(index_of_final_dynamic_one(base_two_num))
end

def shift_final_dynamic_one_right(base_two_num)
  bits_arr = base_two_num.chars
  index_of_final_dynamic_one = index_of_final_dynamic_one(base_two_num)
  bits_arr[index_of_final_dynamic_one] = '0'
  bits_arr[index_of_final_dynamic_one + 1] = '1'
  bits_arr.join('')
end

# def shift_first_dynamic_one_right(base_two_num)
#   return nil unless has_dynamic_one?(base_two_num)
#   base_ten_num = base_tenify(base_two_num)
#
#   static_chunk = static_chunk(base_ten_num)
#   dynamic_chunk = dynamic_chunk(base_ten_num)
#   first_dyn_one_idx = dynamic_chunk.index('1')
#   first_dyn_zero_idx = dynamic_chunk.index('0')
#
#   dynamic_chunk[first_dyn_one_idx] = '0'
#   dynamic_chunk[first_dyn_zero_idx] = '1'
#
#   static_chunk + dynamic_chunk
# end
#
# def first_dynamic_zero_idx(base_two_num)
#   return nil unless has_dynamic_one?(base_two_num)
#   base_ten_num = base_tenify(base_two_num)
#   first_dyn_zero_idx = dynamic_chunk(base_ten_num).index('0')
# end

def prev_permutation(base_two_num)
  if has_dynamic_one?(base_two_num)
    shift_final_dynamic_one_right(base_two_num)
  else
    nil
  end
end

#how many 3-digit unique permutation sets exist with n possible nums
def uniq_permutations_count(slots_count, nums_count)
  uniq_perms_count = factorial(nums_count)/factorial(nums_count - slots_count)
  uniq_perms_count/factorial(slots_count)
end

def uniq_permutations_count_w_set_ones_and_zeroes(ones_count, zeroes_count)
  factorial(ones_count + zeroes_count)/(factorial(ones_count) * factorial(zeroes_count))
end

def prev_permutations_count(base_ten_or_two_num, ones_count_goal)
  base_ten_num = !base_ten_or_two_num.is_a?(String) ? base_ten_or_two_num : binarify(base_ten_or_two_num)
  base_two_num = binarify(base_ten_num)
  raise 'only accepts perfect bits' unless is_perfect_bit?(base_ten_num)

  # set bits arr to relevant base_ten_num
  # debugger if base_ten_or_two_num == 16643 && ones_count_goal == 9
  count = 0
  if base_two_num.count('1') == ones_count_goal
    dynamic_chunk = dynamic_chunk(base_ten_num)
    static_chunk = static_chunk(base_ten_num)
    bits_arr = dynamic_chunk.chars
  else
    initial_binary_base = prev_binary_base(base_ten_num)
    prev_bit = prev_perfect_bit(base_ten_num, ones_count_goal)
    count += 1 if is_goal_perfect_bit?(prev_bit, ones_count_goal)
    return 0 if prev_bit < initial_binary_base
    bits_arr = dynamic_chunk(prev_bit).chars
  end

  # take care of base cases
  return 1 if ones_count_goal && ones_count_goal == 1 && !is_binary_base?(base_ten_num) #'11111', and ones_count_goal == 1
  return 0 if base_two_num.count('1') < 2 #'100000000'
  return 0 if !base_two_num.index('0') && !ones_count_goal #'111111111'
  # debugger if base_two_num.count('1') != ones_count_goal

  # count previous permutations
  only_ones_remain = false

  until bits_arr.length <= 1 || only_ones_remain

    if bits_arr.first == '1'
      ones_count = bits_arr.count('1')
      zeroes_count = bits_arr.count('0')
      only_ones_remain = zeroes_count.zero?

      unless only_ones_remain
        zeroes_count -= 1
        count += uniq_permutations_count_w_set_ones_and_zeroes(ones_count, zeroes_count)
      end
    end
    bits_arr.shift
  end

  count
end

def prev_permutations_count_broken_set(base_ten_num)

  dynamic_chunk = dynamic_chunk(base_ten_num)
  dynamic_slots_count = dynamic_chunk.length
  highest_possible_sq = is_perfect_square?(dynamic_slots_count + 1) ? dynamic_slots_count + 1 : prev_perfect_square(dynamic_slots_count + 1)
  current_sq = highest_possible_sq

  count = 0

  while current_sq
    count += prev_permutations_count(base_ten_num, current_sq) # this might go lower that prev binary base
    current_sq = prev_perfect_square(current_sq)
  end

  count
end

### miscellaneous helper methods ###
def binary_order_of_magnitude(base_ten_num)
  binarify(base_ten_num).chars.count - 1
end

def remove_index(arr, idx)
  arr.slice(0...idx) + arr.slice((idx + 1)..arr.length)
end

def no_binary_bases_in_range?(num1, num2) #(16,32) deliberately returns true
  return !is_binary_base?(num1) if num1 == num2
  return false if is_binary_base?(num1) || is_binary_base?(num2)
  (next_binary_base(num1) > num2) && prev_binary_base(num2) && (prev_binary_base(num2) < num1)
end

def has_min_two_binary_bases_in_range?(num1, num2)
  return false if num1 == num2
  binary_bases = []
  binary_bases << num1 if is_binary_base?(num1)
  binary_bases << num2 if is_binary_base?(num2)

  first_binary_base = next_binary_base(num1)
  last_binary_base = prev_binary_base(num2)

  binary_bases << first_binary_base if first_binary_base < num2
  binary_bases << last_binary_base if last_binary_base > num1

  binary_bases.uniq.count >= 2
end

def is_in_inclusive_range?(x, range)
  x >= range[0] && x <= range[1]
end

def static_chunk(base_ten_num)# => excludes first one in output
  base_two_num = binarify(base_ten_num)

  first_zero_idx = base_two_num.index('0')
  return base_two_num if is_binary_base?(base_ten_num) || !first_zero_idx
  return '1' if first_zero_idx > 1

  second_one_idx = first_zero_idx + base_two_num.slice(base_two_num.index('0')..base_two_num.length - 1).index('1')
  base_two_num.slice(0...second_one_idx)
end

# if start out with '100111000', the initial '100' must stay fixed and we're only concerned with '111000' if we're curious about permutations of lesser base value.
def dynamic_chunk(base_ten_num) #=>inncludes first 1 in output
  base_two_num = binarify(base_ten_num)
  base_two_num.slice(static_chunk(base_ten_num).length..(base_two_num.length - 1))
end
