module target_module_ex2(input in1);
parameter P1=10;
parameter P2=20;

wire dummy_in_conn; // Declare a dummy wire to connect the input
assign dummy_in_conn = in1; // Assign the input to the dummy wire to resolve 'input not read'

// Use parameters in a localparam to make the module non-empty and ensure parameters are utilized.
// This also helps resolve 'empty definition' warning.
localparam PARAM_CALC = P1 + P2; 

endmodule
