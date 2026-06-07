module Day20_SR_FF(input s,
                   input r,
                   input clk,
                   input rst,
                   output Q);
  
  // Internal register to hold the logical data value of Q (0 or 1)
  reg q_data;
  // Control signal: 0 when Q is driven by q_data, 1 when Q is high impedance
  reg q_tristate_en;

  // Drive the output Q based on the control signal and data
  assign Q = q_tristate_en ? 1'bz : q_data;

  always @ (posedge clk)
    begin
      if(rst) begin
        q_data        <= 1'b0;      // Reset Q to 0
        q_tristate_en <= 1'b0;      // Ensure Q is driven (not tri-stated)
      end
      else begin
        casez ({s,r})
          2'b00: begin               // Maintain Q
            // q_data retains its value by default (no assignment needed here)
            q_tristate_en <= 1'b0;  // Ensure Q is driven
          end
          2'b01: begin               // Clear Q
            q_data        <= 1'b0;
            q_tristate_en <= 1'b0;  // Ensure Q is driven
          end
          2'b10: begin               // Set Q
            q_data        <= 1'b1;
            q_tristate_en <= 1'b0;  // Ensure Q is driven
          end
          2'b11: begin               // Force Q to high impedance
            // q_data value does not matter when output is tri-stated
            q_tristate_en <= 1'b1;  // Tri-state Q
          end
        endcase
      end
    end
endmodule
