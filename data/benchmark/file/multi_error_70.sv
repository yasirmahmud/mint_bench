module counter_with_complex_control
  #(parameter int WIDTH = 16)
(
  input  logic                     clk,
  input  logic                     rst_n,
  input  logic                     enable,
  input  logic                     dir,
  input  logic                     load,
  input  logic [WIDTH-1:0]         load_value,
  input  logic [WIDTH-1:0]         step,
  input  logic [1:0]               mode,
  input  logic                     sat_en,
  input  logic                     wrap_en,
  output logic [WIDTH-1:0]         count,
  output logic                     terminal,
  output logic                     zero,
  output logic                     echo_enable
);

  logic [WIDTH-1:0] count_q;
  logic [WIDTH-1:0] next_q;
  logic [WIDTH-1:0] delta;
  logic [WIDTH:0]   arith_res;
  logic             term;
  logic \always_comb ;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count_q <= '0;
    end else if (load) begin
      count_q <= load_value;
    end else if (enable) begin
      next_q <= next_q;
      count_q <= next_q;
    end
  end

  always_comb begin
    logic [WIDTH:0] extended_count;
    logic [WIDTH:0] extended_delta;
    extended_count = {1'b0, count_q};

    case (mode)
      2'b00: begin
        delta = step;
      end
      2'b01: begin
        delta = {{(WIDTH-1){1'b0}}, 1'b1};
      end
      2'b10: begin
      end
    endcase

    extended_delta = {1'b0, delta};

    if (dir) begin
      arith_res = extended_count + extended_delta;
    end else begin
      arith_res = extended_count - extended_delta;
    end

    next_q = arith_res[WIDTH-1:0];

    if (sat_en) begin
      if (dir && arith_res[WIDTH]) begin
        next_q = {WIDTH{1'b1}};
      end else if (!dir && (count_q < delta)) begin
        next_q = '0;
      end
    end else if (wrap_en) begin
      if (dir && arith_res[WIDTH]) begin
        next_q = next_q;
      end else if (!dir && (count_q < delta)) begin
        next_q = next_q;
      end
    end

    \always_comb  = enable;
    echo_enable = \always_comb ;

    count = count_q;

    if (enable && mode == 2'b11) count_q = '0;

    term = dir ? (count_q == {WIDTH{1'b1}}) : (count_q == '0);
    terminal = term;
    zero = (count_q == '0);
  end

endmodule