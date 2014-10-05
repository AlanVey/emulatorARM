require 'make_preflight'
require 'ffi'

MEMSIZE = 65536

#///////////////////////////////////////////////////////////////////////////////
# FFI Struct Declarations
#///////////////////////////////////////////////////////////////////////////////

require 'raspi_struct'

class DataProcessingStruct < FFI::Struct
  layout :cond, :uint8,
    :cpsr,      :pointer,
    :function,  :pointer,
    :op1,       :pointer,
    :op2,       :pointer,
    :shift,     :pointer,
    :_op2,      :uint32,
    :_shift,    :uint32,
    :exShift,   :pointer,
    :des,       :pointer
end

class BaseInstrStruct < FFI::Struct
  layout :cond, :uint8,
    :cpsr,      :pointer,
    :function,  :pointer
end

#///////////////////////////////////////////////////////////////////////////////
# Other Classes
#///////////////////////////////////////////////////////////////////////////////

def ROR(val, count)
  (val >> count) | (val << (32 - count)) & 0xFFFFFFFF
end

class DataInstr
  def initialize(opcode)
    @opcode = opcode
  end
  def instr_val
    get_cond + '00' + (@i || '0') + @opcode + 
      '0' + '0000' + '0010' + get_immd
  end
  def get_cond
    @cond || @cond = '1110'
  end
  def set_cond(cond)
    @cond = cond
  end
  def set_immd(immd)
    @immd = immd
    @i = '1'
  end
  def get_immd
    @immd || @immd = '000000000001'
  end
end
