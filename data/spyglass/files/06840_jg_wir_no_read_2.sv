module unread_wire_example2 (
  input [7:0] data_in,
  output reg [7:0] data_out
);

  wire intermediate_val;

  assign intermediate_val = data_in + 8'd1;

  always @* begin
    data_out = data_in;
  end

endmodule
