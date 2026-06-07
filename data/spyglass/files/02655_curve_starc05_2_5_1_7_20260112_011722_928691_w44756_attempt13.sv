module curve_starc05_2_5_1_7_20260112_011722_928691_w44756_attempt13 (
  input wire [1:0] sel_i,
  input wire [2:0] data_i,
  input wire [2:0] logic_data_i,
  output tri [2:0] tri_state_bus_o,
  output reg [2:0] logic_out_o
);

  // Declare tri_state_bus_o as a tri-state output
  // Tri-state output is enabled by sel_i[1]
  assign tri_state_bus_o = sel_i[1] ? data_i : 3'bz;

  always @(*) begin
    logic_out_o = 3'b0; // Default assignment to avoid latches

    case (sel_i[1:0]) // Use the full 2-bit selector for distinct branches
      2'b00: begin
        // STARC05-2.5.1.7 violation 1: tri_state_bus_o[0] used in an if condition
        if (tri_state_bus_o[0]) begin
          logic_out_o[0] = logic_data_i[0];
        end else begin
          logic_out_o[0] = ~logic_data_i[0];
        end
      end

      2'b01: begin
        // STARC05-2.5.1.7 violation 2: tri_state_bus_o[1] used in an if condition
        if (tri_state_bus_o[1]) begin
          logic_out_o[1] = logic_data_i[1];
        end else begin
          logic_out_o[1] = ~logic_data_i[1];
        end
      end

      2'b10: begin
        // STARC05-2.5.1.7 violation 3: tri_state_bus_o[2] used in an if condition
        if (tri_state_bus_o[2]) begin
          logic_out_o[2] = logic_data_i[2];
        end else begin
          logic_out_o[2] = ~logic_data_i[2];
        end
      end

      default: begin
        // This path ensures all case branches are covered and does not trigger a violation.
        logic_out_o = 3'b111;
      end
    endcase
  end

endmodule
