module top_ex2;
  reg [2:0] a_sig;

  initial begin
    a_sig = 3'b0; // Initialize a_sig to resolve 'undriven' warning
  end

  wire [4:0] unused_dummy_out; // Declare a wire for the new output port of the instance

  sub_ex2 inst_ex2 (
    .in_port({2'b0, a_sig}), // Actual width is 5, matches updated sub_ex2 port
    .dummy_out(unused_dummy_out) // Connect the new dummy output port
  );
endmodule
