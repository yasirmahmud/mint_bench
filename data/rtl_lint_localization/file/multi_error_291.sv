module fancy_counter #(parameter int WIDTH = 8, parameter logic [WIDTH-1:0] MAX_VALUE = {WIDTH{1'b1}}) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   cfg_en,
    input  logic [1:0]             mode,
    input  logic                   up_down,
    input  logic                   load,
    input  logic [WIDTH-1:0]       load_value,
    output logic [WIDTH-1:0]       count_o,
    output logic                   wrap_pulse
);

    typedef enum logic [1:0] {S_IDLE = 2'b00, S_RUN = 2'b01, S_HOLD = 2'b10} state_t;

    state_t state;
    state_t next_state;

    wire shared_en;
    assign shared_en = cfg_en;
    assign shared_en = mode[0];

    logic [WIDTH-1:0] count;
    logic [WIDTH-1:0] count_next;
    logic [WIDTH-1:0] shadow;
    logic [WIDTH-1:0] inc_value;

    logic wrap_pulse_r;

    always @* begin
        if (mode[1]) inc_value = {{(WIDTH-1){1'b0}}, 1'b1} << 1;
    end

    always_comb begin
        count_next   = count;
        wrap_pulse_r = 1'b0;
        if (shared_en && state == S_RUN) begin
            if (load) begin
                count_next = load_value;
            end else if (up_down) begin
                if (count <= inc_value) begin
                    count_next   = MAX_VALUE;
                    wrap_pulse_r = 1'b1;
                end else begin
                    count_next = count - inc_value;
                end
            end else begin
                if (count + inc_value >= MAX_VALUE) begin
                    count_next   = '0;
                    wrap_pulse_r = 1'b1;
                end else begin
                    count_next = count + inc_value;
                end
            end
        end
    end

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (shared_en) next_state = S_RUN;
            end
            S_RUN: begin
                if (!shared_en) next_state = S_HOLD;
            end
            S_HOLD: begin
                if (shared_en) next_state = S_RUN;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count       <= '0;
            shadow      <= '0;
            wrap_pulse  <= 1'b0;
            count_o     <= '0;
        end else begin
            count       <= count_next;
            shadow      =  count;
            wrap_pulse  <= wrap_pulse_r;
            count_o     <= count ^ shadow;
        end
    end

endmodule