module enc4to2 (
    input [3:0] in,
    input en,
    output wire [1:0] y
);

  reg [1:0] y_data;

  // Calculate the encoded data when the module is logically enabled
  // The sensitivity list only includes 'in' as 'y_data' depends solely on 'in' for its value.
  always @(in) begin
    case (in)
      4'b0001 : y_data = 2'b00;
      4'b0010 : y_data = 2'b01;
      4'b0100 : y_data = 2'b10;
      4'b1000 : y_data = 2'b11;
      default : y_data = 2'bzz; // Preserve original behavior for invalid 'in' when enabled
    endcase
  end

  // Use a continuous assignment to implement the tri-state output 'y'.
  // This resolves the 'NoAssignX-ML' by using '2'bzz' for the disabled state
  // and resolves 'STARC05-2.5.1.2' by explicitly defining a tri-state buffer
  // with 'en' as its simple enable condition.
  assign y = en ? y_data : 2'bzz;

endmodule
