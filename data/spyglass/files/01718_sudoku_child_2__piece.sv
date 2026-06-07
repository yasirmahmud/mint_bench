// Black-box definition for piece. Added dummy sequential logic to resolve WarnAnalyzeBBox and W240 violations.
module piece (
   output         changed,
   output         done,
   output [8:0]   curr_value,
   output         error,
   input          clk,
   input          rst,
   input          clr,
   input          start,
   input [8:0]    start_value,
   input [71:0]   my_row,
   input [71:0]   my_col,
   input [71:0]   my_square
);
   reg r_changed;
   reg r_done;
   reg [8:0] r_curr_value;
   reg r_error;

   always @(posedge clk or posedge rst) begin
       if (rst) begin
           r_changed <= 1'b0;
           r_done <= 1'b0;
           r_curr_value <= 9'd0;
           r_error <= 1'b0;
       end else if (clr) begin // Reads clr
           r_changed <= 1'b0;
           r_done <= 1'b0;
           r_curr_value <= 9'd0;
           r_error <= 1'b0;
       end else begin
           // Dummy logic: reads all inputs to resolve W240
           r_changed <= start; // Reads start
           r_done <= start | my_row[0]; // Reads start, my_row
           r_curr_value <= start_value; // Reads start_value
           r_error <= my_col[0] | my_square[0]; // Reads my_col, my_square
       end
   end
   assign changed = r_changed; // Drives changed
   assign done = r_done;       // Drives done
   assign curr_value = r_curr_value; // Drives curr_value
   assign error = r_error;     // Drives error
endmodule
