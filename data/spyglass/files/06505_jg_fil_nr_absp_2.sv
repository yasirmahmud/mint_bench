module top_abs_path_windows (
  input rst,
  output reg done
);

  `include "C:\\Users\\Public\\Documents\\constants.svh"

  always @(posedge rst) begin
    done <= 1'b0;
  end

endmodule
