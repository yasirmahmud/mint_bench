module EvE_Crossover_Engine(ID, ParentA, ParentB, out, clk,rst, Rand, Config, readA, readB);
input [7:0] ID;
input [63:0] ParentA, ParentB;
input [35:0] Rand;
output reg [63:0] out;
output reg readA, readB;
input [31:0] Config;
input clk, rst;


wire eq_n, lw_n, gr_n;
wire eq_c, lw_c, gr_c;
wire [3:0] Select;
reg signalX;
reg stage;

wire [31:0] Crossover;

comparator #(8) compID1(.a(ParentA[47:40]), .b(ParentB[47:40]), .equal(eq_n), .lower(lw_n), .greater(gr_n));
comparator #(8) compID2(.a(ParentA[39:32]), .b(ParentB[39:32]), .equal(eq_c), .lower(lw_c), .greater(gr_c));

// Corrected comparator instantiations for Rand, leaving 'lower' port unconnected as it's not used
comparator #(32) compRand1(.a(Rand[35:4]),.b(Config[31:0]),.equal(),.lower(),.greater(Select[3]));
comparator #(32) compRand2(.a(Rand[34:3]),.b(Config[31:0]),.equal(),.lower(),.greater(Select[2]));
comparator #(32) compRand3(.a(Rand[33:2]),.b(Config[31:0]),.equal(),.lower(),.greater(Select[1]));
comparator #(32) compRand4(.a(Rand[32:1]),.b(Config[31:0]),.equal(),.lower(),.greater(Select[0]));

// Corrected mux instantiations to use generic mux_2to1 module
mux_2to1 #(8) bits31to24(.a(ParentA[31:24]), .b(ParentB[31:24]), .select(Select[3]), .out(Crossover[31:24]));
mux_2to1 #(8) bits23to16(.a(ParentA[23:16]), .b(ParentB[23:16]), .select(Select[2]), .out(Crossover[23:16]));
mux_2to1 #(8) bits15to8(.a(ParentA[15:8]), .b(ParentB[15:8]), .select(Select[1]), .out(Crossover[15:8]));
mux_2to1 #(8) bits7to0(.a(ParentA[7:0]), .b(ParentB[7:0]), .select(Select[0]), .out(Crossover[7:0]));

