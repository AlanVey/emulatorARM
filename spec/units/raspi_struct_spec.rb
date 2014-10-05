#!/usr/bin/env ruby
require 'emulate_helper'

describe 'unit test for raspi struct' do

  let('raspi') { RaspiStruct.new Emulate.makeRaspi() }

  context 'all blank register' do
    it 'can store and retrieve values' do
      25000.times do
        index, val = rand(12), rand(2**31)
        raspi.set_reg index, val
        raspi.get_reg(index).should eq(val)
        raspi[:sp]   = rand(2**31);
        raspi[:lr]   = rand(2**31);
        raspi[:pc]   = rand(2**31);
        raspi[:cpsr] = rand(2**31);
      end
    end

  end

end
