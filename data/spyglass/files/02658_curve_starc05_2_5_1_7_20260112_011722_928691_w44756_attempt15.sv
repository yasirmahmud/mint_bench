module curve_starc05_2_5_1_7_20260112_011722_928691_w44756_attempt15 (
  input wire        data_in,
  input wire [2:0]  enable_in,     // Enables for individual tri-state bits
  input wire        control_in,    // Control signal for logic_status_o
  output tri  [2:0] tri_bus_o,     // Tri-state output bus
  output reg  [2:0] logic_status_o // Logic output register
);

  // Drive the tri-state outputs. Each bit is driven independently.
  assign tri_bus_o[0] = enable_in[0] ? data_in : 1'bz;
  assign tri_bus_o[1] = enable_in[1] ? data_in : 1'bz;
  assign tri_bus_o[2] = enable_in[2] ? data_in : 1'bz;

  always @(*) begin
    // Default assignments to ensure no latches are inferred
    logic_status_o = 3'b0;

    // Violation 1: tri_bus_o[0] used directly in an if condition
    if (tri_bus_o[0]) begin // STARC05-2.5.1.7 violation 1
      logic_status_o[0] = data_in;
    end else begin
      logic_status_o[0] = ~data_in;
    end

    // Violation 2: tri_bus_o[1] used in a negated if condition
    // This violation is placed within a nested if statement for distinctness.
    if (control_in) begin
      if (!tri_bus_o[1]) begin // STARC05-2.5.1.7 violation 2
        logic_status_o[1] = 1'b1;
      end else begin
        logic_status_o[1] = 1'b0;
      end
    end else begin
      logic_status_o[1] = data_in; // Ensure full assignment to avoid latch
    end

    // Violation 3: tri_bus_o[2] used in a compound if condition
    // This shows the tri-state signal as part of a boolean expression.
    if (enable_in[2] && tri_bus_o[2]) begin // STARC05-2.5.1.7 violation 3
      logic_status_o[2] = 1'b1;
    end else if (~control_in) begin
      logic_status_o[2] = data_in; // Ensure full assignment to avoid latch
    end else begin
      logic_status_o[2] = 1'b0;
    end
  end

endmodule
