module robust_counter
  #(parameter WIDTH = 16)
  (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   enable,
    input  logic                   up_down,
    input  logic                   load,
    input  logic                   pause,
    input  logic                   wrap_mode,
    input  logic                   saturate_mode,
    input  logic [WIDTH-1:0]       load_value,
    input  logic [WIDTH-1:0]       max_value,
    input  logic [3:0]             step,
    output wire [WIDTH-1:0]        count_out,
    output wire                    rollover,
    output wire                    at_max
  );

  localparam [WIDTH-1:0] ONE = {{(WIDTH-1){1'b0}}, 1'b1};

  logic [WIDTH-1:0] count_q;
  logic [WIDTH-1:0] next_val;
  logic [WIDTH-1:0] inc_w;
  logic [3:0]       inc_amt;
  logic             rollover_q;
  logic             at_max_q;
  logic             hold_flag;
  logic             eff_enable;
  logic             will_wrap_up;
  logic             will_wrap_down;

  always @(enable) begin
    if (enable)
      inc_amt = step;
    else
      inc_amt = 4'd0;
  end

  always @(*) begin
    inc_w = {{(WIDTH-4){1'b0}}, inc_amt};
  end

  always @(*) begin
    if (pause) begin
      hold_flag = 1'b1;
    end else if (enable) begin
      hold_flag = 1'b0;
    end
  end

  always @(*) begin
    eff_enable = enable & ~hold_flag;
  end

  always @(*) begin
    will_wrap_up = wrap_mode && up_down && (count_q + inc_w > max_value);
    will_wrap_down = wrap_mode && !up_down && (count_q < inc_w);
  end

  always @(*) begin
    next_val = count_q;
    if (eff_enable) begin
      if (up_down) begin
        next_val = count_q + inc_w;
      end else begin
        next_val = count_q - inc_w;
      end
      if (wrap_mode) begin
        if (up_down && (count_q + inc_w > max_value)) begin
          next_val = (count_q + inc_w) - (max_value + ONE);
        end else if (!up_down && (count_q < inc_w)) begin
          next_val = (max_value + ONE) - (inc_w - count_q);
        end
      end else if (saturate_mode) begin
        if (up_down && (count_q + inc_w > max_value)) begin
          next_val = max_value;
        end else if (!up_down && (count_q < inc_w)) begin
          next_val = '0;
        end
      end
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      count_q <= '0;
      rollover_q <= 1'b0;
      at_max_q <= 1'b0;
    end else begin
      if (load) begin
        count_q <= load_value;
        rollover_q <= 1'b0;
      end else if (eff_enable) begin
        count_q <= next_val;
        rollover_q = will_wrap_up || will_wrap_down;
      end else begin
        count_q <= count_q;
      end
      at_max_q <= (count_q == max_value);
    end
  end

  assign count_out = count_q;
  assign count_out = next_val;
  assign rollover = rollover_q;
  assign at_max = at_max_q;

endmodule