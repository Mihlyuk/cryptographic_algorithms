# exp^(power) (mod mod)
def pow_m(exp, power, mod)
  p = []
  test = 1

  return 0 if mod == 0
  p[0] = exp % mod

  (1..31).each do |i|
    rx = p[i-1]
    rx = (rx * p[i-1]) % mod
    p[i] = rx
    test = test << 1
  end

  rx = 1
  test = 1

  (0..32).each do |i|
    rx = (rx * p[i]) % mod if power & test
    test = test << 1
  end

  rx
end


def modular_pow(base, index_n, modulus)
  c = 1
  (1..index_n).each do |n|
    puts "c: #{n}" if n % 1000000 == 0
    c = (c * base) % modulus
  end

  c
end

def find_x_by_y(y, p, a)
  i = -1

  while true
    i+=1

    puts "y_test: #{i}" if i % 100 == 0

    break if y == modular_pow(a, i, p)
  end

  i
end

a = 86303027
x = 95192833
p = 134041249

y = modular_pow(x, a, p)

puts "y: #{y}"

x = find_x_by_y(y, p, a)

puts "x: #{x}"