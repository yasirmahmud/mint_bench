// This is the key: the dc_script_begin directive is placed AFTER the endmodule.
// This makes the Verilog module itself syntactically complete.
// SpyGlass should still parse the directive and then detect EOF before dc_script_end,
// triggering STX_VE_522 in isolation.
//synopsys dc_script_begin
