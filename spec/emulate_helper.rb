require 'spec_helper'
require 'ffi'

module Emulate extend FFI::Library
  ffi_lib File.join(File.expand_path('bin'), 'emulate')

  #### emulate.c ############################################
  attach_function :main, [:int, :string], :void
  attach_function :loadBinaryFile, [:string, :pointer], :pointer
  attach_function :makeRaspi, [], :pointer
  attach_function :printOut, [:pointer], :void
  attach_function :decodeInstruction, [:pointer, :uint32], :pointer
  attach_function :setmem, [:pointer, :string, :int], :void
  attach_function :runFunction, [:pointer], :void
  attach_function :runRaspi, [:pointer, :int, :int], :void
  attach_function :getmem, [], :pointer

  #### utilites/binaryLoading.c #############################
  attach_function :openFile, [:string], :pointer
  attach_function :getSize, [:pointer], :ulong
  attach_function :fileExists, [:string], :int

  #### standard C libraries #################################
  attach_function :malloc, [:size_t], :pointer
  attach_function :calloc, [:size_t], :pointer

  # Retrives the contents of a binary file by using rubys
  # standard functions, then wraps it onto a memorypointer
  # for the FFI library
  def self.get_binary(path)
    file = File.join(File.expand_path(''), path)
    data = File.open(file, 'rb').read
    memBuf = FFI::MemoryPointer.new(:char, data.size)
    memBuf.put_bytes(0,data)
    return memBuf
  end

  def self.pointer_from_string(str)
    ptr = Emulate.malloc str.size
    ptr.write_string str
  end

end