class Algorithms3

  # Поверка числа на простоту
  def self.is_prime?(number)
    return false if number == 1

    (2..number).each do |i|
      break if i ** 2 > number

      return false if number % i == 0
    end

    true
  end

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
end
