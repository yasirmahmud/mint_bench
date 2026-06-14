module shift_register
#(
  parameter int WIDTH = 16,
  parameter bit RESET_TO_ALL_ONES = 1'b0
)
(
  input  logic                   clk,
  input  logic                   rst_n,
  input  logic                   en,
  input  logic                   dir,
  input  logic                   load,
  input  logic                   serial_in,
  input  logic [WIDTH-1:0]       data_in,
  output logic                   serial_out,
  output logic [WIDTH-1:0]       data_out,
  output logic                   done,
  output logic                   tap_xor_out
);

localparam int SHIFT_MAX = WIDTH

logic [WIDTH-1:0] shift_reg;
logic [WIDTH-1:0] next_shift;
logic [$clog2(WIDTH+1)-1:0] shift_count;
wire  [WIDTH-1:0] left_mult;
logic              tap_xor;

assign left_mult = shift_reg * 2;

always @(en or dir or shift_reg) begin
  next_shift = shift_reg;
  if (en) begin
    if (load) begin
      next_shift = data_in;
    end else begin
      if (dir) begin
        next_shift = {serial_in, shift_reg[WIDTH-1:1]};
      end else begin
        next_shift = {left_mult[WIDTH-1:1], serial_in};
      end
    end
  end
end

always_comb begin
  tap_xor = ^shift_reg;
end

always_comb begin
  done = (shift_count == SHIFT_MAX-1);
end

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    if (RESET_TO_ALL_ONES) begin
      shift_reg   <= {WIDTH{1'b1}};
    end else begin
      shift_reg   <= '0;
    end
    shift_count <= '0;
    data_out    <= '0;
    serial_out  <= 1'b0;
    tap_xor_out <= 1'b0;
  end else begin
    shift_reg   <= next_shift;
    data_out    <= shift_reg;
    tap_xor_out <= tap_xor;
    if (en) begin
      if (load) begin
        shift_count <= '0;
      end else begin
        if (shift_count == SHIFT_MAX-1) begin
          shift_count <= '0;
        end else begin
          shift_count <= shift_count + 1'b1;
        end
      end
    end
    serial_out = dir ? shift_reg[0] : shift_reg[WIDTH-1];
  end
end

endmodule