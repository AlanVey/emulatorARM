PROG = assembler emulator

all: $(PROG)

rebuild:
	@-$(MAKE) clean
	@-clear
	@-$(MAKE) all

clean:
	@-$(foreach bin, $(PROG), make -C ./build/$(bin) clean;)

$(PROG):
	@-$(MAKE) -C ./build/$@

