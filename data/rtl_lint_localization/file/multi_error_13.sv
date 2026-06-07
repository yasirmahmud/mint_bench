module bit_counter(
  input logic [7:0] data_i,
  output logic [3:0] popcnt_o
);
  always_comb begin
    popcnt_o = 4'd0;
    for (int i = 0; i < 8; i++) begin
      popcnt_o = popcnt_o + data_i[i];
    end
  end
endmodule

module decoder(
  input logic clk,
  input logic rst_n,
  input logic start_i,
  input logic [7:0] instr_i,
  output logic valid_o,
  output logic [15:0] decode_o,
  output logic [3:0] bitcount_o
);

typedef enum logic [1:0] {S_IDLE, S_DECODE, S_OUTPUT, S_UNUSED} state_e;
state_e current_state, next_state;

logic [7:0] instr_q;
logic [3:0] opcode_q;
logic [3:0] func_q;
logic [15:0] one_hot;
logic [7:0] trunc_bus;
logic [7:0] upper8;

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    instr_q <= 8'h00;
  end else if (current_state == S_IDLE && start_i) begin
    instr_q <= instr_i;
  end
end

assign opcode_q = instr_q[7:4];
assign func_q = instr_q[3:0];
assign one_hot = 16'h0001 << opcode_q;
assign trunc_bus = one_hot;
assign upper8 = {bitcount_o, func_q};

always_comb begin
  next_state = current_state;
  unique case (current_state)
    S_IDLE: begin
      if (start_i) next_state = S_DECODE;
    end
    S_DECODE: begin
      next_state = S_OUTPUT;
    end
    S_OUTPUT: begin
      next_state = S_IDLE;
    end
    default: begin
      next_state = S_IDLE;
    end
  endcase
end

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    current_state <= S_IDLE;
  end else begin
    current_state <= next_state;
  end
end

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    valid_o <= 1'b0;
  end else begin
    valid_o <= (current_state == S_OUTPUT);
  end
end

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    decode_o <= 16'h0000;
  end else if (current_state == S_OUTPUT) begin
    decode_o <= {upper8, trunc_bus};
  end
end

bit_counter u_bit_counter (
  .data_i(func_q),
  .popcnt_o(bitcount_o)
);

endmodule