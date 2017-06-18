require 'byebug'
require 'base_helpers'
require 'mid_helpers'

def perfect_bits(num1, num2)
  return (is_perfect_bit?(num1) ? 1 : 0) if num1 == num2
  first_perfect_bit = is_perfect_bit?(num1) ? num1 : next_perfect_bit(num1)
  last_perfect_bit = is_perfect_bit?(num2) ? num2 : prev_perfect_bit(num2)
  return 1 if first_perfect_bit == last_perfect_bit
  count = 0

  if no_binary_bases_in_range?(first_perfect_bit, last_perfect_bit)
    prev_binary_base_before_range = prev_binary_base(first_perfect_bit)
    next_binary_base_beyond_range = next_binary_base(last_perfect_bit)

    #get count for full range
    count += count_perms_in_mid_range_noninclusive(prev_binary_base_before_range, next_binary_base_beyond_range)

    #subtract initial chunk before first_perfect_bit
    count -= count_perms_in_initial_range_noninclusive(prev_binary_base_before_range, first_perfect_bit)

    #subtract final chunk beyond last_perfect_bit
    count -= count_perms_in_final_range_inclusive(last_perfect_bit, next_binary_base_beyond_range)
  else
    count += count_perms_in_initial_range_noninclusive(first_perfect_bit, last_perfect_bit)
    count += count_perms_in_mid_range_noninclusive(first_perfect_bit, last_perfect_bit)
    count += count_perms_in_final_range_inclusive(first_perfect_bit, last_perfect_bit)
  end

  count
end
