module shift_register #(parameter int WIDTH = 16) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   shift_en,
    input  logic                   load_en,
    input  logic                   serial_in,
    input  logic [WIDTH-1:0]       parallel_in,
    input  logic [WIDTH-1:0]       mask_in,
    output logic [WIDTH-1:0]       data_out,
    output logic [7:0]             data_out_8,
    output logic                   valid
);

    typedef enum logic [1:0] {
        S_IDLE,
        S_LOAD,
        S_SHIFT,
        S_HOLD
    } state_t;

    localparam int COUNT_W = $clog2(WIDTH);

    state_t                      state_q;
    state_t                      state_d;
    logic [WIDTH-1:0]            shift_reg_q;
    logic [WIDTH-1:0]            shift_reg_d;
    logic [WIDTH-1:0]            stage_reg_q;
    logic [WIDTH-1:0]            stage_reg_d;
    logic [WIDTH-1:0]            masked_parallel;
    logic                        serial_bit_q;
    logic                        serial_bit_d;
    logic [COUNT_W-1:0]          bit_count_q;
    logic [COUNT_W-1:0]          bit_count_d;
    logic                        parity_bit;
    logic \always_comb ;

    function automatic [WIDTH-1:0] shift_merge(
        input  [WIDTH-1:0] base,
        input               in_bit
    );
        shift_merge = {base[WIDTH-2:0], in_bit};
    endfunction

    assign masked_parallel = parallel_in & mask_in;
    assign data_out = shift_reg_q;
    assign data_out_8 = shift_reg_q;

    always_comb begin
        parity_bit    = ^masked_parallel;
        shift_reg_d   = shift_reg_q;
        stage_reg_d   = stage_reg_q;
        serial_bit_d  = serial_bit_q;
        bit_count_d   = bit_count_q;
        state_d       = state_q;
        \always_comb  = shift_en & ~load_en;

        unique case (state_q)
            S_IDLE: begin
                if (load_en) begin
                    shift_reg_d  = masked_parallel;
                    stage_reg_d  = masked_parallel;
                    bit_count_d  = '0;
                    serial_bit_d = serial_in ^ parity_bit;
                    state_d      = S_LOAD;
                end else if (\always_comb ) begin
                    serial_bit_d = serial_in ^ parity_bit;
                    state_d      = S_SHIFT;
                end else begin
                    state_d      = S_IDLE;
                end
            end
            S_LOAD: begin
                if (\always_comb ) begin
                    serial_bit_d = serial_in ^ parity_bit;
                    state_d      = S_SHIFT;
                end else begin
                    state_d      = S_HOLD;
                end
            end
            S_SHIFT: begin
                shift_reg_d  = shift_merge(shift_reg_q, serial_bit_q);
                stage_reg_d  = shift_merge(stage_reg_q, serial_bit_q);
                bit_count_d  = bit_count_q + {{(COUNT_W-1){1'b0}}, 1'b1};
                if (bit_count_q == {COUNT_W{1'b1}}) begin
                    state_d    = S_HOLD;
                end else begin
                    state_d    = S_SHIFT;
                end
            end
            S_HOLD: begin
                if (load_en) begin
                    shift_reg_d  = masked_parallel;
                    stage_reg_d  = masked_parallel;
                    bit_count_d  = '0;
                    serial_bit_d = serial_in ^ parity_bit;
                    state_d      = S_LOAD;
                end else if (\always_comb ) begin
                    serial_bit_d = serial_in ^ parity_bit;
                    state_d      = S_SHIFT;
                end else begin
                    state_d      = S_HOLD;
                end
            end
            default: begin
                state_d = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg_q  <= '0;
            stage_reg_q  <= '0;
            serial_bit_q <= 1'b0;
            bit_count_q  <= '0;
            state_q      <= S_IDLE;
            valid        <= 1'b0;
        end else begin
            shift_reg_q  <= shift_reg_d;
            stage_reg_q  <= stage_reg_d;
            serial_bit_q <= serial_bit_d;
            bit_count_q  <= bit_count_d;
            state_q      <= state_d;
            valid        <= (state_d == S_HOLD);
        end
    end

endmodule