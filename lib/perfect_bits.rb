require 'byebug'
require 'base_helpers'
require 'mid_helpers'

def perfect_bits(num1, num2)
  return (is_perfect_bit?(num1) ? 1 : 0) if num1 == num2
  num1 = is_perfect_bit?(num1) ? num1 : next_perfect_bit(num1)
  num2 = is_perfect_bit?(num2) ? num2 : prev_perfect_bit(num2)
  count = 0

  if no_binary_bases_in_range?(num1, num2)
    prev_binary_base_before_range = prev_binary_base(num1)
    next_binary_base_beyond_range = next_binary_base(num2)

    #get count for full range
    count += count_perms_in_mid_range_noninclusive(prev_binary_base_before_range, next_binary_base_beyond_range)

    #subtract initial chunk before num1
    count -= count_perms_in_initial_range_noninclusive(prev_binary_base_before_range, num1)

    #subtract final chunk beyond num2
    count -= count_perms_in_final_range_inclusive(num2, next_binary_base_beyond_range)
  else
    count += count_perms_in_initial_range_noninclusive(num1, num2)
    count += count_perms_in_mid_range_noninclusive(num1, num2)
    count += count_perms_in_final_range_inclusive(num1, num2)
  end

  count
end
