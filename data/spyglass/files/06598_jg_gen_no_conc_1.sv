module top_gen_no_conc_1 (
  input wire clk,
  input wire rst,
  input wire [7:0] data_in,
  output wire [7:0] data_out
);

  assign data_out = data_in;

  generate
    // This generate block does not contain a conditional construct
    // and will trigger GEN_NO_CONC.
    reg [7:0] gen_reg_a;
    always @(posedge clk or posedge rst) begin
      if (rst) begin
        gen_reg_a <= 8'h00;
      end else begin
        gen_reg_a <= data_in;
      end
    end
  endgenerate

endmodule
