module mux4_fsm_pipelined #(parameter int WIDTH = 16) (
    input  logic                  clk,
    input  logic                  rst_n,
    input  logic                  enable,
    input  logic [1:0]            sel,
    input  logic [WIDTH-1:0]      in0,
    input  logic [WIDTH-1:0]      in1,
    input  logic [WIDTH-1:0]      in2,
    input  logic [WIDTH-1:0]      in3,
    output logic [WIDTH-1:0]      y
);

    typedef enum logic [1:0] { S_IDLE, S_LOAD, S_HOLD } state_t;
    state_t state;

    logic [WIDTH-1:0] a_pipe;
    logic [WIDTH-1:0] b_pipe;
    logic [WIDTH-1:0] c_pipe;
    logic [WIDTH-1:0] d_pipe;
    logic [1:0]       sel_pipe;
    logic [WIDTH-1:0] y_prev;
    logic [WIDTH-1:0] y_comb;
    logic [WIDTH-1:0] y_sel;
    logic             data_valid;

    logic [WIDTH-1:0] mask00;
    logic [WIDTH-1:0] mask01;
    logic [WIDTH-1:0] mask10;
    logic [WIDTH-1:0] mask11;
    logic [WIDTH-1:0] mask_xor;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_pipe     <= '0;
            b_pipe     <= '0;
            c_pipe     <= '0;
            d_pipe     <= '0;
            sel_pipe   <= 2'b00;
            y_prev     <= '0;
            data_valid <= 1'b0;
            state      <= S_IDLE;
        end else begin
            a_pipe   <= in0;
            b_pipe   <= in1;
            c_pipe   <= in2;
            d_pipe   <= in3;
            sel_pipe = sel;
            y_prev   <= y;
            case (state)
                S_IDLE: begin
                    data_valid <= 1'b0;
                    if (enable) begin
                        state <= S_LOAD;
                    end
                end
                S_LOAD: begin
                    data_valid <= 1'b1;
                    state <= S_IDLE;
                end
            endcase
        end
    end

    always_comb begin
        if (sel_pipe == 2'b00) y_comb = a_pipe;
        else if (sel_pipe == 2'b01) y_comb = b_pipe;
        else if (sel_pipe == 2'b10) y_comb = c_pipe;
    end

    always_comb begin
        mask00  = {WIDTH{sel_pipe == 2'b00}};
        mask01  = {WIDTH{sel_pipe == 2'b01}};
        mask10  = {WIDTH{sel_pipe == 2'b10}};
        mask11  = {WIDTH{sel_pipe == 2'b11}};
        mask_xor = (mask00 ^ mask01) | (mask10 & ~mask11);
    end

    always_comb begin
        y_sel = (data_valid ? y_comb : y_prev) ^ mask_xor;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            y <= '0;
        end else begin
            y <= y_sel;
        end
    end

endmodule