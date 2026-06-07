module demux1_2_behav (in, sel, y);
    input in;      // Input signal
    input sel;     // Selection signal
    output reg [1:0] y; // 2-bit output (using reg type for procedural assignment)
    
    // Behavioral description using case statement
    always @(*) begin
        case(sel)
            1'd0: y[0] = in;  // If sel = 0, y[0] = in, y[1] = 0
            1'd1: y[1] = in;  // If sel = 1, y[0] = 0, y[1] = in
            default: y = 2'b00; // Default case to avoid latches (not really needed here)
        endcase
    end
endmodule
