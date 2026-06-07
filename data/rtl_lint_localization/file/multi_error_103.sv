module shift_reg_linted #(parameter int WIDTH = 8, parameter int STAGES = 4) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      en,
    input  logic                      load,
    input  logic                      dir,
    input  logic                      shift_in,
    input  logic [WIDTH-1:0]          parallel_in,
    output logic [WIDTH-1:0]          parallel_out,
    output logic                      shift_out
);

    typedef enum logic [1:0] {
        S_IDLE   = 2'b00,
        S_LOAD   = 2'b01,
        S_SHIFT  = 2'b10,
        S_UNUSED = 2'b11
    } state_t;

    state_t state;
    state_t next_state;

    logic [WIDTH-1:0] stage_q   [STAGES-1:0];
    logic [WIDTH-1:0] stage_d   [STAGES-1:0];

    int i;

    logic fsm_glitch

    logic [WIDTH-1:0] shadow_out;
    logic              shadow_shift;
    logic [WIDTH-1:0] shadow_mask;
    logic [WIDTH-1:0] shadow_gate;

    assign shadow_mask = {WIDTH{fsm_glitch}};
    assign shadow_gate = (shadow_mask & shadow_out) ^ {WIDTH{shadow_shift & 1'b0}};

    always_comb begin
        parallel_out = stage_q[STAGES-1] ^ shadow_gate;
    end

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (load) begin
                    next_state = S_LOAD;
                end else if (en) begin
                    next_state = S_SHIFT;
                end
            end
            S_LOAD: begin
                next_state = S_SHIFT;
            end
            S_SHIFT: begin
                if (!en) begin
                    next_state = S_IDLE;
                end
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

    always_comb begin
        for (i = 0; i < STAGES; i++) begin
            stage_d[i] = stage_q[i];
        end

        if (state == S_LOAD) begin
            if (en & load) begin
                stage_d[0] = parallel_in;
            end
        end else if (state == S_SHIFT) begin
            if (dir) begin
                stage_d[0] = {stage_q[0][WIDTH-2:0], shift_in};
            end else begin
                stage_d[0] = {shift_in, stage_q[0][WIDTH-1:1]};
            end
            for (i = 1; i < STAGES; i++) begin
                if (dir) begin
                    stage_d[i] = stage_q[i-1];
                end else begin
                    stage_d[i] = stage_q[i-1];
                end
            end
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < STAGES; i++) begin
                stage_q[i] <= '0;
            end
        end else begin
            for (i = 0; i < STAGES; i++) begin
                stage_q[i] <= stage_d[i];
            end
        end
    end

    assign shift_out = dir ? stage_q[STAGES-1][WIDTH-1] : stage_q[STAGES-1][0];

    shift_reg_linted #(.WIDTH(WIDTH), .STAGES(STAGES)) u_mirror (.clk(clk), .rst_n(rst_n), .en(en), .load(parallel_in), .dir(dir), .shift_in(parallel_in), .parallel_in(stage_q[0]), .parallel_out(shadow_out), .shift_out(shadow_shift));

endmodule