#!/usr/bin/env ruby
require 'emulate_helper'

describe 'unit test for emulate.c' do
  let(:add01) { './spec/binary_cases/add01' }
  let(:memsize) { 65536 }
  let(:raspi_ptr) { Emulate.makeRaspi }
  let(:mem_buff) { FFI::MemoryPointer.new(:uint32, 65536) }

  it 'does not crash for normal file' do
    Emulate.main(0, add01)
  end

  describe 'initialization' do

    context 'file exists' do

      it 'zeros all struct elements' do
        RaspiStruct.new(raspi_ptr).zeroed.should eq(true)
      end

      it 'loads file at path into state memory' do
        struct = RaspiStruct.new raspi_ptr
        Emulate.loadBinaryFile add01, struct.em
        ruby_bin = Emulate.get_binary(add01)
        s, c_bin = [ruby_bin.size, struct.em]
        # the bytes from the first section of the memory
        # should equal the ruby bytes of the whole file
        c_bin.read_bytes(s).should eq(ruby_bin.read_bytes(s))
        elems = c_bin
          .read_array_of_type(:uint32, :read_uint32, (memsize >> 1))
        total = elems[s..memsize].reduce { |a, b| a + b }
        # all bytes after the loaded mem should be 0
        total.should eq(0)
      end
      
    end

    context 'file does not exist' do
      it 'detects incorrect nonexistant files' do
        res = Emulate.fileExists('./bogus')
        res.should eq(1)
        res = Emulate.fileExists('./spec/binary_cases/A')
        res.should eq(0)
      end
    end

  end

  describe 'decoding instruction' do

    describe 'masking checks' do

      before(:all) do
        @cond, @bytes = [[],[]]
        cond = 2**28
        50.times do
          @cond << rand(16)*cond
          @bytes << rand(256)
        end
        @run = './spec/test_binary_wrappers/maskTests'
      end

      it 'verifies data opcode' do
        for nibble in @cond 
          ["D", "M"].should include 
            `#{@run} #{(nibble + rand(67108863))}`
        end
      end

      it 'verifies multiply opcode' do
        for i in 0..(@cond.size) - 1
          test = (@cond[i] + (2**8*@bytes[i]) + 144 + (@bytes[i] >> 8))
          `#{@run} #{test}`.should eq('M')
        end
      end

      it 'verifies single data transfer opcode' do
        for i in 0..(@cond.size) - 1
          test = (@cond[i] + (2**26) + rand(8)*2**23 + rand(1)*2**20)
          test += 2**8*@bytes[i] + @bytes[@cond.size - i - 1]
          `#{@run} #{test}`.should eq('S')
        end
      end

      it 'verifies branch opcode' do
        s = @cond.size
        for i in 0..(@cond.size) - 1
          test  = @cond[i] + 10*2**24 + (@bytes[i]*2**16)
          test += @bytes[s - i - 1]*2**8
          test += @bytes[(2*i + 1) % s]
          `#{@run} #{test}`.should eq('B')
        end
      end

    end

  end

  describe 'single data transfer tests' do
  end

  describe 'branch tests' do
  end

  describe 'multiply tests' do
  end

  describe 'memory accessing' do
  end

end