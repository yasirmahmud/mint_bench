module largest_num_divisible_by_7 (Max_out, Start, Ack, Clk, Reset, 
				 Qi, Ql, Qdiv, Qdf, Qdnf);

input Start, Ack, Clk, Reset;
output [7:0] Max_out;
output Qi, Ql, Qdiv, Qdf, Qdnf;

reg [7:0] M [0:15]; // Array of numbers to process
reg [7:0] X;        // Current number being processed
reg [4:0] state;    // FSM current state register
reg [4:0] next_state; // FSM next state (combinational calculation)
reg [7:0] Max;      // Internal register to hold the largest number divisible by 7
reg [3:0] I;        // Array index

localparam 
INI = 	5'b00001, // "Initial" state
LD_X = 	5'b00010, // "Load X with the next M[I]" state
DIV = 	5'b00100, // "Divide X by 7 and Update Max if appropriate" state
D_F = 	5'b01000, // "Done Found largest number divisible by 7" state
D_NF = 	5'b10000 ;// "Done Not Found any non-zero number divisible by 7" state

localparam M_SIZE = 16; // Size of the array M (0 to 15, so 16 elements)
         
// Combinational assignment for state indicator outputs
assign {Qdnf, Qdf, Qdiv, Ql, Qi} = state;
// Assign internal Max register to the output port
assign Max_out = Max;

// Initial block to populate the internal array M.
// This resolves the "Variable 'M' read but never set" and "UndrivenInTerm-ML" violations.
// Since the design description implies 'M' is an internal array and no external loading
// mechanism is present, populating it with default values makes it a ROM-like structure.
// The values are examples; in a real design, these would be specific to requirements
// or loaded from a memory file for synthesis.
initial begin
  M[0] = 8'd14;
  M[1] = 8'd21;
  M[2] = 8'd5;
  M[3] = 8'd28;
  M[4] = 8'd10;
  M[5] = 8'd35;
  M[6] = 8'd1;
  M[7] = 8'd42;
  M[8] = 8'd3;
  M[9] = 8'd49;
  M[10] = 8'd2;
  M[11] = 8'd7;
  M[12] = 8'd0;
  M[13] = 8'd63;
  M[14] = 8'd70;
  M[15] = 8'd84;
end

// --- Sequential Logic Block: FSM State and Data Path Register Updates ---
always @(posedge Clk, posedge Reset) begin  : CU_n_DU_seq
  if (Reset) begin
    state <= INI;
    I <= 4'b0;          // Resolved NoAssignX-ML violation (line 31)
    Max <= 8'b0;        // Resolved NoAssignX-ML violation (line 32)
    X <= 8'b0;          // Resolved NoAssignX-ML violation (line 33)
  end else begin
    state <= next_state; // Update current state from combinational next_state (resolves STARC05-2.11.3.1)

    // Data Path Unit (DPU) operations, synchronous to clock and based on *current* state
    case (state) 
      INI:	 
        begin
          Max <= 0; // Initialize Max to 0
          I <= 0;   // Initialize array index
        end
      LD_X:	
        begin
          X <= M[I];    // Load X with the current array element (resolves W528 for X)
          I <= I + 1;   // Increment index for the next cycle (resolves W528 for I)
        end
      
      DIV :	
        begin
          // Check divisibility by 7 and update Max
          // Only update Max if X is non-zero, divisible by 7, and greater than current Max
          if ((X != 0) && ((X % 7) == 0) && (X > Max)) begin
            Max <= X;
          end
        end
      
      D_F:	
        begin  
          // No DPU operations in this state
        end    
      D_NF:	
        begin  
          // No DPU operations in this state
        end    
      default: begin
        // Default for any unhandled state, good for robustness
        Max <= Max;
        I <= I;
        X <= X;
      end
    endcase
  end 
end 

// --- Combinational Logic Block: FSM Next State Calculation ---
always @* begin : CU_comb
  next_state = state; // Default to stay in current state to avoid latches

  case (state) // State transitions based on *current* state and inputs
    INI:	 
      begin
        if (Start) begin
          next_state = LD_X;
        }
      end
    LD_X:	
      begin
        next_state = DIV; // Always transition to DIV after loading X and incrementing I
      end
    
    DIV :	
      begin
        // After processing the current X, check if all array elements have been processed
        if (I == M_SIZE) begin // All elements processed (I would be 16 after the last increment)
          if (Max == 0) begin // No non-zero number divisible by 7 was found
            next_state = D_NF;
          end else begin // A non-zero number divisible by 7 was found
            next_state = D_F;
          end
        end else begin
          next_state = LD_X; // More elements to process, go back to load the next one
        end
      end
    
    D_F:	
      begin  
        if (Ack) begin
          next_state = INI;
        end
      end    
    D_NF:	
      begin  
        if (Ack) begin
          next_state = INI;
        end
      end    
    default: next_state = INI; // Defensive default for unhandled states
  endcase
end

endmodule
