class String
  def convert_base(from, to)
    self.to_i(from).to_s(to)
    # works up-to base 36
  end
end

def rijndeal_mod(element)
  case element
    when 8 then
      [4, 3, 1, 0]
    when 9 then
      [5, 4, 2, 1]
    when 10 then
      [6, 5, 3, 2]
    when 11 then
      [7, 6, 4, 3]
    when 12 then
      [7, 5, 3, 1, 0]
    when 13 then
      [6, 3, 2, 1]
    when 14 then
      [7, 4, 3, 1]
    else
      raise 'rijndeal mod error'
  end
end

first = ARGV[0]
second = ARGV[1]

raise 'Необходимо указать значения в шеснадцатеричном виде' if !first[/^[\w]{2}$/] || !second[/^[\w]{2}$/]

first = first.convert_base(16, 2)
second = second.convert_base(16, 2)

first = first.reverse.split('').map.with_index {|a, index| index if a == '1'}.compact.reverse
second = second.reverse.split('').map.with_index {|a, index| index if a == '1'}.compact.reverse

result_polinom = []

# умножаем полином на полином
first.each do |first_bite|
  second.each do |second_bite|
    result_polinom << (first_bite + second_bite)
  end
end

# складываем с одинаковыми степенями (xor)
result_polinom = result_polinom.group_by{|a| a }.map {|key, value| value.length % 2 != 0 ? key : nil }.compact.sort.reverse

max_elements = result_polinom.select {|a| a > 7}

max_elements.each do |max|
  result_polinom.delete(max)
  result_polinom << rijndeal_mod(max)
end

result_polinom = result_polinom.flatten.sort.join.gsub(/(\d)\1/, '').split('').map(&:to_i)

result = '00000000'

result_polinom.map {|a|
  result[-a - 1] = '1'
}

puts "RESULT: #{result.convert_base(2,16)}"
