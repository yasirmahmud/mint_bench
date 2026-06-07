module curve_starc05_2_5_1_7_20260112_011722_928691_w44756_attempt14 (
  input wire        data_i,
  input wire        enable_i,
  input wire [1:0]  sel_i,
  input wire [2:0]  logic_data_i,
  output tri        tri_out_o, // Single tri-state output bit
  output reg  [2:0] logic_out_o
);

  // Drive the tri-state output
  assign tri_out_o = enable_i ? data_i : 1'bz;

  always @(*) begin
    logic_out_o = 3'b0; // Default assignment to avoid latches

    case (sel_i)
      2'b00: begin
        // STARC05-2.5.1.7 violation 1: tri_out_o used directly in an if condition
        if (tri_out_o) begin
          logic_out_o[0] = logic_data_i[0];
        end else begin
          logic_out_o[0] = ~logic_data_i[0];
        end
      end

      2'b01: begin
        // STARC05-2.5.1.7 violation 2: tri_out_o used in a negated if condition
        if (!tri_out_o) begin
          logic_out_o[1] = logic_data_i[1];
        end else begin
          logic_out_o[1] = ~logic_data_i[1];
        end
      end

      2'b10: begin
        // STARC05-2.5.1.7 violation 3: tri_out_o used in a compound if condition
        // This still triggers the violation as tri_out_o is in the conditional expression.
        if (tri_out_o && logic_data_i[2]) begin
          logic_out_o[2] = 1'b1;
        end else begin
          logic_out_o[2] = 1'b0;
        end
      end

      default: begin // 2'b11
        // This path ensures all case branches are covered and does not trigger a violation related to tri_out_o.
        logic_out_o = {logic_data_i[2], logic_data_i[1], logic_data_i[0]};
      end
    endcase
  end

endmodule
