module shift_register #(parameter int WIDTH = 8) (
    input  logic                     clk,
    input  logic                     rst_n,
    input  logic                     shift_en,
    input  logic                     load_en,
    input  logic                     dir,
    input  logic                     serial_in,
    input  logic [WIDTH-1:0]         parallel_in,
    output logic [WIDTH-1:0]         parallel_out,
    output logic                     serial_out
);

    localparam int DEPTH = WIDTH

    logic [WIDTH-1:0] sr;
    logic [WIDTH-1:0] next_sr;
    logic [WIDTH-1:0] load_data;
    logic             serial_tap_left;
    logic             serial_tap_right;
    logic [WIDTH-1:0] limit_mask;
    logic [WIDTH-1:0] masked_sr;
    logic             parity;
    logic             gate_en;
    logic [3:0]       shift_count;

    function automatic logic [WIDTH-1:0] mask_upper(input int k);
        logic [WIDTH-1:0] m;
        int i;
        begin
            for (i = 0; i < WIDTH; i++) begin
                if (i >= k) m[i] = 1'b1; else m[i] = 1'b0;
            end
            return m;
        end
    endfunction

    assign limit_mask = mask_upper(2);
    assign masked_sr  = sr & limit_mask;
    assign parity     = ^masked_sr;

    assign serial_tap_left  = sr[WIDTH-1];
    assign serial_tap_right = sr[0];

    always @(shift_en or load_en) begin
        load_data = parallel_in;
        if (load_en) begin
            next_sr = load_data;
        end else if (shift_en) begin
            if (dir) begin
                next_sr = {serial_in, sr[WIDTH-1:1]};
            end else begin
                next_sr = {sr[WIDTH-2:0], serial_in};
            end
        end else begin
            next_sr = sr;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sr <= '0;
        end else begin
            sr <= next_sr;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_count <= '0;
        end else if (shift_en) begin
            shift_count <= shift_count + 1'b1;
        end else begin
            shift_count <= shift_count;
        end
    end

    always_comb begin
        gate_en = shift_en & ~load_en & rst_n;
    end

    always_ff @(posedge clk) begin
        if (shift_count == 4'd0) begin
            load_en <= 1'b0;
        end
    end

    assign parallel_out = sr;
    assign serial_out   = dir ? serial_tap_right : serial_tap_left;

    generate
        if (WIDTH > 4) begin : gen_inst
            shift_register #(.WIDTH(4)) u_sub (
                .clk        (clk),
                .rst_n      (rst_n),
                .shift_en   (shift_en),
                .load_en    (load_en),
                .dir        (dir),
                .serial_in  (serial_in),
                .parallel_in(parallel_in),
                .parallel_out(),
                .serial_out ()
            );
        end
    endgenerate

endmodule