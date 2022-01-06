%.hex: %.elf
ifeq ($(VERBOSE),1)
	$(HEX) $< $@
else
	@echo -e "[HEX]\t./$@"
	@$(HEX) $< $@
endif

%.bin: %.elf
ifeq ($(VERBOSE),1)
	$(BIN) $< $@
else
	@echo -e "[BIN]\t./$@"
	@$(BIN) $< $@
endif
