module curve_stx_ve_315_20260110_142950_attempt4 (
  input wire        clk,
  input wire        rst_n,
  input wire        enable,
  input wire [7:0]  data_in,
  output reg [7:0]  data_out
);

  // Define a non-void function that returns an 8-bit value
  function automatic [7:0] my_func (input [7:0] arg);
    reg [7:0] temp_val;
    begin
      // Initialize my_func to avoid STX_VE_310 (no return from non-void function)
      my_func = 8'd0;
      temp_val = arg + 1;

      // Violation 1: 'return;' without an explicit value expression inside a case branch
      case (arg[1:0])
        2'b00: begin
          my_func = temp_val + 2;
          return; // FATAL STX_VE_315
        end
        2'b01: begin
          my_func = arg - 1;
        end
        default: begin
          my_func = arg * 2;
        end
      endcase

      // Violation 2: 'return;' without an explicit value expression inside an if branch
      // This case is distinct as it's a separate conditional block after the case statement.
      if (arg == 8'd15) begin
        my_func = 8'hAA;
        return; // FATAL STX_VE_315
      end else if (arg == 8'd20) begin
        my_func = 8'hBB;
      end
      // If neither return is hit, my_func's value from the case or initial assignment will be used.
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
