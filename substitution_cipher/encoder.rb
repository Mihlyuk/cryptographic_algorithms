path_to_file = ARGV[0]
secret_key = ARGV[1]
secret_hash = secret_key.split('').map.with_index {|a, index| [index, a]}.sort_by {|b| b[1]}
file_text = File.read(path_to_file).to_s
text_map = file_text.split('').each_slice((file_text.length / secret_key.length).ceil).to_a

(file_text.length / secret_key.length).ceil.times do |index|
  text_map[text_map.length - 1][index] ||= ''
end

text_map = text_map.transpose

result = []

secret_hash.each_with_index do |shuf_row, index|
  result[index] =  text_map.transpose[shuf_row[0]]
end

File.open('encoded_text.txt', 'w') { |file| file.write(result.transpose.flatten.join) }

puts 'OK'