require 'json'
require_relative '../methods/algorithms.rb'
require_relative '../methods/helper.rb'

while true
  puts 'Enter a message: '
  message = Helper.message_to_code(gets.chomp)

  p = Helper.read_public_key('p')
  puts "Take public key p: #{p}"

  g = Helper.read_public_key('g')
  puts "Take public key g: #{g}"

  session_key = Helper.generate_key(p-2)
  puts "Alice session key generated: #{session_key}"

  bob_public_key = Helper.read_public_key('bob_public_key')
  raise 'Боб не опубликовал публичный ключ' unless bob_public_key
  puts "Bob's public key received: #{bob_public_key}"

  r = Algorithms.modular_pow(g, session_key, p)

  encrypt_message = message.map do |letter|
    # e = message * (bob_public_key ** session_key) mod p
    e = Algorithms.modular_pow(letter * Algorithms.modular_pow(bob_public_key, session_key, p),1,p)

    "#{r}:#{e}"
  end.join('|')

  Helper.write_message(encrypt_message)

  puts 'Message sent!'
  puts '================================'
end
