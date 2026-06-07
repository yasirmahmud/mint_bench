// Module definition for mux5to1 (5-to-1 Multiplexer)
// Selects one of five inputs based on the 'sel' signal.
module mux5to1 # (
  parameter DATA_WIDTH = `DATA_WIDTH
) (
  input  [DATA_WIDTH-1:0] in0,
  input  [DATA_WIDTH-1:0] in1,
  input  [DATA_WIDTH-1:0] in2,
  input  [DATA_WIDTH-1:0] in3,
  input  [DATA_WIDTH-1:0] in4,
  input  [`LOG_NUM_PORT-1:0] sel,
  output [DATA_WIDTH-1:0] out
);

  reg [DATA_WIDTH-1:0] out_reg;

  always @(*) begin
    case (sel)
      3'd0: out_reg = in0;
      3'd1: out_reg = in1;
      3'd2: out_reg = in2;
      3'd3: out_reg = in3;
      3'd4: out_reg = in4;
      default: out_reg = 'bx; // Handles unassigned select values
    endcase
  end

  assign out = out_reg;

endmodule
