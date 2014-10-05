name = ARGV[0].split('.')[0]
puts "it '#{name}' do"
puts "  run_file bin + '#{name}'"
puts "  emem = raspi.encoded_mem"
File.open("./#{ARGV[0]}").each_line do |line|
  if line[0] == '$'
    index = line.split(' ')[0].split('$')[1]
    value = line.split('(')[1].split(')')[0]
    puts "  raspi.get_ureg(#{index}).should eq(#{value})"
  elsif line[0..1] == '0x'
    addr = line.split(': ')[0].to_i(16)
    value = line.split(': ')[1].to_i(16).to_s(16)
    puts "  emem[#{addr/4}].should eq(0x#{value})"
  elsif line[0..1] == 'PC'
    value = line.split('(')[1].split(')')[0]
    puts "  raspi.pc.should eq(#{value})"
  elsif line[0..1] == 'CP'
    value = line.split('(')[1].split(')')[0]
    puts "  raspi.cpsr.should eq(#{value})"
  end
end
puts 'end'