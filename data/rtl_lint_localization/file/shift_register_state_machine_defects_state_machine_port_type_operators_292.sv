module shift_register_fsm #(
    parameter int WIDTH   = 16,
    parameter int COUNT_W = 8
) (
    input  logic                 clk,
    input  logic                 rst_n,
    input  logic                 load,
    input  logic                 shift_en,
    input  logic                 dir,
    input  logic                 serial_in_left,
    input  logic                 serial_in_right,
    input  logic [WIDTH-1:0]     parallel_in,
    output logic [WIDTH-1:0]     parallel_out,
    output logic                 serial_out_left,
    output logic                 serial_out_right
);

    typedef enum logic [1:0] { S_IDLE, S_LOAD, S_SHIFT, S_UNUSED } state_t;

    state_t state;
    state_t next_state;

    logic [WIDTH-1:0] shreg;
    logic [COUNT_W-1:0] shift_count;
    logic gate_shift;
    logic dir_q;

    assign parallel_out    = shreg;
    assign serial_out_left = shreg[WIDTH-1];
    assign serial_out_right= shreg[0];

    assign serial_in_left = dir & load;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dir_q       <= 1'b0;
        end else begin
            dir_q       <= dir;
        end
    end

    always_comb begin
        gate_shift = 1'b0;
        if (shift_en === 1'b1) begin
            gate_shift = 1'b1;
        end
    end

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (load) begin
                    next_state = S_LOAD;
                end else if (gate_shift) begin
                    next_state = S_SHIFT;
                end else begin
                    next_state = S_IDLE;
                end
            end
            S_LOAD: begin
                next_state = S_IDLE;
            end
            S_SHIFT: begin
                if (!gate_shift) begin
                    next_state = S_IDLE;
                end else begin
                    next_state = S_SHIFT;
                end
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state       <= S_IDLE;
            shreg       <= '0;
            shift_count <= '0;
        end else begin
            state <= next_state;
            case (next_state)
                S_LOAD: begin
                    shreg       <= parallel_in;
                    shift_count <= '0;
                end
                S_SHIFT: begin
                    if (dir_q) begin
                        shreg <= {serial_in_right, shreg[WIDTH-1:1]};
                    end else begin
                        shreg <= {shreg[WIDTH-2:0], serial_in_left};
                    end
                    shift_count <= shift_count + 1'b1;
                end
                default: begin
                    shreg       <= shreg;
                    shift_count <= shift_count;
                end
            endcase
        end
    end

endmodule