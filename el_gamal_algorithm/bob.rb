require 'json'
require_relative '../methods/algorithms.rb'
require_relative '../methods/helper.rb'

p = Helper.read_public_key('p')
g = Helper.read_public_key('g')
bob_secret_key = nil

while true
  case gets.chomp
    when 'keys'
      bob_secret_key = Helper.generate_key(p - 1)
      bob_public_key = Algorithms.modular_pow(g, bob_secret_key, p)

      Helper.write_public_key('bob_public_key', bob_public_key)
      puts "Public key published: #{bob_public_key}"
    when 'read'
      begin
        crypt_message = Helper.read_message
      rescue Errno::ENOENT => e
        puts 'You have no messages.'
        next
      end

      if crypt_message.empty?
        puts 'You have no messages.'
        next
      end

      unless bob_secret_key
        puts 'Bob private key needed to be generated!'
        next
      end

      message = crypt_message.split('|').map do |a|
        r = a.split(':')[0].to_i
        e = a.split(':')[1].to_i

        # e * r^(p-1-bob_secret_key) mod p
        letter_code = Algorithms.modular_pow(e * Algorithms.modular_pow(r, p - 1 - bob_secret_key, p), 1, p)
        Helper.code_to_message(letter_code)
      end.join

      puts "Message from Alice: #{message}"
    else
      puts 'Wrong method'
  end
end
