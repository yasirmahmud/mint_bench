`define NUM_PORT 5
`define DATA_WIDTH 32
`define LOG_NUM_PORT 3 // ceil(log2(NUM_PORT)) for 5 ports is 3 (0,1,2,3,4 needs 3 bits)

// Module definition for outSelTrans (Priority Encoder)
// Converts a priority vector (ppv) into a single selection signal (sel).
// Assumes higher index has higher priority.
module outSelTrans (
  input  [`NUM_PORT-1:0] ppv,
  output reg [`LOG_NUM_PORT-1:0] sel
);

  always @(*) begin
    sel = '0; // Default selection (e.g., port 0) if no priority bit is set

    // Priority encoder (higher index has higher priority)
    // This logic is specifically for NUM_PORT = 5
    if (ppv[4]) begin
      sel = 3'd4;
    end else if (ppv[3]) begin
      sel = 3'd3;
    end else if (ppv[2]) begin
      sel = 3'd2;
    end else if (ppv[1]) begin
      sel = 3'd1;
    end else if (ppv[0]) begin
      sel = 3'd0;
    end
  end

endmodule
