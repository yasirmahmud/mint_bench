module curve_stx_ve_647_20260111_224935_344119_w32456_attempt12 (
  input i_clk,
  input i_reset_n,
  output reg [3:0] o_data
);

  // STX_VE_647: This declaration is for a signal not present in the module's port list (i_clk, i_reset_n, o_data).
  // This line should trigger STX_VE_647, as 'cvif_rd_req_ready' is declared as input though not in module header.
  input cvif_rd_req_ready;

  reg [3:0] counter_val;

  always @(posedge i_clk or negedge i_reset_n) begin
    if (!i_reset_n) begin
      counter_val <= 4'd0;
      o_data      <= 4'd0;
    end else begin
      if (cvif_rd_req_ready) begin // Use the unlisted input to prevent unused signal warnings.
        counter_val <= counter_val + 4'd1;
      end
      o_data <= counter_val; // Drive output with the internal register.
    end
  end

endmodule
