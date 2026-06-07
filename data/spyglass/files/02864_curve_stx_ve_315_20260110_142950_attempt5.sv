module curve_stx_ve_315_20260110_142950_attempt5 (
  input wire        clk,
  input wire        rst_n,
  input wire        enable,
  input wire [7:0]  data_in,
  output reg [7:0]  data_out
);

  // Define a non-void function that returns an 8-bit value
  function automatic [7:0] my_func (input [7:0] arg);
    reg [7:0] local_val; // Local variable for processing
    integer i;

    begin
      // Initialize my_func to avoid STX_VE_310 (no return from non-void function in all paths)
      my_func = 8'd0;
      local_val = arg;

      // Violation 1: 'return;' without an explicit value expression inside an if statement.
      // This is distinct from previous attempts as it's a simple, standalone if-block.
      if (arg[0]) begin // If the LSB is set
        local_val = local_val + 8'd5;
        my_func = local_val;
        return; // FATAL STX_VE_315 (1st occurrence)
      end

      // Violation 2: 'return;' without an explicit value expression inside a for loop.
      // This is distinct from previous attempts, which used case and other if-else structures.
      for (i = 0; i < 4; i = i + 1) begin
        if (arg[i+1]) begin // Check bits 1 through 4
          local_val = local_val + (8'd1 << i);
          my_func = local_val; // Assign before immediate return to ensure function has a value
          return; // FATAL STX_VE_315 (2nd occurrence)
        end
      end

      // Default assignment if neither of the 'return' statements above are hit
      my_func = local_val + arg[7:4];
    end
  endfunction

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_out <= 8'd0;
    end else if (enable) begin
      data_out <= my_func(data_in);
    end
  end

endmodule
