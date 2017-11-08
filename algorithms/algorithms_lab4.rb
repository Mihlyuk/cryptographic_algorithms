require_relative 'algorithms_lab3.rb'

class Algorithms4
  def self.reverse_substitution(matrix)
    matrix = matrix.reverse.transpose
    matrix = matrix.sort_by { |element| element[0] }.transpose

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
    matrix.reject! { |pair| pair.first == pair.last }

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

    dec = Algorithms3.canonical_decomposition(number)[1].gsub(' ', '')

    return false if dec !~ /^(2\*)?\d+\^\d$+/

    p = dec[/^(?:2\*)?(\d+)\^\d+$/, 1].to_i

    return true if p % 2 != 0 || Algorithms3.is_prime?(p)

    false
  end

  def self.transpose(cycle)
    cycle.map do |group|
      group.slice(1..-1).map do |gr|
        [group.first, gr]
      end
    end
  end
end