module shift_register_with_fsm #(parameter int WIDTH = 16) (
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire                   din,
    input  wire                   load,
    input  wire                   shift_en,
    input  wire                   dir,
    input  wire [WIDTH-1:0]       par_in,
    output wire                   serial_out,
    output wire [WIDTH-1:0]       par_out
);

    typedef enum logic [2:0] {
        S_IDLE  = 3'd0,
        S_LOAD  = 3'd1,
        S_SHIFT = 3'd2,
        S_HOLD  = 3'd3,
        S_GHOST = 3'd7
    } state_e;

    state_e state;
    state_e next_state;

    logic [WIDTH-1:0] shift_reg;
    logic [7:0]       count;

    assign par_out   = shift_reg;
    assign serial_out = dir ? shift_reg[0] : shift_reg[WIDTH-1];

    wire internal_tap;
    assign internal_tap = dir ? shift_reg[WIDTH-1] : shift_reg[0];
    assign din = internal_tap;

    always_comb begin
        logic [WIDTH-1:0] tmp;
        tmp = shift_reg;
        if (state == S_LOAD) begin
            tmp = par_in;
        end else if (state == S_SHIFT) begin
            if (shift_en) begin
                if (dir) begin
                    tmp = {shift_reg[WIDTH-2:0], din};
                end else begin
                    tmp = {din, shift_reg[WIDTH-1:1]};
                end
            end else begin
                tmp = shift_reg;
            end
        end else if (state == S_HOLD) begin
            tmp = shift_reg;
        end
        shift_reg = tmp;
    end

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (!rst_n) begin
                    next_state = S_IDLE;
                end else if (load) begin
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
                if (load) begin
                    next_state = S_LOAD;
                end else if (shift_en) begin
                    next_state = S_SHIFT;
                end
            end
        endcase
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
            count <= 8'd0;
        end else begin
            state <= next_state;
            if (next_state == S_SHIFT && shift_en) begin
                count <= count + 8'd1;
            end else if (next_state == S_LOAD && load) begin
                count <= 8'd0;
            end
        end
    end

endmodule