require 'json'
require_relative '../methods/algorithms.rb'
require_relative '../methods/helper.rb'

while true
  puts 'Введите сообщение для Боба: '
  message = Helper.message_to_code(gets.chomp)

  p = Helper.read_public_key('p')
  puts "Взят публичный ключ p: #{p}"

  g = Helper.read_public_key('g')
  puts "Взят публичный ключ g: #{g}"

  session_key = Helper.generate_key(p-2)
  puts "Сгенерирован сеансовый ключ Алисы: #{session_key}"

  bob_public_key = Helper.read_public_key('bob_public_key')
  raise 'Боб не опубликовал публичный ключ' unless bob_public_key
  puts "Получен публичный ключ Боба: #{bob_public_key}"

  r = Algorithms.modular_pow(g, session_key, p)

  encrypt_message = message.map do |letter|
    # e = message * (bob_public_key ** session_key) mod p
    e = Algorithms.modular_pow(letter * Algorithms.modular_pow(bob_public_key, session_key, p),1,p)
    "#{r}:#{e}"
  end.join('|')

  Helper.write_message(encrypt_message)

  puts 'Сообщение отправлено!'
  puts '================================'
end
