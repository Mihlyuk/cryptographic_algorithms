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
      puts "Опубликован публичный ключ Боба: #{bob_public_key}"
    when 'read'
      begin
        crypt_message = Helper.read_message
      rescue Errno::ENOENT => e
        puts 'У вас нет сообщений от Алисы.'
        next
      end

      if crypt_message.empty?
        puts 'У вас нет сообщений от Алисы.'
        next
      end

      unless bob_secret_key
        puts 'Необходимо сгенерировать приватный ключ Боба!'
        next
      end

      message = crypt_message.split('|').map do |a|
        r = a.split(':')[0].to_i
        e = a.split(':')[1].to_i

        # e * r^(p-1-bob_secret_key) mod p
        letter_code = Algorithms.modular_pow(e * Algorithms.modular_pow(r, p - 1 - bob_secret_key, p), 1, p)
        Helper.code_to_message(letter_code)
      end.join

      puts "Сообщение от Алисы: #{message}"
    else
      puts 'Неправильный метод'
  end
end
