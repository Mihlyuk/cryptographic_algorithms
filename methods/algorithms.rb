class Algorithms

  # Поверка числа на простоту
  def self.is_prime?(number)
    return false if number == 1

    (2..number).each do |i|
      break if i ** 2 > number

      return false if number % i == 0
    end

    true
  end

  # return array [simple_numbers, pretty_view]
  def self.canonical_decomposition(number)
    return 1 if number == 1

    result = []

    while true
      (2..number).each do |n|
        if n == number
          result << number
          return [result, pretty_canonical(result)]
        end

        if number % n == 0
          result << n
          number = number / n
          break
        end
      end
    end
  end

  def self.pretty_canonical(arr)
    arr = arr.group_by { |i| i }
    arr.map { |key, value| "#{key}#{value.count > 1 ? '^' + value.count.to_s : ''}" }.join(' * ')
  end

  # НОД двух чисел
  def self.nod(first, second)
    a = [first, second].min
    b = [first, second].max

    a.gcdlcm(b).first
  end

  def self.extended_euclidean_algorithm(first, second)
    m = [first, second].max
    n = [first, second].min

    a = 0
    a_t = 1
    c=m
    b=1
    b_t=0
    d=n

    q = c / d
    r = c % d

    while r != 0
      c = d
      d = r

      t = a_t
      a_t = a
      a = t - q * a
      t = b_t
      b_t = b
      b = t - q * b

      q = c / d
      r = c % d
    end

    return "#{a} * m + #{b} * n = #{a * m + b * n}"
  end

  def self.nod_canonical_decomposition(first, second)
    a = canonical_decomposition([first, second].min)[0].uniq # smaller element
    b = canonical_decomposition([first, second].max)[0].uniq # greater element

    result = []

    a.each do |number|
      result << b[b.index(number)] if b.index(number)
    end

    return result.max
  end

  # Функция Эйлера fi(n) — мультипликативная арифметическая функция, равная количеству натуральных чисел, меньших n
  # и взаимно простых с ним. При этом полагают по определению, что число 1 взаимно просто со всеми натуральными
  # числами, и fi(1) = 1.
  def self.eiler_function(number)
    decomp = canonical_decomposition(number)[0].uniq

    (number * decomp.map { |d| (1 - (1.0 / d)) }.inject(:*)).floor
  end

  def self.get_all_reversible(ring)
    reverse = (2..ring).to_a.map { |n| nod(n, ring) == 1 ? n : nil }.compact

    reverse = reverse.map do |reverse_i|
      [reverse_i, (reverse_i ** (eiler_function(ring) - 1) + ring) % ring]
    end

    reverse
  end

  def self.get_reversible(ring, element)
    [element, (element ** (eiler_function(ring) - 1) + ring) % ring]
  end

  def self.reverse_substitution(matrix)
    matrix = matrix.reverse.transpose
    matrix = matrix.sort_by {|element| element[0]}.transpose

    matrix
  end

  def self.multiplication_substitution(matrix1, matrix2)
    matrix1 = matrix1.transpose
    matrix2 = matrix2.transpose.to_h

    matrix1.map do |pair|
      [pair[0], matrix2[pair[1]]]
    end.transpose
  end

  def self.cycles(matrix)
    matrix = matrix.transpose
    matrix.reject! {|pair| pair.first == pair.last}

    cycle = []
    temp_cycle = []

    while true
      if temp_cycle.empty?
        temp_cycle << matrix.first
        temp_cycle.flatten!
        matrix.delete_at(0)
      elsif temp_cycle.first == temp_cycle.last
        cycle << temp_cycle.slice(1..-1)
        temp_cycle = []
        break if matrix.empty?
      else
        matrix.each_with_index do |pair, index|
          if pair.first == temp_cycle.last
            temp_cycle << pair.last
            temp_cycle.flatten!
            matrix.delete_at(index)
          end
        end
      end
    end

    cycle
  end

  def self.is_cycle?(input_number)
    number = input_number.to_i

    return true if [1, 2, 4].include?(number)

    dec = Algorithms.canonical_decomposition(number)[1].gsub(' ', '')

    return false if dec !~ /^(2\*)?\d+\^\d$+/

    p = dec[/^(?:2\*)?(\d+)\^\d+$/, 1].to_i

    return true if p % 2 != 0 || Algorithms.is_prime?(p)

    false
  end

  def self.forming_elements(group)
    forming_numbers = []

    prime_numbers =
        Algorithms.canonical_decomposition(group - 1)[1]
            .gsub(' ', '')
            .scan(/(\d+)(?:\^\d+)?/)
            .map {|n| n.first.to_i}

    prime_numbers_multiple =
        Algorithms.canonical_decomposition(group)[1]
            .gsub(' ', '')
            .scan(/(\d+)(?:\^\d+)?/)
            .map {|n| n.first.to_i}

    hyp_forming_numbers = (2...group - 1).to_a - prime_numbers_multiple

    hyp_forming_numbers.each do |hyp_forming|
      expr = prime_numbers.select do |prime_number|
        (hyp_forming ** ((group - 1) / prime_number)) % group == 1
      end

      forming_numbers << hyp_forming if expr.empty?
    end

    forming_numbers
  end

  def self.generate_transpose(transpose_size)
    result = []

    transpose_size.times do |n|
      result << [n, n]
    end

    transpose_size.times do |n|
      rand = rand(transpose_size)

      temp = result[n].last
      result[n][1] = rand
      result[rand][1] = temp
    end

    result
  end

  def self.transpose(cycle)
    cycle.map do |group|
      group.slice(1..-1).map do |gr|
        [group.first, gr]
      end
    end
  end

  def self.pow_m(exp, power, mod)
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

  # base^index_n mod modulus
  def self.modular_pow(base, index_n, modulus)
    c = 1
    (1..index_n).each do |n|
      puts "c: #{n}" if n % 1000000 == 0
      c = (c * base) % modulus
    end

    c
  end

  def self.find_secret_key(public_key, g, p)
    i = -1

    while true
      i+=1
      puts i if i % 5000 == 0
      break if public_key == modular_pow(g, i, p)
    end

    i
  end
end
