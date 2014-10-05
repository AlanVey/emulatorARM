require 'spec_helper'
require 'ffi'

module Assemble extend FFI::Library
  ffi_lib File.join(File.expand_path('bin'), 'assemble')

  #### assemble.c ############################################
  attach_function :main, [:int, :string], :void
  attach_function :tokeniser, [:string], :pointer

  #### utilites/functionAssemble.c ##########################
  attach_function :assembleDataProcessing, [:pointer], :uint32

  #### utilites/bstMap.c ####################################
  attach_function :createTree, [], :pointer
  attach_function :mallocEntry, [:string, :uint32], :pointer
  attach_function :insert, [:pointer, :string, :uint32], :pointer
  attach_function :getAddr, [:pointer, :string], :uint32

  #### standard C libraries #################################
  attach_function :malloc, [:size_t], :pointer
  attach_function :calloc, [:size_t], :pointer

  def self.pointer_from_string(str)
    ptr = Assemble.malloc str.size
    ptr.write_string str
  end

end