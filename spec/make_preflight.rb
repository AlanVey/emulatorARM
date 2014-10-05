system 'clear;'
puts '////////////////////////////////////////////////////////'
puts "\e[1;32m  CLEANING BINARIES\e[0m"
puts '////////////////////////////////////////////////////////'
IO.popen 'make clean 2>&1' do |io|
  clean = io.read
  puts clean
  if clean =~ /: error:/ or clean =~ /: warning:/
    msg = "  CLEAN FAILED."
    abort "\n\e[1;31m#{msg}\e[0m"
  end
end
puts
puts '////////////////////////////////////////////////////////'
puts "\e[1;32m  BUILDING BINARIES\e[0m"
puts '////////////////////////////////////////////////////////'
IO.popen 'make build 2>&1;' do |io|
  make = io.read
  puts make
  if make =~ /: error:/ or make =~ /: warning:/
    msg = "  MAKE FAILED."
    abort "\n\e[1;31m#{msg}\e[0m"
  end
end
puts
puts
puts '////////////////////////////////////////////////////////'
puts "\e[1;32m  STARTING TESTS\e[0m"
puts '////////////////////////////////////////////////////////'
puts
sleep 0.1  # to allow for make to finish