always @(posedge clk) begin
  // Declare next-state registers for synchronous updates
  reg next_signalX;
  reg next_stage;
  reg next_readA, next_readB;
  reg [63:0] next_out;

  // Default assignments (carry over current value) to avoid latches
  next_signalX = signalX;
  next_stage = stage;
  next_readA = readA;
  next_readB = readB;
  next_out = out;

  if (rst) begin
    next_signalX = 1'b1;
    next_stage = 1'b0;
    next_readA = 1'b0;
    next_readB = 1'b0;
    next_out = 64'h0; // Initialize out on reset
  end else begin
    next_stage = ~stage; // Stage always toggles unless reset

    if (signalX == 1'b1) begin // Initial state to set read signals high
      next_readA = 1'b1;
      next_readB = 1'b1;
      next_signalX = 1'b0; // Clear signalX after initial read
      // next_out retains its previous value ('out') as it's not explicitly assigned here.
    end else begin // !signalX is true
      // Default readA/readB to 0 unless explicitly set later in the conditions
      next_readA = 1'b0;
      next_readB = 1'b0;

      if (!stage) begin // stage = 0 (first main processing stage)
        // Default values for 'out' in this stage, to be overridden by conditions
        next_out[63:56] = 8'hFF; // Default ID to invalid
        next_out[55:0] = 56'h0;  // Default data to 0

        if (ParentA[55] == 1'b1 && ParentB[55] == 1'b1) begin  // Connections
          if (eq_n == 1'b1 && eq_c == 1'b1) begin
            next_out[63:56] = ID;
            next_out[55:32] = ParentA[55:32];
            next_out[31:0]  = Crossover;
            next_readA = 1'b1;
            next_readB = 1'b1;
          end else if (gr_n == 1'b1) begin
            next_out[63:56] = 8'hFF; //invalid
            next_out[55:0] = ParentB[55:0];
            next_readA = 1'b0;
            next_readB = 1'b1;
          end else if (lw_n == 1'b1) begin
            next_out[63:56] = ID;
            next_out[55:0] = ParentA[55:0];
            next_readA = 1'b1;
            next_readB = 1'b0;
          end else if (eq_n == 1'b1 && gr_c == 1'b1) begin
            next_out[63:56] = 8'hFF; //invalid
            next_out[55:0] = ParentB[55:0];
            next_readA = 1'b0;
            next_readB = 1'b1;
          end else if (eq_n == 1'b1 && lw_c == 1'b1) begin // Corrected from 'lw_n' to 'lw_c'
            next_out[63:56] = ID;
            next_out[55:0] = ParentA[55:0];
            next_readA = 1'b1;
            next_readB = 1'b0;
          end
        end else if (ParentA[55] == 1'b0 && ParentB[55] == 1'b0) begin // NODES
          if (eq_n == 1'b1) begin
            next_out[63:56] = ID;
            next_out[55:32] = ParentA[55:32];
            next_out[31:0]  = Crossover;
            next_readA = 1'b1;
            next_readB = 1'b1;
          end else if (gr_n == 1'b1) begin
            next_out[63:56] = 8'hFF; //invalid
            next_out[55:0] = ParentB[55:0];
            next_readA = 1'b0;
            next_readB = 1'b1;
          end else if (lw_n == 1'b1) begin
            next_out[63:56] = ID;
            next_out[55:0] = ParentA[55:0];
            next_readA = 1'b1;
            next_readB = 1'b0;
          end
        end else if (ParentA[55] == 1'b0 && ParentB[55] == 1'b1) begin
          next_out[63:56] = ID;
          next_out[55:0] = ParentA[55:0];
          next_readA = 1'b1;
          next_readB = 1'b0;
        end else if (ParentA[55] == 1'b1 && ParentB[55] == 1'b0) begin
          next_out[63:56] = 8'hFF; //invalid
          next_out[55:0] = ParentB[55:0];
          next_readA = 1'b0;
          next_readB = 1'b1;
        end
      end else begin // stage = 1 (second main processing stage)
        // In this stage, `out[63:56]` is always 8'hFF, and `out[55:0]` retains its previous value.
        next_out[63:56] = 8'hFF; // ID field is invalid
        next_out[55:0] = out[55:0]; // Retain previous value for data field (latch behavior)

        if (ParentA[55] == 1'b1 && ParentB[55] == 1'b1) begin  // Connections
          if (eq_n == 1'b1 && eq_c == 1'b1) begin
            next_readA = 1'b1;
            next_readB = 1'b1;
          end else if (gr_n == 1'b1) begin
            next_readA = 1'b0;
            next_readB = 1'b1;
          end else if (lw_n == 1'b1) begin
            next_readA = 1'b1;
            next_readB = 1'b0;
          end else if (eq_n == 1'b1 && gr_c == 1'b1) begin
            next_readA = 1'b0;
            next_readB = 1'b1;
          end else if (eq_n == 1'b1 && lw_c == 1'b1) begin // Corrected from 'lw_n' to 'lw_c'
            next_readA = 1'b1;
            next_readB = 1'b0;
          end
        end else if (ParentA[55] == 1'b0 && ParentB[55] == 1'b0) begin // NODES
          if (eq_n == 1'b1) begin
            next_readA = 1'b1;
            next_readB = 1'b1;
          end else if (gr_n == 1'b1) begin
            next_readA = 1'b0;
            next_readB = 1'b1;
          end else if (lw_n == 1'b1) begin
            next_readA = 1'b1;
            next_readB = 1'b0;
          end
        end else if (ParentA[55] == 1'b0 && ParentB[55] == 1'b1) begin
          next_readA = 1'b1;
          next_readB = 1'b0;
        end else if (ParentA[55] == 1'b1 && ParentB[55] == 1'b0) begin
          next_readA = 1'b0;
          next_readB = 1'b1;
        end
      end
    end
  end

  // Synchronous updates for all registers
  signalX <= next_signalX;
  stage <= next_stage;
  readA <= next_readA;
  readB <= next_readB;
  out <= next_out;
end

endmodule
