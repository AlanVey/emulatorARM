#!/usr/bin/env ruby
require 'assemble_helper'

describe 'unit test for utilities/bstMap.c' do

  it 'creates tree' do
    tree = Assemble.createTree
    tree.address.should eq(0)
  end

  it 'retrieves one tree entry' do
  end



end
