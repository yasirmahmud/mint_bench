module reentrant_output_ex2();
 wire sig_a;
 wire sig_b; // Introduce a new wire to break the combinational loop
 my_sub_module u_inst (.in_port(sig_a), .out_port(sig_b)); // Connect output to the new wire
endmodule
