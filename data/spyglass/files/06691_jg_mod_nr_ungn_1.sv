module unnamed_gen_for_example (
  input wire clk,
  input wire rst,
  input wire [3:0] in_data,
  output wire [3:0] out_data
);

  wire [3:0] internal_data;

  generate
    for (genvar i = 0; i < 4; i = i + 1) begin
      assign internal_data[i] = in_data[i];
    end
  endgenerate

  assign out_data = internal_data;

endmodule
