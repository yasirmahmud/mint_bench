module curve_starc05_2_3_1_6_20260111_191259_572783_w53504_attempt9 (
  input wire clk,
  input wire rst_sync,    // Synchronous active-high reset
  input wire rst_vio,     // Signal intended for STARC05-2.3.1.6 violation
  input wire data_in,
  output reg data_out
);

  // This always block implements a D-type flip-flop with a synchronous reset.
  // 'rst_vio' is included in the asynchronous sensitivity list as 'posedge rst_vio',
  // implying an active-high asynchronous event for a reset.
  // However, inside the block, it's used in a condition '(!rst_vio)' which checks for active-low.
  // This discrepancy between the edge specified in the sensitivity list (posedge) and
  // the logic level checked in the condition (active-low) triggers the STARC05-2.3.1.6 rule.
  // By making 'rst_vio' part of a combined condition (data_in && !rst_vio) and not the primary 
  // asynchronous reset, we aim to make the module synthesizable without triggering SYNTH_5192 errors,
  // while still clearly demonstrating the STARC05-2.3.1.6 warning.
  always @(posedge clk or posedge rst_vio) begin
    if (rst_sync) begin // Correct synchronous active-high reset
      data_out <= 1'b0;
    end else if (data_in && !rst_vio) begin // STARC05-2.3.1.6 violation occurs here
      // 'posedge rst_vio' in sensitivity list implies an active-high asynchronous event.
      // But the condition checks for '!rst_vio' (active-low).
      data_out <= 1'b1; // An arbitrary state change, not a full reset to zero, to potentially avoid SYNTH_5192
    end else begin
      data_out <= data_in;
    end
  end

endmodule
