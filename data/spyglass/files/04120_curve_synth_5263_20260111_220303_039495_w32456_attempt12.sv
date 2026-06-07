module curve_synth_5263_20260111_220303_039495_w32456_attempt12 (
  input clk,
  input rst_n,
  input enable_a,
  input enable_b,
  input [7:0] data_in,
  output reg [7:0] out_reg_a,
  output reg [7:0] out_reg_b
);

  // First instance: SYNTH_5263 - Fork and Join constructs are not synthesizable
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg_a <= 8'h00;
    end else begin
      if (enable_a) begin
        fork
          out_reg_a <= data_in;
        join
      end else begin
        out_reg_a <= 8'hAA; // Synthesizable path for out_reg_a
      end
    end
  end

  // Second instance: SYNTH_5263 - Fork and Join constructs are not synthesizable
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      out_reg_b <= 8'h00;
    end else begin
      if (enable_b) begin
        fork
          out_reg_b <= data_in + 8'd1;
        join
      end else begin
        out_reg_b <= 8'hBB; // Synthesizable path for out_reg_b
      end
    end
  end

endmodule
