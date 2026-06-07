module curve_starc05_2_5_1_7_20260111_221225_321798_w38092_attempt11 (
  input wire        clk,
  input wire        reset_n,
  input wire [2:0]  data_i,
  input wire        enable_i,
  inout  wire [2:0] tri_state_bus_o,
  output reg [2:0]  logic_out_o
);

  // Internal register to hold data to be driven out on tri_state_bus_o
  reg [2:0] tri_state_data_r;

  // Tri-state buffer control: drive tri_state_bus_o with tri_state_data_r when enable_i is high,
  // otherwise put it in high-impedance state (Z).
  assign tri_state_bus_o = enable_i ? tri_state_data_r : 3'bZ;

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      tri_state_data_r <= 3'b0;
      logic_out_o      <= 3'b0;
    end else begin
      // Update the data for the tri-state output
      tri_state_data_r <= data_i;

      // Violation 1: tri_state_bus_o[0] used in an if condition
      if (tri_state_bus_o[0]) begin
        logic_out_o[0] <= 1'b1;
      end else begin
        logic_out_o[0] <= 1'b0;
      end

      // Violation 2: tri_state_bus_o[1] used in an if condition
      if (tri_state_bus_o[1]) begin
        logic_out_o[1] <= 1'b1;
      end else begin
        logic_out_o[1] <= 1'b0;
      end
      
      // Violation 3: tri_state_bus_o[2] used in an if condition
      if (tri_state_bus_o[2]) begin
        logic_out_o[2] <= 1'b1;
      end else begin
        logic_out_o[2] <= 1'b0;
      end
    end
  end

endmodule
