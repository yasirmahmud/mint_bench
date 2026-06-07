module curve_elab_6312_20260111_133615_attempt5 (
  input wire clk,
  input wire rst_n, // Active-low asynchronous reset
  input wire enable_condition,
  input wire data_in,
  output reg data_out
);

  // The 'iff' construct in the sensitivity list is a SystemVerilog feature
  // and is not supported in Verilog-2001. This will trigger an ELAB_6312 violation.
  // This example uses 'posedge' and includes a reset, making it distinct from previous attempts.
  always @(posedge clk iff enable_condition) begin
    if (!rst_n) begin // Asynchronous active-low reset
      data_out <= 1'b0;
    end else begin
      data_out <= data_in;
    end
  end

endmodule
