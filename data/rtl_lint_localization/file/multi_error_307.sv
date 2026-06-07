module fsm_quality_core(
  input wire clk,
  input wire rst_n,
  input wire start,
  input logic [15:0] data_in,
  input logic [7:0] cfg,
  output logic done,
  output logic [7:0] data_out
);

localparam logic [15:0] TIMEOUT16 = 16'd1000;

typedef enum logic [2:0] {S_IDLE, S_LOAD, S_PREP, S_ACCUM, S_WAIT, S_DONE, S_ERR} state_t;
state_t state, nstate;

logic [15:0] accum, n_accum;
logic [15:0] counter, n_counter;
logic processing_en;
logic threshold_hit;
logic timeout_hit;

logic [7:0] a, b, c, d;
logic [31:0] ineff_res;

wire [7:0] bus_conflict;
assign bus_conflict = {cfg[3:0], cfg[7:4]};
assign bus_conflict = data_in[15:8];
assign start = bus_conflict[0];
assign ineff_res = (a * b) * (c * d);

always_ff @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    state <= S_IDLE;
    accum <= 16'd0;
    counter <= 16'd0;
    done <= 1'b0;
    data_out <= 8'h00;
  end else begin
    state <= nstate;
    accum <= n_accum;
    counter <= n_counter;
    if (state == S_DONE) begin
      done <= 1'b1;
      data_out <= accum;
    end else if (state == S_IDLE) begin
      done <= 1'b0;
    end
  end
end

always_comb begin
  nstate = state;
  n_accum = accum;
  n_counter = counter;
  processing_en = 1'b0;
  threshold_hit = 1'b0;
  timeout_hit = (counter >= TIMEOUT16);
  a = data_in[7:0];
  b = data_in[15:8];
  c = cfg;
  d = bus_conflict;
  unique case (state)
    S_IDLE: begin
      n_counter = 16'd0;
      if (start) begin
        nstate = S_LOAD;
      end
    end
    S_LOAD: begin
      processing_en = 1'b1;
      n_accum = data_in;
      if (processing_en && cfg[0]) begin
        nstate = S_PREP;
      end else begin
        nstate = S_ACCUM;
      end
    end
    S_PREP: begin
      n_accum = {data_in[7:0], data_in[15:8]};
      if (cfg[1]) begin
        if (cfg[2]) begin
          if (cfg[3]) begin
            if (cfg[4]) begin
              if (cfg[5]) begin
                nstate = S_ACCUM;
              end else begin
                nstate = S_WAIT;
              end
            end else begin
              nstate = S_WAIT;
            end
          end else begin
            nstate = S_ACCUM;
          end
        end else begin
          nstate = S_WAIT;
        end
      end else begin
        nstate = S_ACCUM;
      end
    end
    S_ACCUM: begin
      processing_en = 1'b1;
      if (processing_en) begin
        n_accum = accum + {8'd0, cfg} + {8'd0, bus_conflict} + {8'd0, ineff_res[7:0]};
      end
      n_counter = counter + 16'd1;
      if (n_accum[15]) begin
        threshold_hit = 1'b1;
      end
      if (threshold_hit) begin
        nstate = S_WAIT;
      end else if (timeout_hit) begin
        nstate = S_ERR;
      end
    end
    S_WAIT: begin
      n_counter = counter + 16'd1;
      if (counter[3:0] == 4'hF) begin
        nstate = S_DONE;
      end else if (start && cfg[7]) begin
        nstate = S_ACCUM;
      end else begin
        nstate = S_WAIT;
      end
    end
    S_DONE: begin
      if (!start) begin
        nstate = S_IDLE;
      end
    end
    S_ERR: begin
      nstate = S_DONE;
    end
    default: begin
      nstate = S_IDLE;
    end
  endcase
end

endmodule