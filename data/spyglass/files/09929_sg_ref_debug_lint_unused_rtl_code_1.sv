module DEBUG_LINT_UNUSED_RTL_CODE_ex1 (input wire clk, input wire rst_n, input wire [7:0] data_in, output reg [7:0] data_out);
 reg [7:0] control_reg;
 always @(posedge clk or negedge rst_n) begin if (!rst_n) begin data_out <= 8'h00;
 end else begin if (control_reg[0]) begin data_out <= data_in;
 end else begin data_out <= 8'hFF;
 end end end endmodule
