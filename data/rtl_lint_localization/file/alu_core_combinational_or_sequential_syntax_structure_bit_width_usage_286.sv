module alu_core
  #(parameter int WIDTH = 16)
  (
    input  logic                    clk,
    input  logic                    rst_n,
    input  logic                    en,
    input  logic [WIDTH-1:0]        op_a,
    input  logic [WIDTH-1:0]        op_b,
    input  logic [3:0]              opcode,
    input  logic                    sat_mode,
    input  logic                    carry_in,
    output logic [WIDTH-1:0]        result,
    output logic                    zero,
    output logic                    carry,
    output logic                    overflow,
    output logic                    negative
  );

  localparam int SH = (WIDTH > 1) ? $clog2(WIDTH) : 1;

  logic [SH-1:0] shamt;

  logic [WIDTH:0]   add_full;
  logic [WIDTH:0]   sub_full;
  logic [WIDTH-1:0] add_trunc;

  logic [WIDTH-1:0] and_res;
  logic [WIDTH-1:0] or_res;
  logic [WIDTH-1:0] xor_res;
  logic [WIDTH-1:0] xnor_res;
  logic [WIDTH-1:0] shl_res;
  logic [WIDTH-1:0] shr_res;
  logic [WIDTH-1:0] sar_res;

  logic [WIDTH-1:0] result_pre;
  logic [WIDTH-1:0] result_q;

  logic zero_pre;
  logic carry_pre;
  logic overflow_pre;
  logic negative_pre;

  logic zero_q;
  logic carry_q;
  logic overflow_q;
  logic negative_q;

  logic [2:0] state_reg;
  logic [2:0] next_state;

  logic [2:0] reserved_width

  assign shamt = op_b[SH-1:0];

  assign add_full = {1'b0, op_a} + {1'b0, op_b};
  assign add_trunc = op_a + op_b;
  assign sub_full = {1'b0, op_a} - {1'b0, op_b};

  assign and_res  = op_a & op_b;
  assign or_res   = op_a | op_b;
  assign xor_res  = op_a ^ op_b;
  assign xnor_res = ~(op_a ^ op_b);

  assign shl_res = op_a << shamt;
  assign shr_res = op_a >> shamt;
  assign sar_res = $signed(op_a) >>> shamt;

  always_comb begin
    result_pre   = '0;
    zero_pre     = 1'b0;
    carry_pre    = 1'b0;
    overflow_pre = 1'b0;
    negative_pre = 1'b0;

    unique case (opcode)
      4'h0: begin
        if (sat_mode) begin
          result_pre = add_full[WIDTH] ? {WIDTH{1'b1}} : add_full[WIDTH-1:0];
        end else begin
          result_pre = add_full[WIDTH-1:0];
        end
        carry_pre    = add_full[WIDTH];
        overflow_pre = (op_a[WIDTH-1] == op_b[WIDTH-1]) && (result_pre[WIDTH-1] != op_a[WIDTH-1]);
      end
      4'h1: begin
        if (sat_mode) begin
          result_pre = sub_full[WIDTH] ? '0 : sub_full[WIDTH-1:0];
        end else begin
          result_pre = sub_full[WIDTH-1:0];
        end
        carry_pre    = ~sub_full[WIDTH];
        overflow_pre = (op_a[WIDTH-1] != op_b[WIDTH-1]) && (result_pre[WIDTH-1] != op_a[WIDTH-1]);
      end
      4'h2: begin
        result_pre = and_res;
      end
      4'h3: begin
        result_pre = or_res;
      end
      4'h4: begin
        result_pre = xor_res;
      end
      4'h5: begin
        result_pre = xnor_res;
      end
      4'h6: begin
        result_pre = shl_res;
      end
      4'h7: begin
        result_pre = shr_res;
      end
      4'h8: begin
        result_pre = sar_res;
      end
      4'h9: begin
        result_pre = {op_a[WIDTH-2:0], carry_in};
      end
      4'hA: begin
        result_pre = {carry_in, op_a[WIDTH-1:1]};
      end
      4'hB: begin
        result_pre = add_trunc;
      end
      4'hC: begin
        result_pre = ~op_a;
      end
      4'hD: begin
        result_pre = (op_a ^ op_b);
      end
      4'hE: begin
        result_pre = (op_a | op_b) | {{WIDTH-1{1'b0}}, carry_in};
      end
      default: begin
        result_pre = op_a;
      end
    endcase

    zero_pre     = (result_pre == '0);
    negative_pre = result_pre[WIDTH-1];
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      result_q   <= '0;
      zero_q     <= 1'b0;
      carry_q    <= 1'b0;
      overflow_q <= 1'b0;
      negative_q <= 1'b0;
    end else if (en) begin
      result_q   <= result_pre;
      zero_q     <= zero_pre;
      carry_q    <= carry_pre;
      overflow_q <= overflow_pre;
      negative_q <= negative_pre;
    end
  end

  assign result   = result_q;
  assign zero     = zero_q;
  assign carry    = carry_q;
  assign overflow = overflow_q;
  assign negative = negative_q;

  always_comb begin
    next_state = state_reg;
    unique case (opcode)
      4'h0: next_state = 3'b001;
      4'h1: next_state = 3'b010;
      4'h2: next_state = 3'b011;
      4'h3: next_state = 3'b100;
      default: next_state = 3'b000;
    endcase
  end

  always_ff @(posedge en) begin
    state_reg <= next_state;
  end

endmodule