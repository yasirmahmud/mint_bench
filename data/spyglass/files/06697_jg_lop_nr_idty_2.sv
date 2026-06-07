module LOP_NR_IDTY_example2 (
  input logic clk,
  input logic reset,
  output logic [7:0] out_data
);

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      out_data <= 8'h00;
    end else begin
      logic k; // Loop variable 'k' is of type 'logic', not recommended
      for (k = 0; k < 8; k++) begin
        out_data[k] <= k;
      end
    end
  end

endmodule
