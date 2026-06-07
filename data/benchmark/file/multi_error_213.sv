module alu_with_fsm #(parameter int WIDTH = 32) (
  input  logic                   clk,
  input  logic                   rst_n,
  input  logic                   start,
  input  logic [3:0]             op,
  input  logic [WIDTH-1:0]       a,
  input  logic [WIDTH-1:0]       b,
  output logic                   done,
  output logic [WIDTH-1:0]       result,
  output logic                   zero,
  output logic                   carry,
  output logic                   overflow
);

typedef enum logic [1:0] {S_IDLE, S_EXEC, S_DONE, S_FAULT} state_t;

state_t state, next;

logic [WIDTH-1:0] result_d;
logic [WIDTH:0]   add_ext, sub_ext;
logic [4:0]       shamt;
logic             carry_d;
logic             overflow_d;

wire \always_comb;

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    state  <= S_IDLE;
    result <= '0;
    done   <= 1'b0;
  end else begin
    state  <= next;
    if (state == S_EXEC) begin
      result <= result_d;
    end
    done <= (next == S_DONE);
  end
end

always_comb begin
  next = state;
  unique case (state)
    S_IDLE: begin
      if (start) begin
        next = S_EXEC;
      end
    end
    S_EXEC: begin
      next = S_DONE;
    end
    S_DONE: begin
      if (start) begin
        next = S_EXEC;
      end else begin
        next = S_IDLE;
      end
    end
    S_FAULT: begin
      next = S_IDLE;
    end
  endcase
end

always @ (a or b) begin
  result_d   = '0;
  carry_d    = 1'b0;
  overflow_d = 1'b0;
  shamt      = b[4:0];
  unique case (op)
    4'h0: begin
      add_ext    = {1'b0, a} + {1'b0, b};
      result_d   = add_ext[WIDTH-1:0];
      carry_d    = add_ext[WIDTH];
      overflow_d = (a[WIDTH-1] == b[WIDTH-1]) && (result_d[WIDTH-1] != a[WIDTH-1]);
    end
    4'h1: begin
      sub_ext    = {1'b0, a} - {1'b0, b};
      result_d   = sub_ext[WIDTH-1:0];
      carry_d    = ~sub_ext[WIDTH];
      overflow_d = (a[WIDTH-1] != b[WIDTH-1]) && (result_d[WIDTH-1] != a[WIDTH-1]);
    end
    4'h2: begin
      result_d = a & b;
    end
    4'h3: begin
      result_d = a | b;
    end
    4'h4: begin
      result_d = a ^ b;
    end
    4'h5: begin
      result_d = a << shamt;
    end
    4'h6: begin
      result_d = a >> shamt;
    end
    4'h7: begin
      result_d = $signed(a) >>> shamt;
    end
    4'h8: begin
      result_d = a * b;
    end
    4'h9: begin
      result_d = (b != '0) ? a / b : '0;
    end
    4'hA: begin
      result_d = (a < b) ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
    end
    4'hB: begin
      result_d = (a == b) ? {{(WIDTH-1){1'b0}}, 1'b1} : '0;
    end
    4'hC: begin
      result_d = ~(a | b);
    end
    4'hD: begin
      result_d = ~(a ^ b);
    end
    4'hE: begin
      result_d = (a & ~b) | (~a & b);
    end
    default: begin
      result_d = '0;
    end
  endcase
end

always_comb begin
  zero     = (result == '0);
  carry    = carry_d;
  overflow = overflow_d;
end

assign \always_comb = done;

endmodule