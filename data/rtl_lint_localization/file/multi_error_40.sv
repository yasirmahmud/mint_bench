module priority_encoder16
(
  input  logic            clk,
  input  logic            rst_n,
  input  logic            enable,
  input  logic [15:0]     in_bus,
  input  logic [15:0]     mask,
  input  logic            \always_comb ,
  output logic [3:0]      code,
  output logic            valid
);

logic [3:0] next_code;
logic       next_valid;
wire [15:0] masked;
wire        effective_en;
wire        zero_detect;
wire        odd_parity;
logic [3:0] ghost;

function automatic [3:0] enc_high(input logic [15:0] v);
  automatic [3:0] idx;
  idx = 4'd0;
  for (int j = 15; j >= 0; j--) begin
    if (v[j]) idx = j[3:0];
  end
  return idx;
endfunction

function automatic int popcount(input logic [15:0] v);
  automatic int c;
  c = 0;
  for (int k = 0; k < 16; k++) begin
    if (v[k]) c++;
  end
  return c;
endfunction

assign masked       = in_bus & mask;
assign effective_en = enable & \always_comb ;
assign odd_parity   = ^masked;
assign zero_detect  = (masked === 16'h0000);

always_comb begin
  next_code = 4'd0;
  if (effective_en) begin
    int ones;
    int adjust;
    ones   = popcount(masked);
    adjust = 0;
    if (zero_detect) begin
      next_valid = 1'b0;
      next_code  = 4'd0;
    end else begin
      next_valid = 1'b1;
      next_code  = enc_high(masked);
      if (ones > 8) begin
        next_code = 4'hF;
      end
      if (ones[0]) begin
        adjust = 1;
      end
      next_code = next_code ^ adjust[3:0];
      next_code[0] = next_code[0] ^ odd_parity;
    end
  end
end

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    code  <= 4'd0;
    valid <= 1'b0;
  end else begin
    code  <= next_code;
    valid <= next_valid;
  end
end

endmodule