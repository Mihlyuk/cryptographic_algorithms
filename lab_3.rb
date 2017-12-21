require_relative 'methods/algorithms.rb'

m1 = 101398751
n1 = 326147777

k = 11
m2 = 2001
n2 = 24

puts "1. Каноническое разложение числа
#{m1} = #{Algorithms.canonical_decomposition(m1)[1]}
#{n1} = #{Algorithms.canonical_decomposition(n1)[1]}
\n"

puts "2. Нод чисел #{m1},#{n1}:
a) Алгоритм Евклида = #{Algorithms.nod(m1, n1)}
б) Разложение на простые множители = #{Algorithms.nod_canonical_decomposition(m1, n1)}
\n"

puts "3. Расширенный алгоритм Евклида:
#{Algorithms.extended_euclidean_algorithm(m1, n1)}
\n"

puts "4. Функция Эйлера
φ(#{k}) = #{Algorithms.eiler_function(k)}
φ(#{m2}) = #{Algorithms.eiler_function(m2)}
φ(#{n2}) = #{Algorithms.eiler_function(n2)}
\n"

puts "5. Взаимно обратные по умножению элементы:
Z/#{k}/Z = #{Algorithms.get_all_reversible(k)}
Z/#{n2}/Z = #{Algorithms.get_all_reversible(n2)}
\n"

puts "5. Взаимно обратные элементы:
Z/#{2017}/Z = #{Algorithms.get_reversible(2017, 5)}
Z/#{m2}/Z = #{Algorithms.get_reversible(m2, 5)}
Z/#{m2}/Z = #{Algorithms.get_reversible(m2, 6)}
Z/#{m2}/Z = #{Algorithms.get_reversible(m2, 7)}
\n"