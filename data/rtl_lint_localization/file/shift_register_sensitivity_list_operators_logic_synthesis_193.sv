module shift_register #(parameter int WIDTH = 16) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     load,
    input  logic                     shift_en,
    input  logic                     dir,
    input  logic                     serial_in_left,
    input  logic                     serial_in_right,
    input  logic [WIDTH-1:0]         parallel_in,
    input  logic [WIDTH-1:0]         hold_mask,
    output logic [WIDTH-1:0]         parallel_out
);

    logic [WIDTH-1:0] data_q;
    logic [WIDTH-1:0] data_d;
    logic [WIDTH-1:0] enable_mask;
    logic             combined_mask_flag;
    logic             insertion_bit;
    logic [WIDTH-1:0] preload_value;
    logic             head_bit;
    logic             tail_bit;
    logic [WIDTH-1:0] masked_new;
    logic [WIDTH-1:0] preserved_old;

    assign enable_mask = {WIDTH{shift_en}};

    assign combined_mask_flag = hold_mask && enable_mask;

    assign head_bit = data_q[WIDTH-1];
    assign tail_bit = data_q[0];

    always_comb begin
        masked_new    = '0;
        preserved_old = '0;
        masked_new    = (data_d & ~hold_mask);
        preserved_old = (data_q & hold_mask);
    end

    always_comb begin
        data_d = data_q;
        if (dir) begin
            data_d = {data_q[WIDTH-2:0], insertion_bit};
        end else begin
            data_d = {insertion_bit, data_q[WIDTH-1:1]};
        end
        if (|hold_mask) begin
            data_d = masked_new | preserved_old;
        end
    end

    always_comb begin
        if (dir) begin
            insertion_bit = serial_in_left;
        end else if (combined_mask_flag) begin
            insertion_bit = serial_in_right;
        end
    end

    always @(parallel_in) begin
        if (load) begin
            preload_value = parallel_in;
        end else begin
            preload_value = {WIDTH{1'b0}};
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_q <= '0;
        end else begin
            if (load) begin
                data_q <= preload_value;
            end else if (shift_en) begin
                data_q <= data_d;
            end else begin
                data_q <= data_q;
            end
        end
    end

    assign parallel_out = data_q;

endmodule