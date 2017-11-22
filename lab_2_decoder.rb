path_to_file = ARGV[0]
secret_key = ARGV[1]
secret_hash = secret_key.split('').map.with_index {|a, index| [index, a]}.sort_by {|b| b[1]}
file_text = File.read(path_to_file).to_s

text_map = file_text.split('').each_slice(secret_key.length).to_a.transpose

result = []

secret_hash.each_with_index do |shuf_row, index|
  result[shuf_row[0]] =  text_map[index]
end

puts result.flatten.join

puts 'OK'