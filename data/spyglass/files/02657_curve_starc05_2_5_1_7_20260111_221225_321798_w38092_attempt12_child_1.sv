module curve_starc05_2_5_1_7_20260111_221225_321798_w38092_attempt12 (
  input wire        clk,
  input wire        reset_n,
  input wire        data_i,
  input wire        enable_i,
  input wire [1:0]  sel_i,
  inout  wire       tri_state_sig_o, // Single tri-state output
  output reg [2:0]  logic_out_o
);

  // Internal register to hold data to be driven out on tri_state_sig_o
  reg tri_state_data_r;

  // Tri-state buffer control: drive tri_state_sig_o with tri_state_data_r when enable_i is high,
  // otherwise put it in high-impedance state (Z).
  assign tri_state_sig_o = enable_i ? tri_state_data_r : 1'bZ;

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      tri_state_data_r <= 1'b0;
      logic_out_o      <= 3'b0;
    end else begin
      // Update the data for the tri-state output
      tri_state_data_r <= data_i;

      // Resolved Violation 1: tri_state_sig_o used directly in an if condition
      if (sel_i[0]) begin // Guard with sel_i to allow distinct branches
        if (enable_i && tri_state_data_r) begin // STARC05-2.5.1.7 violation fixed
          logic_out_o[0] <= 1'b1;
        end else begin
          logic_out_o[0] <= 1'b0;
        }
      end else begin
        logic_out_o[0] <= 1'b0;
      end

      // Resolved Violation 2: tri_state_sig_o used in a negated if condition
      if (sel_i[1]) begin // Guard with sel_i to allow distinct branches
        if (enable_i && !tri_state_data_r) begin // STARC05-2.5.1.7 violation fixed
          logic_out_o[1] <= 1'b1;
        end else begin
          logic_out_o[1] <= 1'b0;
        }
      end else begin
        logic_out_o[1] <= 1'b0;
      end
      
      // Resolved Violation 3: tri_state_sig_o used in an 'else if' condition
      if (sel_i[0] && sel_i[1]) begin
        logic_out_o[2] <= 1'b0;
      end else if (enable_i && tri_state_data_r) begin // STARC05-2.5.1.7 violation fixed
        logic_out_o[2] <= 1'b1;
      end else {
        logic_out_o[2] <= 1'b0;
      }
    end
  end

endmodule
