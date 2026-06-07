module curve_synth_77_20260111_154018_106011_w21676_attempt5 (
    input wire clk,
    input wire rst_n,
    input wire [7:0] in_data,
    input wire comb_assign_en,
    output reg [7:0] out_reg
);

  // This always block performs non-blocking assignments for synchronous updates.
  // 'out_reg' is assigned using '<='.
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg <= 8'h00; // Non-blocking assignment for reset
    end else begin
      out_reg <= in_data + 1; // Non-blocking assignment for sequential update
    end
  end

  // This always block performs a blocking assignment for a combinational path.
  // 'out_reg' is assigned using '='.
  // The presence of both blocking and non-blocking assignments to the same
  // variable 'out_reg' across different always blocks triggers SYNTH_77.
  // This also implies multiple drivers for 'out_reg', which is necessary
  // to clearly demonstrate the conflicting assignment types without other issues
  // like mixed sensitivity lists within a single block.
  always @(*) begin
    if (comb_assign_en) begin
      out_reg = in_data; // Blocking assignment
    end
  end

endmodule
