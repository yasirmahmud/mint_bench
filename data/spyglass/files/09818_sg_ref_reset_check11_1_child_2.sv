module reset_check11_ex1 (input clk, input rst_n_or_p, input d1, input d2, output reg q1, output reg q2);

  // Introduce separate wires for each reset polarity to resolve W392 violation
  wire rst_active_high = rst_n_or_p;
  wire rst_active_low = !rst_n_or_p;

  // q1 uses active-high reset
  always @(posedge clk or posedge rst_active_high) begin
    if (rst_active_high) begin // Original: if (rst_n_or_p)
      q1 <= 1'b0;
    end else begin
      q1 <= d1;
    end
  end

  // q2 uses active-low reset (derived to be active-high for this block)
  always @(posedge clk or posedge rst_active_low) begin // Original: posedge clk or negedge rst_n_or_p is equivalent to posedge !rst_n_or_p
    if (rst_active_low) begin // Original: if (!rst_n_or_p)
      q2 <= 1'b0;
    end else begin
      q2 <= d2;
    end
  end
endmodule
