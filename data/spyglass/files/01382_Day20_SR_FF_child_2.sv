module Day20_SR_FF(input s,
                   input r,
                   input clk,
                   input rst,
                   output reg Q);
  
  // Internal register to hold the logical data value of Q (0 or 1)
  // This value is maintained even when Q is in high impedance state.
  reg q_internal_data;

  always @ (posedge clk) begin
    if(rst) begin
      q_internal_data <= 1'b0;      // Reset internal data to 0
      Q               <= 1'b0;      // Reset Q to 0 (driven, not tri-stated)
    end
    else begin
      casez ({s,r})
        2'b00: begin               // Maintain Q based on q_internal_data
          // q_internal_data retains its value by default (no assignment needed here)
          Q <= q_internal_data;  // Ensure Q is driven by internal data
        end
        2'b01: begin               // Clear Q
          q_internal_data <= 1'b0;
          Q               <= 1'b0;  // Ensure Q is driven to 0
        end
        2'b10: begin               // Set Q
          q_internal_data <= 1'b1;
          Q               <= 1'b1;  // Ensure Q is driven to 1
        end
        2'b11: begin               // Force Q to high impedance
          // q_internal_data value does not matter for Q at this moment, it retains its previous value
          Q               <= 1'bz;  // Tri-state Q
        end
      endcase
    end
  end
endmodule
