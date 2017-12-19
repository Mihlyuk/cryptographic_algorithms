require_relative 'methods/algorithms.rb'
require_relative 'methods/helper.rb'

p = 134041249
g = 7

a = Helper.generate_key
puts "Секретный ключ Алисы: #{a}"

b = Helper.generate_key
puts "Секретный ключ Боба: #{b}"

y = Algorithms.modular_pow(g, a, p)
puts "Открытый ключ Алисы: #{y}"

x = Algorithms.modular_pow(g, b, p)
puts "Открытый ключ Боба: #{x}"

k1 = Algorithms.modular_pow(y, b, p)
puts "Общий ключ, высчитанный Алисой: #{k1}"
k2 = Algorithms.modular_pow(x, a, p)
puts "Общий ключ, высчитанный Бобом: #{k2}"

puts 'Поиск секретного ключа...'
time1 = Time.now
alice_secret_key = Algorithms.find_secret_key(y, g, p)
time2 = Time.now
puts "Взломанный секретный ключ Алисы: #{alice_secret_key}, время: #{time2 - time1} sec"
