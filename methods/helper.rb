class Helper

  def self.generate_key
    rand(99999)
  end

  def self.message_to_code(message)
    abc = JSON.parse(File.new('/home/local/PROFITERO/mikhliuk.k/RubymineProjects/izmk/lab_6/abc.json','r').read)
    message.split('').map{|a| abc[a] }
  end


  def self.code_to_message(message)
    abc = JSON.parse(File.new('/home/local/PROFITERO/mikhliuk.k/RubymineProjects/izmk/lab_6/abc.json','r').read)
    message.map{ |a| abc.find{|k,v|v == a}.join }
  end

  def self.read_public_key(key)
    config = JSON.parse(File.new('/home/local/PROFITERO/mikhliuk.k/RubymineProjects/izmk/lab_6/public_keys.json','r').read)
    config[key]
  end

  def self.write_public_key(key, value)
    config = JSON.parse(File.new('/home/local/PROFITERO/mikhliuk.k/RubymineProjects/izmk/lab_6/public_keys.json','r').read)
    config[key] = value
    File.open('/home/local/PROFITERO/mikhliuk.k/RubymineProjects/izmk/lab_6/public_keys.json','w') {|f| f.write(JSON(config)) }
  end

  def self.read_private_key(key)
    config = JSON.parse(File.new('/home/local/PROFITERO/mikhliuk.k/RubymineProjects/izmk/lab_6/private_keys.json','r').read)
    config[key]
  end

  def self.write_private_key(key, value)
    config = JSON.parse(File.new('/home/local/PROFITERO/mikhliuk.k/RubymineProjects/izmk/lab_6/private_keys.json','r').read)
    config[key] = value
    File.open('/home/local/PROFITERO/mikhliuk.k/RubymineProjects/izmk/lab_6/private_keys.json','w') {|f| f.write(JSON(config)) }
  end

end
