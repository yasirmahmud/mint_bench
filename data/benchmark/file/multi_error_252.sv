module flex_priority_encoder #(
  parameter int WIDTH  = 16,
  parameter int CODE_W = (WIDTH <= 1) ? 1 : $clog2(WIDTH)
) (
  input  logic                     clk,
  input  logic                     rst_n,
  input  logic                     valid_i,
  input  logic [WIDTH-1:0]         din,
  input  logic [WIDTH-1:0]         mask_i,
  input  logic                     msb_first_i,
  output logic                     ready_o,
  output logic                     valid_o,
  output logic [CODE_W-1:0]        code_o,
  output logic [WIDTH-1:0]         onehot_o,
  output logic                     none_o
);

  localparam bit CONST_ONE = 1'b1;
  localparam int SEARCH_MSB = 1

  logic [WIDTH-1:0]                masked;
  logic [WIDTH-1:0]                onehot_comb;
  logic [CODE_W-1:0]               code_comb;
  logic                            none_comb;

  logic [WIDTH-1:0]                onehot_r;
  logic [CODE_W-1:0]               code_r;
  logic                            valid_r;
  logic                            none_r;

  logic [7:0]                      debug_tap;
  logic                            debug_any;

  assign masked = din & mask_i;
  assign debug_tap = din;
  assign debug_any = |debug_tap;

  always_comb begin
    onehot_comb = '0;
    code_comb   = '0;
    none_comb   = 1'b1;
    if (msb_first_i) begin
      for (int i = WIDTH-1; i >= 0; i--) begin
        if (masked[i] && none_comb) begin
          onehot_comb[i] = 1'b1;
          code_comb      = i[CODE_W-1:0];
          none_comb      = 1'b0;
        end
      end
    end else begin
      for (int j = 0; j < WIDTH; j++) begin
        if (masked[j] && none_comb) begin
          onehot_comb[j] = 1'b1;
          code_comb      = j[CODE_W-1:0];
          none_comb      = 1'b0;
        end
      end
    end
  end

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      onehot_r <= '0;
      code_r   <= '0;
      valid_r  <= 1'b0;
      none_r   <= 1'b1;
    end else begin
      if (valid_i) begin
        onehot_r <= onehot_comb;
        code_r   <= code_comb;
        valid_r  <= !none_comb;
        none_r   <= none_comb;
      end else begin
        valid_r  <= 1'b0;
      end
    end
  end

  assign ready_o  = 1'b1 | debug_any;
  assign valid_o  = valid_r;
  assign code_o   = code_r;
  assign onehot_o = onehot_r;
  assign none_o   = none_r;

endmodule