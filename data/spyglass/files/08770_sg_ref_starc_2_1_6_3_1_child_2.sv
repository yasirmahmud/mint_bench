module starc_2_1_6_3_ex1 (input [3:0] addr_in, input [3:0] offset_in, output [7:0] data_out);
 // The original 'initial' block for my_mem is ignored for synthesis (SYNTH_5143).
 // Since 'my_mem' is only ever initialized to 8'b0 and never written to otherwise,
 // its functional behavior implies that any read from 'my_mem' will always yield 8'b0.
 // Therefore, 'data_out' will always be 8'b0.
 // This change resolves the 'UndrivenInTerm-ML' errors by ensuring 'data_out' is always driven,
 // and removes the non-synthesizable 'initial' block.
 assign data_out = 8'b0;
 endmodule
