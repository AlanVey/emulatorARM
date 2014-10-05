#!/usr/bin/env ruby
require 'emulate_helper'

describe 'official test suite' do

  let(:raspi) { RaspiStruct.new Emulate.makeRaspi }
  let(:bin)   { './spec/binary_cases/'    }
  let(:exp)   { './spec/binary_outcomes/' }

  def run_file(file)
    Emulate.loadBinaryFile file, raspi.em
    Emulate.runRaspi raspi, 0, 1
  end

  context 'arithmetic' do
    context 'addition' do
      it 'add01' do
        run_file bin + 'add01'
        Emulate.printOut raspi
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000001)
        raspi.get_ureg(2).should eq(0x00000003)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xe2812002)
      end
      it 'add02' do
        run_file bin + 'add02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000001)
        raspi.get_ureg(2).should eq(0x00000002)
        raspi.get_ureg(3).should eq(0x00000003)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xe3a02002)
        emem[2].should eq(0xe0813002)
      end
      it 'add03' do
        run_file bin + 'add03'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000002)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xe0811001)
      end
      it 'add04' do
        run_file bin + 'add04'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000001)
        raspi.get_ureg(2).should eq(0x00000002)
        raspi.get_ureg(3).should eq(0x00000003)
        raspi.get_ureg(4).should eq(0x00000007)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000018)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xe3a02002)
        emem[2].should eq(0xe0813002)
        emem[3].should eq(0xe2834004)
      end
      it 'opt_add05' do
        run_file bin + 'opt_add05'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000004)
        raspi.get_ureg(2).should eq(0x00000002)
        raspi.get_ureg(3).should eq(0x00000006)
        raspi.get_ureg(4).should eq(0x0000000a)
        raspi.get_ureg(5).should eq(0x00000009)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x0000001c)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01004)
        emem[1].should eq(0xe3a02002)
        emem[2].should eq(0xe0813002)
        emem[3].should eq(0xe2834004)
        emem[4].should eq(0xe0445233)
      end
    end

    context 'multiplication' do
      it 'mul01' do
        run_file bin + 'mul01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000002)
        raspi.get_ureg(2).should eq(0x00000004)
        raspi.get_ureg(3).should eq(0x00000008)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01002)
        emem[1].should eq(0xe3a02004)
        emem[2].should eq(0xe0030291)
      end
    end

    context 'right subtract' do
      it 'rsb01' do
        run_file bin + 'rsb01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000002)
        raspi.get_ureg(2).should eq(0xffffffff)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01002)
        emem[1].should eq(0xe2612001)
      end
      it 'rsb02' do
        run_file bin + 'rsb02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x000000ff)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a010ff)
        emem[1].should eq(0xe26120ff)
      end
      it 'rsb03' do
        run_file bin + 'rsb03'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x000000ff)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a010ff)
        emem[1].should eq(0xe0612001)
      end
    end

    context 'subtract' do
      it 'sub01' do
        run_file bin + 'sub01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000002)
        raspi.get_ureg(2).should eq(0x00000001)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01002)
        emem[1].should eq(0xe2412001)
      end
      it 'sub02' do
        run_file bin + 'sub02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x000000ff)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a010ff)
        emem[1].should eq(0xe24120ff)
      end
      it 'sub03' do
        run_file bin + 'sub03'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x000000ff)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a010ff)
        emem[1].should eq(0xe0412001)
      end
    end

  end

  context 'logical operators' do

    context 'and' do
      it 'and01' do
        run_file bin + 'and01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x000000ff)
        raspi.get_ureg(2).should eq(0x000000ab)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a010ff)
        emem[1].should eq(0xe20120ab)
      end
      it 'and02' do
        run_file bin + 'and02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x0000000f)
        raspi.get_ureg(2).should eq(0x000000ab)
        raspi.get_ureg(3).should eq(0x0000000b)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0100f)
        emem[1].should eq(0xe3a020ab)
        emem[2].should eq(0xe0013002)
      end
    end

    context 'exclusive or' do
      it 'eor01' do
        run_file bin + 'eor01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x0000000f)
        raspi.get_ureg(2).should eq(0x000000ff)
        raspi.get_ureg(3).should eq(0x000000f0)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0100f)
        emem[1].should eq(0xe3a020ff)
        emem[2].should eq(0xe0213002)
      end
      it 'eor02' do
        run_file bin + 'eor02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x000000ff)
        raspi.get_ureg(2).should eq(0x000000f0)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a010ff)
        emem[1].should eq(0xe221200f)
      end
    end

    context 'or' do
      it 'or01' do
        run_file bin + 'or01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x000000ab)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01000)
        emem[1].should eq(0xe38120ab)
      end
      it 'or02' do
        run_file bin + 'or02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x0000000f)
        raspi.get_ureg(2).should eq(0x000000ab)
        raspi.get_ureg(3).should eq(0x000000af)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0100f)
        emem[1].should eq(0xe3a020ab)
        emem[2].should eq(0xe1813002)
      end
    end

  end

  context 'branching' do

    context 'simple branch' do
      it 'b01' do
        run_file bin + 'b01'
        emem = raspi.encoded_mem
        raspi.get_reg(1).should eq(0x00000001)
        raspi.get_reg(3).should eq(0x00000003)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xea000000)
        emem[2].should eq(0xe3a02002)
        emem[3].should eq(0xe3a03003)
      end
    end

    context 'branch equal or greater than' do
      it 'b01' do
        run_file bin + 'b01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000001)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000003)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000018)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xea000000)
        emem[2].should eq(0xe3a02002)
        emem[3].should eq(0xe3a03003)
      end
      it 'beq01' do
        run_file bin + 'beq01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000001)
        raspi.get_ureg(2).should eq(0x00000001)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000004)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000020)
        raspi.cpsr.should eq(0x40000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xe3a02001)
        emem[2].should eq(0xe1510002)
        emem[3].should eq(0xa000000)
        emem[4].should eq(0xe3a03003)
        emem[5].should eq(0xe3a04004)
      end
      it 'beq02' do
        run_file bin + 'beq02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000001)
        raspi.get_ureg(2).should eq(0x00000002)
        raspi.get_ureg(3).should eq(0x00000003)
        raspi.get_ureg(4).should eq(0x00000004)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000020)
        raspi.cpsr.should eq(0x80000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xe3a02002)
        emem[2].should eq(0xe1510002)
        emem[3].should eq(0xa000000)
        emem[4].should eq(0xe3a03003)
        emem[5].should eq(0xe3a04004)
      end
    end

    context 'branch not equal to' do
      it 'bne01' do
        run_file bin + 'bne01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000001)
        raspi.get_ureg(2).should eq(0x00000001)
        raspi.get_ureg(3).should eq(0x00000003)
        raspi.get_ureg(4).should eq(0x00000004)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000020)
        raspi.cpsr.should eq(0x40000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xe3a02001)
        emem[2].should eq(0xe1510002)
        emem[3].should eq(0x1a000000)
        emem[4].should eq(0xe3a03003)
        emem[5].should eq(0xe3a04004)
      end
      it 'bne02' do
        run_file bin + 'bne02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000001)
        raspi.get_ureg(2).should eq(0x00000002)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000004)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000020)
        raspi.cpsr.should eq(0x80000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xe3a02002)
        emem[2].should eq(0xe1510002)
        emem[3].should eq(0x1a000000)
        emem[4].should eq(0xe3a03003)
        emem[5].should eq(0xe3a04004)
      end
    end

    context 'loop branching' do
      context 'loops' do
        it 'loop01' do
          run_file bin + 'loop01'
          emem = raspi.encoded_mem
          raspi.get_ureg(0).should eq(0x00000000)
          raspi.get_ureg(1).should eq(0x00000000)
          raspi.get_ureg(2).should eq(0x000000ff)
          raspi.get_ureg(3).should eq(0x00000000)
          raspi.get_ureg(4).should eq(0x00000000)
          raspi.get_ureg(5).should eq(0x00000000)
          raspi.get_ureg(6).should eq(0x00000000)
          raspi.get_ureg(7).should eq(0x00000000)
          raspi.get_ureg(8).should eq(0x00000000)
          raspi.get_ureg(9).should eq(0x00000000)
          raspi.get_ureg(10).should eq(0x00000000)
          raspi.get_ureg(11).should eq(0x00000000)
          raspi.get_ureg(12).should eq(0x00000000)
          raspi.pc.should eq(0x00000018)
          raspi.cpsr.should eq(0x40000000)
          emem[0].should eq(0xe3a0283f)
          emem[1].should eq(0xe2422001)
          emem[2].should eq(0xe35200ff)
          emem[3].should eq(0x1afffffc)
        end
        it 'loop03' do
          run_file bin + 'loop03'
          emem = raspi.encoded_mem
          raspi.get_ureg(0).should eq(0x00000000)
          raspi.get_ureg(1).should eq(0x00000000)
          raspi.get_ureg(2).should eq(0x00000000)
          raspi.get_ureg(3).should eq(0x00000000)
          raspi.get_ureg(4).should eq(0x00000000)
          raspi.get_ureg(5).should eq(0x00000000)
          raspi.get_ureg(6).should eq(0x00000000)
          raspi.get_ureg(7).should eq(0x00000000)
          raspi.get_ureg(8).should eq(0x00000000)
          raspi.get_ureg(9).should eq(0x00000000)
          raspi.get_ureg(10).should eq(0x00000000)
          raspi.get_ureg(11).should eq(0x00000000)
          raspi.get_ureg(12).should eq(0x00000000)
          raspi.pc.should eq(0x00000018)
          raspi.cpsr.should eq(0x40000000)
          emem[0].should eq(0xe3a0200a)
          emem[1].should eq(0xe2422001)
          emem[2].should eq(0xe3520000)
          emem[3].should eq(0x1afffffc)
        end
      end
    end
  end

  context 'general IO control' do
    context 'gpios' do
      it 'gpio_0' do
        run_file bin + 'gpio_0'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x20200004)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x20200004)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x40000000)
        emem[0].should eq(0xe59f0008)
        emem[1].should eq(0xe5902000)
        emem[2].should eq(0xe1520000)
        emem[4].should eq(0x20200004)
      end
      it 'gpio_1' do
        run_file bin + 'gpio_1'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x20200000)
        raspi.get_ureg(1).should eq(0x00400000)
        raspi.get_ureg(2).should eq(0xffffffff)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x0000002c)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe59f0020)
        emem[1].should eq(0xe3a01001)
        emem[2].should eq(0xe1a01301)
        emem[3].should eq(0xe5801008)
        emem[4].should eq(0xe3a01001)
        emem[5].should eq(0xe1a01b01)
        emem[6].should eq(0xe5801028)
        emem[7].should eq(0xe2422001)
        emem[8].should eq(0xe580101c)
        emem[10].should eq(0x20200000)
      end
      it 'gpio_2' do
        run_file bin + 'gpio_2'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x20200000)
        raspi.get_ureg(1).should eq(0x00040000)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000030)
        raspi.cpsr.should eq(0x40000000)
        emem[0].should eq(0xe3a0200a)
        emem[1].should eq(0xe59f0020)
        emem[2].should eq(0xe3a01001)
        emem[3].should eq(0xe1a01901)
        emem[4].should eq(0xe5801028)
        emem[5].should eq(0xe5801028)
        emem[6].should eq(0xe2422001)
        emem[7].should eq(0xe3520000)
        emem[8].should eq(0xe580101c)
        emem[9].should eq(0x1afffffa)
        emem[11].should eq(0x20200000)
      end
    end
  end

  context 'factorial' do
    it 'factorial' do
      run_file bin + 'factorial'
      emem = raspi.encoded_mem
      raspi.get_ureg(0).should eq(0x00000078)
      raspi.get_ureg(1).should eq(0x00000000)
      raspi.get_ureg(2).should eq(0x00000078)
      raspi.get_ureg(3).should eq(0x00000100)
      raspi.get_ureg(4).should eq(0x00000000)
      raspi.get_ureg(5).should eq(0x00000000)
      raspi.get_ureg(6).should eq(0x00000000)
      raspi.get_ureg(7).should eq(0x00000000)
      raspi.get_ureg(8).should eq(0x00000000)
      raspi.get_ureg(9).should eq(0x00000000)
      raspi.get_ureg(10).should eq(0x00000000)
      raspi.get_ureg(11).should eq(0x00000000)
      raspi.get_ureg(12).should eq(0x00000000)
      raspi.pc.should eq(0x0000002c)
      raspi.cpsr.should eq(0x40000000)
      emem[0].should eq(0xe3a00001)
      emem[1].should eq(0xe3a01005)
      emem[2].should eq(0xe0020091)
      emem[3].should eq(0xe1a00002)
      emem[4].should eq(0xe2411001)
      emem[5].should eq(0xe3510000)
      emem[6].should eq(0x1afffffa)
      emem[7].should eq(0xe3a03c01)
      emem[8].should eq(0xe5832000)
      emem[64].should eq(0x78)
    end
  end

  context 'register manipulation' do
    context 'register loading via ldr' do
      it 'ldr01' do
        run_file bin + 'ldr01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000002)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x2000e3a0)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a00002)
        emem[1].should eq(0xe5902000)
        emem[2].should eq(0xe1520000)
      end
      it 'ldr02' do
        run_file bin + 'ldr02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x03000000)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x000000e1)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000018)
        raspi.cpsr.should eq(0x80000000)
        emem[0].should eq(0xe3a0000f)
        emem[1].should eq(0xe5902000)
        emem[2].should eq(0xe3a00403)
        emem[3].should eq(0xe1520000)
      end
      it 'ldr03' do
        run_file bin + 'ldr03'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x0000000b)
        raspi.get_ureg(1).should eq(0xfffffffe)
        raspi.get_ureg(2).should eq(0x411005e3)
        raspi.get_ureg(3).should eq(0x00028000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x0000001c)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0000b)
        emem[1].should eq(0xe5902000)
        emem[2].should eq(0xe3a01003)
        emem[3].should eq(0xe2411005)
        emem[4].should eq(0xe3a0390a)
      end
      it 'ldr05' do
        run_file bin + 'ldr05'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x003f0000)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0183f)
        emem[1].should eq(0xe5912000)
      end
      it 'ldr06' do
        run_file bin + 'ldr06'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x003f0000)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0183f)
        emem[1].should eq(0xe5912000)
        emem[2].should eq(0xe5913008)
      end
      it 'ldr07' do
        run_file bin + 'ldr07'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x20200020)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x0000000c)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe59f2000)
        emem[2].should eq(0x20200020)
      end
      it 'ldr08' do
        run_file bin + 'ldr08'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x20200020)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x20200030)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe59f0008)
        emem[1].should eq(0xe59f2008)
        emem[2].should eq(0xe2822008)
        emem[4].should eq(0x20200020)
        emem[5].should eq(0x20200028)
      end
      it 'ldr09' do
        run_file bin + 'ldr09'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x20200022)
        raspi.get_ureg(2).should eq(0x20200020)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe59f2008)
        emem[1].should eq(0xe2821002)
        emem[2].should eq(0xe3330002)
        emem[4].should eq(0x20200020)
      end
      it 'opt_ldr10' do
        run_file bin + 'opt_ldr10'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x0000000c)
        raspi.get_ureg(2).should eq(0x0000000a)
        raspi.get_ureg(3).should eq(0x0000000e)
        raspi.get_ureg(4).should eq(0x5122e593)
        raspi.get_ureg(5).should eq(0x5122e593)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x0000001c)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0100c)
        emem[1].should eq(0xe3a0200a)
        emem[2].should eq(0xe3a0300e)
        emem[3].should eq(0xe5934000)
        emem[4].should eq(0xe7915122)
      end
      it 'opt_ldr11' do
        run_file bin + 'opt_ldr11'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000009)
        raspi.get_ureg(2).should eq(0xe4912005)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01004)
        emem[1].should eq(0xe4912005)
        emem[2].should eq(0xe7913122)
      end
      it 'opt_ldr12' do
        run_file bin + 'opt_ldr12'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x003f0000)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0183f)
        emem[1].should eq(0xe5912000)
        emem[2].should eq(0xe7913122)
      end
      it 'opt_ldr13' do
        run_file bin + 'opt_ldr13'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000006)
        raspi.get_ureg(2).should eq(0x01e3a020)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000018)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a02004)
        emem[1].should eq(0xe3a01001)
        emem[2].should eq(0xe4912005)
        emem[3].should eq(0xe7913122)
      end
      it 'ldr14' do
        run_file bin + 'ldr14'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x20200020)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x20200030)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000014)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe59f0008)
        emem[1].should eq(0xe59f2008)
        emem[2].should eq(0xe2822008)
        emem[4].should eq(0x20200020)
        emem[5].should eq(0x20200028)
      end
    end

    context 'store register' do
      it 'str01' do
        run_file bin + 'str01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x20200000)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe59f0004)
        emem[1].should eq(0xe581001c)
        emem[3].should eq(0x20200000)
        emem[7].should eq(0x20200000)
      end
      it 'str02' do
        run_file bin + 'str02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000002)
        raspi.get_ureg(2).should eq(0x00000005)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000001)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000018)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a04001)
        emem[1].should eq(0x2)
        emem[2].should eq(0xe3a01002)
        emem[3].should eq(0xe6821004)
      end
      it 'str03' do
        run_file bin + 'str03'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000001)
        raspi.get_ureg(1).should eq(0x00000063)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000028)
        raspi.cpsr.should eq(0x40000000)
        emem[0].should eq(0xe3a02002)
        emem[1].should eq(0x63)
        emem[2].should eq(0x6363)
        emem[3].should eq(0xe5801000)
        emem[4].should eq(0xe2422001)
        emem[5].should eq(0xe3520000)
        emem[6].should eq(0xe5801008)
        emem[7].should eq(0x1afffffb)
      end
    end
    context 'move assignment' do
      it 'mov01' do
        run_file bin + 'mov01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000001)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x0000000c)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01001)
      end
      it 'mov02' do
        run_file bin + 'mov02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000002)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x0000000c)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01002)
      end
      it 'mov03' do
        run_file bin + 'mov03'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x0000000f)
        raspi.get_ureg(2).should eq(0x000000ff)
        raspi.get_ureg(3).should eq(0x000000ab)
        raspi.get_ureg(4).should eq(0x000000cd)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000018)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0100f)
        emem[1].should eq(0xe3a020ff)
        emem[2].should eq(0xe3a030ab)
        emem[3].should eq(0xe3a040cd)
      end
      it 'mov04' do
        run_file bin + 'mov04'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x003f0000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x0000000c)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0283f)
      end
      it 'mov05' do
        run_file bin + 'mov05'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000001)
        raspi.get_ureg(2).should eq(0x00000001)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xe1a02001)
      end
      it 'mov06' do
        run_file bin + 'mov06'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x00028000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x0000000c)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a0290a)
      end
      it 'mov07' do
        run_file bin + 'mov07'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x03000000)
        raspi.get_ureg(1).should eq(0x00000000)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x0000000c)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a00403)
      end
    end
  end

  context 'shifting operations' do
    context 'left shift' do
      it 'lsl01' do
        run_file bin + 'lsl01'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x00000002)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a01001)
        emem[1].should eq(0xe1a01081)
      end
      it 'lsl02' do
        run_file bin + 'lsl02'
        emem = raspi.encoded_mem
        raspi.get_ureg(0).should eq(0x00000000)
        raspi.get_ureg(1).should eq(0x80000000)
        raspi.get_ureg(2).should eq(0x00000000)
        raspi.get_ureg(3).should eq(0x00000000)
        raspi.get_ureg(4).should eq(0x00000000)
        raspi.get_ureg(5).should eq(0x00000000)
        raspi.get_ureg(6).should eq(0x00000000)
        raspi.get_ureg(7).should eq(0x00000000)
        raspi.get_ureg(8).should eq(0x00000000)
        raspi.get_ureg(9).should eq(0x00000000)
        raspi.get_ureg(10).should eq(0x00000000)
        raspi.get_ureg(11).should eq(0x00000000)
        raspi.get_ureg(12).should eq(0x00000000)
        raspi.pc.should eq(0x00000010)
        raspi.cpsr.should eq(0x00000000)
        emem[0].should eq(0xe3a010ff)
        emem[1].should eq(0xe1a01f81)
      end
    end
  end


  context 'test bits' do
    it 'tst01' do
      run_file bin + 'tst01'
      emem = raspi.encoded_mem
      raspi.get_ureg(0).should eq(0x00000000)
      raspi.get_ureg(1).should eq(0x00000001)
      raspi.get_ureg(2).should eq(0x00000002)
      raspi.get_ureg(3).should eq(0x00000000)
      raspi.get_ureg(4).should eq(0x00000004)
      raspi.get_ureg(5).should eq(0x00000000)
      raspi.get_ureg(6).should eq(0x00000000)
      raspi.get_ureg(7).should eq(0x00000000)
      raspi.get_ureg(8).should eq(0x00000000)
      raspi.get_ureg(9).should eq(0x00000000)
      raspi.get_ureg(10).should eq(0x00000000)
      raspi.get_ureg(11).should eq(0x00000000)
      raspi.get_ureg(12).should eq(0x00000000)
      raspi.pc.should eq(0x00000020)
      raspi.cpsr.should eq(0x40000000)
      emem[0].should eq(0xe3a01001)
      emem[1].should eq(0xe3a02002)
      emem[2].should eq(0xe1110002)
      emem[3].should eq(0xa000000)
      emem[4].should eq(0xe3a03003)
      emem[5].should eq(0xe3a04004)
    end
    it 'tst02' do
      run_file bin + 'tst02'
      emem = raspi.encoded_mem
      raspi.get_ureg(0).should eq(0x00000000)
      raspi.get_ureg(1).should eq(0x00000001)
      raspi.get_ureg(2).should eq(0x00000001)
      raspi.get_ureg(3).should eq(0x00000003)
      raspi.get_ureg(4).should eq(0x00000004)
      raspi.get_ureg(5).should eq(0x00000000)
      raspi.get_ureg(6).should eq(0x00000000)
      raspi.get_ureg(7).should eq(0x00000000)
      raspi.get_ureg(8).should eq(0x00000000)
      raspi.get_ureg(9).should eq(0x00000000)
      raspi.get_ureg(10).should eq(0x00000000)
      raspi.get_ureg(11).should eq(0x00000000)
      raspi.get_ureg(12).should eq(0x00000000)
      raspi.pc.should eq(0x00000020)
      raspi.cpsr.should eq(0x00000000)
      emem[0].should eq(0xe3a01001)
      emem[1].should eq(0xe3a02001)
      emem[2].should eq(0xe1110002)
      emem[3].should eq(0xa000000)
      emem[4].should eq(0xe3a03003)
      emem[5].should eq(0xe3a04004)
    end
    it 'tst03' do
      run_file bin + 'tst03'
      emem = raspi.encoded_mem
      raspi.get_ureg(0).should eq(0x00000000)
      raspi.get_ureg(1).should eq(0x00000001)
      raspi.get_ureg(2).should eq(0x00000017)
      raspi.get_ureg(3).should eq(0x00000000)
      raspi.get_ureg(4).should eq(0x00000004)
      raspi.get_ureg(5).should eq(0x00000000)
      raspi.get_ureg(6).should eq(0x00000000)
      raspi.get_ureg(7).should eq(0x00000000)
      raspi.get_ureg(8).should eq(0x00000000)
      raspi.get_ureg(9).should eq(0x00000000)
      raspi.get_ureg(10).should eq(0x00000000)
      raspi.get_ureg(11).should eq(0x00000000)
      raspi.get_ureg(12).should eq(0x00000000)
      raspi.pc.should eq(0x00000020)
      raspi.cpsr.should eq(0x00000000)
      emem[0].should eq(0xe3a01001)
      emem[1].should eq(0xe3a02017)
      emem[2].should eq(0xe1110002)
      emem[3].should eq(0xea000000)
      emem[4].should eq(0xe3a03003)
      emem[5].should eq(0xe3a04004)
    end
    it 'tst04' do
      run_file bin + 'tst04'
      emem = raspi.encoded_mem
      raspi.get_ureg(0).should eq(0x00000000)
      raspi.get_ureg(1).should eq(0x00000001)
      raspi.get_ureg(2).should eq(0x00000017)
      raspi.get_ureg(3).should eq(0x00000000)
      raspi.get_ureg(4).should eq(0x00000004)
      raspi.get_ureg(5).should eq(0x00000000)
      raspi.get_ureg(6).should eq(0x00000000)
      raspi.get_ureg(7).should eq(0x00000000)
      raspi.get_ureg(8).should eq(0x00000000)
      raspi.get_ureg(9).should eq(0x00000000)
      raspi.get_ureg(10).should eq(0x00000000)
      raspi.get_ureg(11).should eq(0x00000000)
      raspi.get_ureg(12).should eq(0x00000000)
      raspi.pc.should eq(0x00000020)
      raspi.cpsr.should eq(0x00000000)
      emem[0].should eq(0xe3a01001)
      emem[1].should eq(0xe3a02017)
      emem[2].should eq(0xe1110002)
      emem[3].should eq(0xea000000)
      emem[4].should eq(0xe3a03003)
      emem[5].should eq(0xe3a04004)
    end
  end

end