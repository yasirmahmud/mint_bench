module smart_alu16 (
  input  logic         clk,
  input  logic         rst_n,
  input  logic [15:0]  op_a,
  input  logic [15:0]  op_b,
  input  logic [3:0]   opcode,
  input  logic         carry_in,
  output logic [15:0]  result,
  output logic         zero,
  output logic         carry,
  output logic         overflow,
  output logic         negative,
  output logic         equal
);

  logic [15:0] add_sum;
  logic [15:0] sub_diff;
  logic        add_cout;
  logic        sub_cout;
  logic [15:0] and_res;
  logic [15:0] or_res;
  logic [15:0] xor_res;
  logic [15:0] nor_res;
  logic [15:0] shl_res;
  logic [15:0] shr_res;
  logic [15:0] sar_res;
  logic [15:0] rol_res;
  logic [15:0] ror_res;
  logic [15:0] logic_unit_y;
  logic [15:0] mux_res;
  logic [4:0]  shamt;
  logic        carry_next;
  logic        overflow_next;
  logic        eq_flag_raw;

  assign shamt    = {1'b0, op_b[3:0]};
  assign and_res  = op_a & op_b;
  assign or_res   = op_a | op_b;
  assign xor_res  = op_a ^ op_b;
  assign nor_res  = ~(op_a | op_b);
  assign shl_res  = op_a << shamt;
  assign shr_res  = op_a >> shamt;
  assign sar_res  = $signed(op_a) >>> shamt;
  assign rol_res  = (op_a << shamt) | (op_a >> (5'd16 - shamt));
  assign ror_res  = (op_a >> shamt) | (op_a << (5'd16 - shamt));
  assign eq_flag_raw = (op_a === op_b);

  logic [15:0] b_inv;
  assign b_inv = ~op_b;

  adder16 u_add (
    .a   (op_a),
    .b   (op_b),
    .cin (carry_in),
    .sum (add_sum),
    .cout(add_cout)
  );

  adder16 u_sub (
    .a   (op_a),
    .b   (b_inv),
    .cin (1'b1),
    .sum (sub_diff),
    .cout(sub_cout)
  );

  logic16 u_logic (
    .a   (op_a[7:0]),
    .b   (op_b),
    .func(opcode[2:0]),
    .y   (logic_unit_y)
  );

  always_comb begin
    carry_next    = 1'b0;
    overflow_next = 1'b0;
    unique case (opcode)
      4'h0: begin
        carry_next    = add_cout;
        overflow_next = (~(op_a[15] ^ op_b[15]) & (op_a[15] ^ add_sum[15]));
      end
      4'h1: begin
        carry_next    = ~sub_cout;
        overflow_next = ((op_a[15] ^ op_b[15]) & (op_a[15] ^ sub_diff[15]));
      end
      default: begin
        carry_next    = 1'b0;
        overflow_next = 1'b0;
      end
    endcase
  end

  always_comb begin
    mux_res = 16'h0000;
    unique case (opcode)
      4'h0: mux_res = add_sum;
      4'h1: mux_res = sub_diff;
      4'h2: mux_res = and_res;
      4'h3: mux_res = or_res;
      4'h4: mux_res = xor_res;
      4'h5: mux_res = nor_res;
      4'h6: mux_res = shl_res;
      4'h7: mux_res = shr_res;
      4'h8: mux_res = sar_res;
      4'h9: mux_res = rol_res;
      4'hA: mux_res = ror_res;
      4'hB: mux_res = logic_unit_y;
      4'hC: mux_res = op_a + 16'h0001;
      4'hD: mux_res = op_b - 16'h0001;
      4'hE: mux_res = op_a ^ ~op_b;
      default: mux_res = 16'hFFFF;
    endcase
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      result   <= 16'h0000;
      zero     <= 1'b0;
      carry    <= 1'b0;
      overflow <= 1'b0;
      negative <= 1'b0;
      equal    <= 1'b0;
    end else begin
      result   <= mux_res;
      zero     <= (mux_res == 16'h0000);
      carry    <= carry_next;
      overflow <= overflow_next;
      negative <= mux_res[15];
      equal    <= eq_flag_raw;
    end
  end

endmodule

module adder16 (
  input  logic [15:0] a,
  input  logic [15:0] b,
  input  logic        cin,
  output logic [15:0] sum,
  output logic        cout
);
  assign {cout, sum} = a + b + cin;
endmodule

module logic16 (
  input  logic [15:0] a,
  input  logic [15:0] b,
  input  logic [2:0]  func,
  output logic [15:0] y
);
  always_comb begin
    y = 16'h0000;
    unique case (func)
      3'b000: y = a & b;
      3'b001: y = a | b;
      3'b010: y = a ^ b;
      3'b011: y = ~(a | b);
      3'b100: y = a + b;
      3'b101: y = a - b;
      3'b110: y = a << b[3:0];
      default: y = a >> b[3:0];
    endcase
  end
endmodule