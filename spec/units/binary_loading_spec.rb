#!/usr/bin/env ruby
require 'emulate_helper'

describe 'unit test for utilities/binaryLoading.c' do

  let(:path) { './spec/binary_cases/' }

  context 'with correct file paths' do

    let(:ruby_bin) { Emulate.get_binary(path + 'A') }
    let(:s) { ruby_bin.size }
    let(:buffer) { FFI::MemoryPointer.new(:uint32, 65536) }
    
    it 'A matches A' do
      res = Emulate.loadBinaryFile path + 'A', buffer
      ruby_hex = ruby_bin.read_bytes(8).unpack('H*')
      c_hex = res.read_bytes(8).unpack('H*')
      c_hex.should eq ruby_hex
    end
    it 'A is not longer than A' do
      res = Emulate.loadBinaryFile path + 'A', buffer
      res.read_bytes(9).should_not eq \
        Emulate.loadBinaryFile path + 'A', buffer
    end
    it 'A does not match B' do
      res = Emulate.loadBinaryFile path + 'B', buffer
      res.get_bytes(0, s).should_not eq(ruby_bin.read_bytes(s))
    end

  end

  context 'with invalid files' do
    it 'detects size above 2^16 bytes' do
      file = Emulate.openFile path + 'C_large'
      size = Emulate.getSize file
      # invalid file, should exceed limit
      size.should_not be < 65536
    end

    it 'detects nonexistant file' do
      file = Emulate.openFile path + 'Ghost'
      # invalid should point to it's initialized value- 0
      file.address.should eq(0)
    end
  end

end
