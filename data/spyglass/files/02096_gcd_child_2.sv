module gcd(
  input wire clk,
  input wire reset_n,
  input wire start_i, // Active high signal to start the GCD computation
  input wire [6:0] A, B,
  output reg done_o,  // Active high signal indicating GCD is ready
  output reg [6:0] GCD
);

  // Internal registers for the iterative computation
  reg [6:0] Ain_reg;
  reg [6:0] Bin_reg;

  // FSM states
  parameter IDLE    = 2'b00; // Waiting for start_i
  parameter COMPUTE = 2'b01; // Performing GCD subtractions
  parameter RESULT  = 2'b10; // GCD computation finished, output is ready

  reg [1:0] current_state;
  reg [1:0] next_state;

  // State and data registers update on clock edge
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      // Asynchronous reset
      current_state <= IDLE;
      Ain_reg       <= 0;
      Bin_reg       <= 0;
      GCD           <= 0;
      done_o        <= 0;
    end else begin
      // Synchronous updates
      current_state <= next_state;

      // Default done_o to low for most states,
      // it will be explicitly set high in the RESULT state.
      done_o <= 0; 

      case (current_state)
        IDLE: begin
          // When start_i is asserted, load inputs and transition to COMPUTE
          if (start_i) begin
            Ain_reg <= A;
            Bin_reg <= B;
          end
        end
        COMPUTE: begin
          // Perform one step of the Euclidean algorithm (subtraction) per cycle
          if (Ain_reg == Bin_reg) begin
            // Computation finished, latch the result
            GCD <= Ain_reg;
          end else if (Ain_reg < Bin_reg) begin
            Bin_reg <= Bin_reg - Ain_reg;
          end else begin // Ain_reg > Bin_reg
            Ain_reg <= Ain_reg - Bin_reg;
          end
        end
        RESULT: begin
          // Assert done_o for one cycle to signal valid output
          done_o <= 1;
          // GCD holds its latched value from the previous cycle
        end
      endcase
    end
  end

  // Combinational logic for next_state determination
  always @(*) begin
    next_state = current_state; // Default: stay in current state

    case (current_state)
      IDLE: begin
        if (start_i) begin
          next_state = COMPUTE;
        }
      end
      COMPUTE: begin
        // If Ain_reg and Bin_reg become equal, computation is done
        if (Ain_reg == Bin_reg) begin
          next_state = RESULT;
        }
      end
      RESULT: begin
        // After asserting done_o, return to IDLE to await next computation
        next_state = IDLE;
      end
    endcase
  end

endmodule
