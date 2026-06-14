module decoder_fsm #(parameter int WIDTH = 16, parameter int OUTW = 8) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     enable,
    input  logic [2:0]               sel,
    input  logic [WIDTH-1:0]         data_in,
    output logic [OUTW-1:0]          decode_out,
    output logic                     valid
);

    typedef enum logic [1:0] { S_IDLE, S_LOAD, S_DECODE } state_t;
    state_t state;
    state_t next_state;

    logic [OUTW-1:0] temp_code;
    logic [3:0] nib0;
    logic [3:0] nib1;
    logic [3:0] nib2;
    logic [3:0] nib3;
    logic [7:0] onehot_sel;

    logic unused_debug;

    localparam int LEVEL_DIV = 3

    function automatic [7:0] onehot(input logic [2:0] s);
        case (s)
            3'd0: onehot = 8'b00000001;
            3'd1: onehot = 8'b00000010;
            3'd2: onehot = 8'b00000100;
            3'd3: onehot = 8'b00001000;
            3'd4: onehot = 8'b00010000;
            3'd5: onehot = 8'b00100000;
            3'd6: onehot = 8'b01000000;
            3'd7: onehot = 8'b10000000;
            default: onehot = 8'b00000000;
        endcase
    endfunction

    function automatic [3:0] sel_nibble(input logic [2:0] s, input logic [15:0] di);
        case (s)
            3'd0: sel_nibble = di[3:0];
            3'd1: sel_nibble = di[7:4];
            3'd2: sel_nibble = di[11:8];
            3'd3: sel_nibble = di[15:12];
            3'd4: sel_nibble = di[3:0] ^ di[7:4];
            3'd5: sel_nibble = di[11:8] ^ di[15:12];
            3'd6: sel_nibble = di[7:4] & di[3:0];
            3'd7: sel_nibble = di[15:12] | di[11:8];
            default: sel_nibble = 4'h0;
        endcase
    endfunction

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
            valid <= 1'b0;
        end else begin
            state <= next_state;
            if (next_state == S_DECODE) begin
                valid <= 1'b1;
            end else begin
                valid <= 1'b0;
            end
        end
    end

    always_comb begin
        next_state = state;
        unique case (state)
            S_IDLE: begin
                if (enable) next_state = S_LOAD;
            end
            S_LOAD: begin
                next_state = S_DECODE;
            end
            S_DECODE: begin
                if (!enable) next_state = S_IDLE;
            end
        endcase
    end

    always_comb begin
        onehot_sel = onehot(sel);
        nib0 = data_in[3:0];
        nib1 = data_in[7:4];
        nib2 = data_in[11:8];
        nib3 = data_in[15:12];
    end

    always @(sel or enable) begin
        temp_code = 8'h00;
        unique case (sel)
            3'd0: temp_code = {4'h0, nib0};
            3'd1: temp_code = {4'h0, nib1};
            3'd2: temp_code = {4'h0, nib2};
            3'd3: temp_code = {4'h0, nib3};
            3'd4: temp_code = {nib0, nib1};
            3'd5: temp_code = {nib2, nib3};
            3'd6: temp_code = {nib1, nib0};
            3'd7: temp_code = {nib3, nib2};
            default: temp_code = 8'h00;
        endcase
    end

    always_comb begin
        case (state)
            S_IDLE:   decode_out = 8'h00;
            S_LOAD:   decode_out = temp_code ^ onehot_sel;
            S_DECODE: decode_out = temp_code;
            default:  decode_out = 8'h00;
        endcase
    end

endmodule