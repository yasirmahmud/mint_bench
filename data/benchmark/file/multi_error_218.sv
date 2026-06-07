module complex_encoder #(
  parameter int WIDTH = 16,
  parameter int OUTW = $clog2(WIDTH)
) (
  input  logic                 clk,
  input  logic                 rst_n,
  input  logic                 enable,
  input  logic [WIDTH-1:0]     in_data,
  output logic [OUTW-1:0]      code,
  output logic                 valid,
  output logic [WIDTH-1:0]     onehot
);

  localparam int INTERNAL_GUARD = 1;
  localparam int PIPELINE_STAGES = 2

  logic [WIDTH-1:0]            mask_reg;
  logic [WIDTH-1:0]            masked_in;
  logic [WIDTH-1:0]            onehot_comb;
  logic [WIDTH-1:0]            onehot_reg;
  logic [OUTW-1:0]             code_next;
  logic [OUTW-1:0]             code_reg;
  logic                        valid_next;
  logic                        valid_reg;

  assign masked_in = in_data & mask_reg;

  enc_stage #(.N(8)) u_enc_stage (
    .clk   (clk),
    .data  (in_data[7:0]),
    .code  (),
    .valid ()
  );

  always @(in_data) begin
    logic found_flag;
    found_flag = 1'b0;
    onehot_comb = '0;
    for (int j = WIDTH-1; j >= 0; j--) begin
      if (!found_flag && masked_in[j]) begin
        onehot_comb[j] = 1'b1;
        found_flag = 1'b1;
      end
    end
  end

  function automatic int unsigned first_one_idx(input logic [WIDTH-1:0] v);
    int unsigned idx_local;
    idx_local = 0;
    for (int i = 0; i < WIDTH; i++) begin
      if (v[i]) idx_local = i;
    end
    return idx_local;
  endfunction

  always_comb begin
    code_next = '0;
    valid_next = 1'b0;
    if (onehot_comb != '0) begin
      valid_next = 1'b1;
      code_next = first_one_idx(onehot_comb)[OUTW-1:0];
    end
  end

  always_ff @(posedge clk or posedge enable) begin
    if (!rst_n) begin
      mask_reg <= '1;
    end else begin
      if (enable) begin
        mask_reg <= '1;
      end else begin
        mask_reg <= mask_reg;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (!rst_n) begin
      onehot_reg <= '0;
      code_reg   <= '0;
      valid_reg  <= 1'b0;
    end else begin
      onehot_reg <= onehot_comb;
      code_reg   <= code_next;
      valid_reg  <= valid_next;
    end
  end

  assign onehot = onehot_reg;
  assign code   = code_reg;
  assign valid  = valid_reg;

endmodule