require 'byebug'
require 'base_helpers'

def count_perms_in_mid_range_noninclusive(num1, num2)
  return 0 unless has_min_two_binary_bases_in_range?(num1, num2)
  min_binary_o_of_mag = binary_order_of_magnitude(initial_base_ten_binary_base_in_range(num1, num2))
  max_binary_o_of_mag = binary_order_of_magnitude(final_base_ten_binary_base_in_range(num1, num2))

  count = 0

  current_sq = 1
  current_o_of_mag = min_binary_o_of_mag

  while current_o_of_mag < max_binary_o_of_mag
    count += uniq_permutations_count((current_sq - 1), current_o_of_mag)
    next_sq = next_perfect_square(current_sq)

    if next_sq > max_binary_o_of_mag
      current_o_of_mag += 1
      current_sq = 1
    else
      current_sq = next_sq
    end
  end
#
  count
end


def count_perms_in_initial_range_noninclusive(num1, num2)
  return 0 if is_binary_base?(num1) || num1 == num2

  initial_range_start_num = is_perfect_bit?(num1) ? num1 : next_perfect_bit(num1)
  initial_range_end_num = next_binary_base(initial_range_start_num)

  return 0 unless is_in_inclusive_range?(initial_range_start_num, [num1, num2])
  return 0 unless is_in_inclusive_range?(initial_range_end_num, [num1, num2])
  return 0 if is_binary_base?(initial_range_start_num)

  pre_range_binary_base = prev_binary_base(initial_range_start_num)
  count = count_perms_in_mid_range_noninclusive(pre_range_binary_base, initial_range_end_num)
  count -= prev_permutations_count_broken_set(initial_range_start_num)

  count
end

def count_perms_in_final_range_inclusive(num1, num2)
  return 0 if no_binary_bases_in_range?(num1, num2)
  return 1 if is_binary_base?(num2)

  initial_num_in_final_range = final_base_ten_binary_base_in_range(num1, num2)
  final_num_in_final_range = is_perfect_bit?(num2) ? num2 : prev_perfect_bit(num2)

  return 1 if initial_num_in_final_range === final_num_in_final_range
  next_binary_base_beyond_range = next_binary_base(num2)

  count = 0
  count += 1 if is_perfect_bit?(final_num_in_final_range)

  #count number of perms that would exist if the range end was actually the next binary base
  count += count_perms_in_mid_range_noninclusive(initial_num_in_final_range, next_binary_base_beyond_range)

  #subtract perms in initial range of that
  count -= count_perms_in_initial_range_noninclusive(final_num_in_final_range, next_binary_base_beyond_range)

  count
end
