module enc4to2_child_2 (
    input [3:0] in,
    input en,
    output wire [1:0] y
);

  // Changed from reg to wire and moved logic to continuous assignment
  wire [1:0] y_data_int;

  // Calculate the encoded data based on 'in'
  // Using continuous assignment for combinational logic instead of an always block
  assign y_data_int = (in == 4'b0001) ? 2'b00 :
                      (in == 4'b0010) ? 2'b01 :
                      (in == 4'b0100) ? 2'b10 :
                      (in == 4'b1000) ? 2'b11 :
                                        2'bx; // Use 'X' for internal undefined logic state for non-one-hot inputs

  // Use a continuous assignment to implement the tri-state output 'y'.
  // This resolves 'STARC05-2.5.1.2' by ensuring the data input to the tri-state
  // buffer (y_data_int) is a simple wire driven by a continuous assignment,
  // and uses a synthesizable '2'bx' for internal undefined logic instead of '2'bzz'.
  // The output 'y' still becomes '2'bzz' when 'en' is low, or '2'bx' when 'en' is high
  // and 'in' is invalid, matching the "undefined values otherwise" requirement.
  assign y = en ? y_data_int : 2'bzz;

endmodule
