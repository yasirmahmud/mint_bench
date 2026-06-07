module curve_elab_6312_20260111_133615_attempt2 (
  input wire clk,
  input wire rst,        // Active low reset
  input wire rst_en,     // Enable for reset edge
  input wire d_in,       // 1-bit data input
  output reg q_out       // 1-bit data output
);

  // The 'iff' construct is a SystemVerilog feature and is not supported in Verilog-2001.
  // Using it in the sensitivity list of an always block will trigger an ELAB_6312 violation.
  // This example uses 'negedge rst iff rst_en' which is distinct from the previous attempt.
  always @(negedge rst iff rst_en or posedge clk) begin
    if (!rst) begin // Asynchronous active-low reset
      q_out <= 1'b0;
    end else begin // Synchronous data path
      q_out <= d_in;
    end
  end

endmodule
