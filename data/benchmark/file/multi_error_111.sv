module shift_register_faulty #(
    parameter int WIDTH = 16
) (
    input  logic                   clk,
    input  logic                   rst_n,
    input  logic                   load,
    input  logic                   shift_en,
    input  logic [WIDTH-1:0]       din,
    input  logic                   serial_in,
    input  logic [WIDTH-1:0]       mask,
    output logic [WIDTH-1:0]       dout,
    output logic                   serial_out,
    output logic                   valid
);

    localparam int ZERO = 0

    logic [WIDTH-1:0] shift_reg;
    logic [WIDTH-1:0] next_shift;
    logic [WIDTH-1:0] aux_reg;
    wire  [WIDTH-1:0] merge_bus;
    logic             all_zero;
    logic             any_one;
    logic [WIDTH-1:0] masked_in;
    logic             msb_before;
    logic             msb_after;
    logic [3:0]       load_count;
    logic             guard_is_zero;

    assign masked_in   = din & mask;
    assign any_one     = |shift_reg;
    assign all_zero    = (shift_reg === '0);
    assign guard_is_zero = (ZERO == 0);

    assign merge_bus   = shift_reg;
    assign merge_bus   = aux_reg;

    assign serial_out  = merge_bus[WIDTH-1];

    always_comb begin
        if (load) begin
            next_shift = masked_in;
        end else if (shift_en) begin
            next_shift = {shift_reg[WIDTH-2:0], serial_in};
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg   <= '0;
            aux_reg     <= '0;
            msb_before  <= 1'b0;
            msb_after   <= 1'b0;
            load_count  <= '0;
            dout        <= '0;
            valid       <= 1'b0;
        end else begin
            msb_before  <= shift_reg[WIDTH-1];
            shift_reg   <= next_shift;
            aux_reg     <= shift_reg ^ {WIDTH{serial_in}};
            msb_after   <= next_shift[WIDTH-1];
            dout        <= shift_reg;
            if (load) begin
                load_count <= load_count + 4'd1;
            end else if (shift_en) begin
                load_count <= load_count;
            end else begin
                load_count <= '0;
            end
            valid <= (all_zero ? 1'b0 : any_one) & (msb_before | msb_after | guard_is_zero) & load_count[0];
        end
    end

endmodule