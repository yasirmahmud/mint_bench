module top_module (
  input wire clk_i,
  input wire rst_ni,
  input wire data_in_i,
  output wire data_out_o
);
  wire internal_signal;
  reg  registered_data;

  // WRN_33: Module instance name not specified
  sub_block (
    .in_a(data_in_i),
    .in_b(rst_ni),
    .out_c(internal_signal)
  );

  always @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
      registered_data <= 1'b0;
    end else begin
      registered_data <= internal_signal;
    end
  end

  assign data_out_o = registered_data;
endmodule
