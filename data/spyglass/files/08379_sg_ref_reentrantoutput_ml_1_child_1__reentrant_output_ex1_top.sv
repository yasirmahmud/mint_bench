module reentrant_output_ex1_top;
 wire internal_signal;
 wire sub_output_signal; // New wire to break the combinational loop
 sub_module u_sub (.in_a(internal_signal), .out_b(sub_output_signal)); // Connect out_b to the new signal
 endmodule
