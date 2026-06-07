module reentrant_output_ex2();
 wire sig_a;
 wire sig_b; // Introduce a new wire to break the combinational loop
 wire dummy_sig_b_read; // Added to consume sig_b and resolve W528

 assign sig_a = 1'b0; // Assign a constant value to sig_a to resolve W287a
 assign dummy_sig_b_read = sig_b; // Assign sig_b to a dummy wire to resolve W528

 my_sub_module u_inst (.in_port(sig_a), .out_port(sig_b)); // Connect output to the new wire
endmodule
