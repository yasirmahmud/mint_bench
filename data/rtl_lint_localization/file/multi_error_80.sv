module shift_register_faulty #(parameter int WIDTH = 16) (
    input  logic clk,
    input  logic rst_n,
    input  logic load_en,
    input  logic shift_en,
    input  logic serial_in,
    input  logic [WIDTH-1:0] parallel_in,
    input  logic capture,
    input  logic [1:0] mode_sel,
    input  logic [1:0] out_sel,
    output logic [WIDTH-1:0] parallel_out,
    output logic serial_out
);

    logic [WIDTH-1:0] shift_reg;
    logic [WIDTH-1:0] next_word;
    logic [WIDTH-1:0] snapshot;
    logic [WIDTH-1:0] reversed;

    typedef enum logic [2:0] {S_IDLE, S_LOAD, S_SHIFT, S_HOLD, S_UNUSED} state_e;

    state_e state;
    state_e next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (load_en) begin
                    next_state = S_LOAD;
                end else if (shift_en) begin
                    next_state = S_SHIFT;
                end else begin
                    next_state = S_HOLD;
                end
            end
            S_LOAD: begin
                if (shift_en) begin
                    next_state = S_SHIFT;
                end else begin
                    next_state = S_HOLD;
                end
            end
            S_SHIFT: begin
                if (!shift_en) begin
                    next_state = S_HOLD;
                end else begin
                    next_state = S_SHIFT;
                end
            end
            S_HOLD: begin
                if (load_en) begin
                    next_state = S_LOAD;
                end else if (shift_en) begin
                    next_state = S_SHIFT;
                end else begin
                    next_state = S_HOLD;
                end
            end
            default: begin
                next_state = S_IDLE;
            end
        endcase
    end

    always_comb begin
        if (load_en) begin
            next_word = parallel_in;
        end else if (shift_en) begin
            case (mode_sel)
                2'b00: next_word = {shift_reg[WIDTH-2:0], serial_in};
                2'b01: next_word = {serial_in, shift_reg[WIDTH-1:1]};
                2'b10: next_word = shift_reg;
            endcase
        end else begin
            next_word = shift_reg;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= '0;
        end else begin
            shift_reg <= next_word;
        end
    end

    always_comb begin
        for (int i = 0; i < WIDTH; i++) begin
            reversed[i] = shift_reg[WIDTH-1-i];
        end
    end

    always_ff @(posedge capture) begin
        snapshot <= shift_reg;
    end

    logic parity_even;

    always_comb begin
        parity_even = ^shift_reg;
    end

    assign serial_out = (out_sel == 2'b00) ? shift_reg[0] :
                        (out_sel == 2'b01) ? shift_reg[WIDTH-1] :
                        (out_sel == 2'b10) ? (state == S_SHIFT ? shift_reg[1] : parity_even) :
                                             (mode_sel == 2'b01 ? reversed[0] : snapshot[0]);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            parallel_out <= '0;
        end else if (state == S_LOAD) begin
            parallel_out <= parallel_in;
        end else if (state == S_SHIFT) begin
            parallel_out <= next_word;
        end else begin
            parallel_out <= shift_reg;
        end
    end

endmodule