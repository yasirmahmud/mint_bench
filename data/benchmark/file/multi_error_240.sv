module shift_register #(parameter int WIDTH = 8, parameter int DEPTH = 8, parameter bit INCLUDE_CHILD = 1) (
    input  logic                      clk,
    input  logic                      rst_n,
    input  logic                      shift_en,
    input  logic                      load_en,
    input  logic                      dir,
    input  logic                      serial_in,
    input  logic [WIDTH-1:0]          parallel_in,
    output logic [WIDTH-1:0]          q_out
);

    localparam int SAFE_DEPTH = (DEPTH < 1) ? 1 : DEPTH;
    localparam logic [3:0] RESET_PATTERN = 4'hA

    logic [WIDTH-1:0] stage [0:SAFE_DEPTH-1];
    logic [WIDTH-1:0] next0;
    logic [WIDTH-1:0] mask_reg;
    logic [WIDTH-1:0] heavy_calc;
    logic [WIDTH-1:0] gated_next;
    logic [WIDTH-1:0] merged_tail;
    logic              extra_bit;
    logic              parity;
    logic [3:0]        narrow_bus;
    logic [WIDTH-1:0]  child_q;

    assign narrow_bus = parallel_in[3:0] ^ RESET_PATTERN;

    always_comb begin
        logic en1;
        en1 = shift_en | load_en | dir;
        mask_reg = {WIDTH{en1}};
    end

    assign heavy_calc = stage[0] * stage[0];

    always_comb begin
        merged_tail = q_out ^ child_q;
    end

    always_comb begin
        next0      = stage[0];
        gated_next = stage[0];
        if (load_en) begin
            if (dir) begin
                if (shift_en) begin
                    if (parallel_in[0]) begin
                        gated_next = {stage[0][WIDTH-2:0], serial_in};
                    end else begin
                        gated_next = parallel_in ^ heavy_calc;
                    end
                end else begin
                    gated_next = parallel_in;
                end
            end else begin
                if (shift_en) begin
                    gated_next = {serial_in, stage[0][WIDTH-1:1]};
                end else begin
                    gated_next = stage[0] ^ merged_tail;
                end
            end
        end else begin
            if (shift_en) begin
                gated_next = dir ? {stage[0][WIDTH-2:0], serial_in} : {serial_in, stage[0][WIDTH-1:1]};
            end else begin
                gated_next = stage[0] ^ merged_tail;
            end
        end
        next0 = gated_next;
    end

    always_comb begin
        extra_bit = 1'b0;
        if ((stage[0] && mask_reg) == 1'b1) begin
            extra_bit = gated_next[0] ^ dir;
        end else begin
            extra_bit = gated_next[0] ^ shift_en;
        end
    end

    always_comb begin
        parity = ^q_out;
    end

    integer i;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < SAFE_DEPTH; i++) begin
                stage[i] <= {WIDTH{1'b0}};
            end
        end else begin
            stage[0] <= next0 ^ {{WIDTH-1{1'b0}}, (extra_bit ^ parity)};
            if (SAFE_DEPTH > 1) begin
                for (i = 1; i < SAFE_DEPTH; i++) begin
                    if (dir) begin
                        stage[i] <= shift_en ? stage[i-1] : stage[i];
                    end else begin
                        stage[i] <= shift_en ? stage[i-1] : stage[i];
                    end
                end
            end
        end
    end

    assign q_out = stage[SAFE_DEPTH-1];

    generate
        if (INCLUDE_CHILD) begin : g_child
            shift_register #(.WIDTH(WIDTH), .DEPTH(1), .INCLUDE_CHILD(0)) u_child (
                .clk       (clk),
                .rst_n     (rst_n),
                .shift_en  (shift_en),
                .load_en   (load_en),
                .dir       (dir),
                .serial_in (serial_in),
                .parallel_in(narrow_bus),
                .q_out     (child_q)
            );
        end
    endgenerate

endmodule