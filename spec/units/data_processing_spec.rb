describe 'data processing tests' do

  context 'COND as 1110 (always)' do

    def reg_set_rand(raspi, a, b)
      raspi.set_reg(0,a)
      raspi.set_reg(1,b)
    end

    def prime(opcode)
      i = DataInstr.new opcode
      Emulate.setmem @raspi, i.instr_val, 1 
    end

    def prime_immediate(opcode, immd, shift)
      i = DataInstr.new opcode
      shift = shift.to_s(2).rjust(4, '0') 
      i.set_immd (shift + immd.to_s(2).rjust(8, '0'))
      Emulate.setmem @raspi, i.instr_val, 1 
    end

    def decode_and_run
      Emulate.runFunction \
        BaseInstrStruct.new \
          Emulate.decodeInstruction @raspi, 1
    end

    def result
      @raspi.get_reg 2
    end

    def u_result
      @raspi.get_ureg 2
    end

    before(:all) do
      @raspi = RaspiStruct.new Emulate.makeRaspi()
      @a, @b, @c, @d = [[],[], [], []]
      5000.times do
        @a << rand(2**31)
        @b << rand(2**31)
        @c << rand( 2**8)
        @d << rand( 2**4)
      end
    end

#///////////////////////////////////////////////////////////////////////////////
    context 'as register' do                   # AS REGISTERS   ////////////////
#///////////////////////////////////////////////////////////////////////////////


      it 'AND' do
        # Find R1 (bitwise)AND R2
        prime '0000'
        @a.zip(@b).each do |a, b|
          reg_set_rand @raspi, a, b
          decode_and_run
          u_result.should eq(a & b)
        end
      end

      it 'EOR' do
        # Find R1 (bitwise)EOR R2
        prime '0001'
        @a.zip(@b).each do |a, b|
          reg_set_rand @raspi, a, b
          decode_and_run
          u_result.should eq(a ^ b)
        end
      end

      it 'SUB' do
        # Find R1 - R2
        prime '0010'
        @a.zip(@b).each do |a, b|
          reg_set_rand @raspi, a, b
          decode_and_run
          result.should eq(a - b)
        end
      end

      it 'RSB' do
        # Find R1 - R2
        prime '0011'
        @a.zip(@b).each do |a, b|
          reg_set_rand @raspi, a, b
          decode_and_run
          result.should eq(b - a)
        end
      end

      it 'ADD' do
        # Find R1 + R2
        prime '0100'
        @a.zip(@b).each do |a, b|
          reg_set_rand @raspi, a, b
          decode_and_run
          u_result.should eq(a + b)
        end
      end

      it 'ORR' do
        # Find R1 OR R2
        prime '1100'
        @a.zip(@b).each do |a, b|
          reg_set_rand @raspi, a, b
          decode_and_run
          u_result.should eq(a | b)
        end
      end

      it 'MOV' do
        # Result should be op2
        prime '1101'
        @a.zip(@b).each do |a, b|
          reg_set_rand @raspi, a, b
          decode_and_run
          u_result.should eq(b)
        end
      end

    end

#///////////////////////////////////////////////////////////////////////////////
    context 'as immediate, with shift' do      # IMMEDIATE, w/ SHIFT   /////////
#///////////////////////////////////////////////////////////////////////////////

      it 'AND' do
        # Find R1 (bitwise)AND Immd
        @a.zip(@c, @d).each do |a, c, d|
          prime_immediate '0000', c, d
          @raspi.set_reg(0, a) 
          decode_and_run
          u_result.should eq(a & ROR(c, 2*d))
        end
      end

      it 'EOR' do
        # Find R1 (bitwise)EOR Immd
        @a.zip(@c, @d).each do |a, c, d|
          prime_immediate '0001', c, d
          @raspi.set_reg(0, a) 
          decode_and_run
          u_result.should eq(a ^ ROR(c, 2*d))
        end
      end

      it 'ADD' do
        # Find R1 (bitwise)EOR Immd
        @a.zip(@c, @d).each do |a, c, d|
          prime_immediate '0100', c, d
          @raspi.set_reg(0, a) 
          decode_and_run
          exp = a + ROR(c, 2*d)
          if exp > 2**32
            exp -= 2**32
          end
          u_result.should eq(exp)
        end
      end

      it 'OOR' do
        # Find R1 (bitwise)OR Immd
        @a.zip(@c, @d).each do |a, c, d|
          prime_immediate '1100', c, d
          @raspi.set_reg(0, a) 
          decode_and_run
          u_result.should eq(a | ROR(c, 2*d))
        end
      end

      it 'MOV' do
        # Result should be op2
        @a.zip(@c, @d).each do |a, c, d|
          prime_immediate '1101', c, d
          @raspi.set_reg(0, a) 
          decode_and_run
          u_result.should eq(ROR(c, 2*d))
        end
      end


    end

#///////////////////////////////////////////////////////////////////////////////
    context 'as immediate, no shift' do        # IMMEDIATE, NO SHIFT   /////////
#///////////////////////////////////////////////////////////////////////////////

      it 'AND' do
        # Find R1 (bitwise)AND Immd
        @a.zip(@c).each do |a, c|
          prime_immediate '0000', c, 0
          @raspi.set_reg(0, a) 
          decode_and_run
          result.should eq(a & c)
        end
      end

      it 'EOR' do
        # Find R1 (bitwise)EOR Immd
        @a.zip(@c).each do |a, c|
          prime_immediate '0001', c, 0
          @raspi.set_reg(0, a) 
          decode_and_run
          result.should eq(a ^ c)
        end
      end

      it 'SUB' do
        # Find R1 - Immd
        @a.zip(@c).each do |a, c|
          prime_immediate '0010', c, 0
          @raspi.set_reg(0, a) 
          decode_and_run
          result.should eq(a - c)
        end
      end

      it 'RSB' do
        # Find Immd - R2
        @a.zip(@c).each do |a, c|
          prime_immediate '0011', c, 0
          @raspi.set_reg(0, a) 
          decode_and_run
          result.should eq(c - a)
        end
      end

      it 'ADD' do
        # Find R1 + Immd
        @a.zip(@c).each do |a, c|
          prime_immediate '0100', c, 0
          @raspi.set_reg(0, a) 
          decode_and_run
          result.should eq(a + c)
        end
      end

      it 'ORR' do
        # Find R1 OR R2
        @a.zip(@c).each do |a, c|
          prime_immediate '1100', c, 0
          @raspi.set_reg(0, a) 
          decode_and_run
          result.should eq(a | c)
        end
      end

      it 'MOV' do
        # Result should be op2
        @a.zip(@c).each do |a, c|
          prime_immediate '1101', c, 0
          @raspi.set_reg(0, a) 
          decode_and_run
          result.should eq(c)
        end
      end

    end
  end
end
