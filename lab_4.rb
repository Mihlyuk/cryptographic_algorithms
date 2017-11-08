require_relative 'algorithms/algorithms_lab4.rb'
require_relative 'algorithms/algorithms_lab3.rb'
require 'colorize'

def pretty(array)
  array.map do |m|
    "#{m}\n"
  end.join('')
end

f = [
    [1, 2, 3, 4, 5, 6, 7],
    [5, 7, 2, 4, 6, 1, 3]
]

g = [
    [1, 2, 3, 4, 5, 6, 7],
    [4, 7, 3, 6, 2, 5, 1]
]

m = [18, 9]

#==============================================================================

puts "\n=========================================".green
puts "#{'f'.cyan} = \n#{pretty(f)}\n"
puts "#{'g'.cyan} = \n#{pretty(g)}\n"
puts "#{'m'.cyan} = #{m.inspect}"
puts "=========================================\n".green

#==============================================================================

puts '1. Обратная подстановка'.blue.bold
puts "#{'f^-1'.cyan} = \n#{pretty(Algorithms4.reverse_substitution(f))}\n"

#==============================================================================

puts '2. Произведение подстановок'.blue.bold
puts "#{'f * g'.cyan} = \n#{pretty(Algorithms4.multiplication_substitution(f, g))}"
puts "#{'g * f'.cyan} = \n#{pretty(Algorithms4.multiplication_substitution(f, g))}\n"

#==============================================================================

cycle = Algorithms4.cycles(f)
transpose = Algorithms4.transpose(cycle).flatten(1)
pretty_cycle = cycle.map {|c| "(#{c.join(' ')})"}.join('')
pretty_transpose = transpose.map {|t| "(#{t.join(' ')})"}.join('')

puts '3. Циклы и транспозиции подстановки'.blue.bold
puts "#{'f'.cyan} = #{pretty_cycle} = #{pretty_transpose}
     \n"

#==============================================================================

puts '4. Генерация случайной подстановки'.blue.bold
puts 'gen'.cyan + " =
#{pretty(Algorithms4.generate_transpose(10))}
"

#==============================================================================
puts '5. Проверка на цикличность группы'.blue.bold
m.each_with_index do |group, index|
  puts "m#{index + 1}(#{group})".cyan + " = #{Algorithms4.is_cycle?(group) ? 'Циклическая' : 'Не циклическая'}"
end
puts
#==============================================================================

puts '6. Образующие элементы'.blue.bold
m.each_with_index do |group, index|
  puts "m#{index + 1}(#{group})".cyan + " = #{Algorithms4.forming_elements(group)}"
end
#==============================================================================