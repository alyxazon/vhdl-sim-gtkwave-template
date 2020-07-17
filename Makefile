# Project
VHD_FILES    := clock.vhd testbench.vhd
TB_NAME      := testbench
STOP_TIME    := 1ms

# Generic settings
GHDL_BIN    := ghdl
GHDL_FLAGS  := --ieee=synopsys --warn-no-vital-generic
GTKWAVE_BIN := gtkwave
VCD_NAME    := $(TB_NAME).vcd

# Targets
all: analyze check_syntax elaborate run

analyze:
	$(GHDL_BIN) -a $(GHDL_FLAGS) $(VHD_FILES)

check_syntax:
	$(GHDL_BIN) -s $(GHDL_FLAGS) $(VHD_FILES)

elaborate:
	$(GHDL_BIN) -e $(GHDL_FLAGS) $(TB_NAME)

run:
	$(GHDL_BIN) -r $(TB_NAME) --stop-time=$(STOP_TIME) --vcd=$(VCD_NAME)

view:
	$(GTKWAVE_BIN) $(VCD_NAME) &

clean:
	rm *.cf
	rm *.vcd
