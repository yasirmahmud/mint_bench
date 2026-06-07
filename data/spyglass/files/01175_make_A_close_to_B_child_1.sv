module make_A_close_to_B (Ain, Bin, Start, Ack, Clk, Reset,
				Flag, Qi, Qc, Qd, A);

input [11:0] Ain, Bin;
input Start, Ack, Clk, Reset;
output Flag;
output Qi, Qc, Qd;
output [11:0] A;

// Internal registers for state and data path elements
reg [11:0] A_reg; // Data path register for A
reg [11:0] B_reg; // Data path register for B
reg [2:0] state_reg; // Current state register
reg [2:0] next_state; // Combinational next state
reg Flag_reg; // Flag register

localparam
INI	= 3'b001,
ADJ	= 3'b010,
DONE = 3'b100;

// Output assignments from internal registers
assign {Qd, Qc, Qi} = state_reg; // Outputs Qi, Qc, Qd reflect the current state
assign A = A_reg; // Output A reflects the value of A_reg
assign Flag = Flag_reg; // Output Flag reflects the value of Flag_reg

// State Register Update (Sequential Logic)
always @(posedge Clk, posedge Reset) begin
  if (Reset) begin
    state_reg <= INI; // Initialize state
  end else begin
    state_reg <= next_state; // Update state on clock edge
  end
end

// Data Path Register Updates (Sequential Logic)
always @(posedge Clk, posedge Reset) begin
  if (Reset) begin
    A_reg <= 12'b0;      // Fix NoAssignX-ML: Initialize A to a known value
    B_reg <= 12'b0;      // Fix NoAssignX-ML: Initialize B to a known value
    Flag_reg <= 1'b0;    // Fix NoAssignX-ML: Initialize Flag to a known value
  end else begin
    // Default assignments: registers hold their current values if not explicitly updated in a state
    A_reg <= A_reg;
    B_reg <= B_reg;
    Flag_reg <= Flag_reg;

    case (state_reg) // Operations based on the CURRENT state
      INI	: begin
        // RTL operations in the DPU (Data Path Unit)
        // Load Ain and Bin regardless of Start, as per original behavior
        A_reg <= Ain;
        B_reg <= Bin;
        Flag_reg <= 1'b0; // Flag is cleared at the start
      end
      ADJ	: begin
        // RTL operations in the Data Path to modify A toward B
        // Fix W528: B is now read and used for A's adjustment
        if (A_reg < B_reg) begin
          A_reg <= A_reg + 1'b1; // Increment A if less than B
        end else if (A_reg > B_reg) begin
          A_reg <= A_reg - 1'b1; // Decrement A if greater than B
        end
        Flag_reg <= 1'b0; // Flag remains cleared during adjustment
      end
      DONE	: begin
        // Signal completion by setting Flag
        Flag_reg <= 1'b1;
      end
      default: begin
        // Handle unexpected states defensively
        A_reg <= 12'b0;
        B_reg <= 12'b0;
        Flag_reg <= 1'b0;
      end
    endcase
  end
end

// Next State Logic (Combinational Logic)
always @* begin
  next_state = state_reg; // Default: stay in the current state

  case (state_reg) // State transitions based on the CURRENT state and inputs
    INI	: begin
      if (Start) begin
        next_state = ADJ;
      end
    end
    ADJ	: begin
      // Transition to DONE when A equals B (adjustment complete)
      if (A_reg == B_reg) begin
        next_state = DONE;
      end
    end
    DONE	: begin
      if (Ack) begin
        next_state = INI;
      end
    end
    default: begin
      next_state = INI; // Handle unexpected states defensively
    end
  endcase
end

endmodule
