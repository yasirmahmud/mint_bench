module binary_to_bcd #(
    parameter BIN_WIDTH = 8
)(
    input  [BIN_WIDTH-1:0] binary,
    output reg [3:0] thousands,
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] units
);
    integer i;
    reg [15:0] shift_reg; // Enough to hold binary and BCD digits

    // Declare temporary registers at the module level (Verilog-2001 compliance, resolves STX_VE_479 violations)
    reg [3:0] adj_thousands;
    reg [3:0] adj_hundreds;
    reg [3:0] adj_tens;
    reg [3:0] adj_units;

    always @(*) begin
        // Initialize shift register with binary input.
        // The original `{ (16-BIN_WIDTH){1'b0}, binary }` uses SystemVerilog replication syntax.
        // This is a Verilog-2001 compliant way to zero-pad `binary` to 16 bits,
        // resolving STX_VE_481 (line 18). This assumes BIN_WIDTH <= 16 as per design comment.
        shift_reg = {16{1'b0}};
        shift_reg[BIN_WIDTH-1:0] = binary;
        
        // Perform Double Dabble
        for (i = 0; i < BIN_WIDTH; i = i + 1) begin
            // Check each BCD digit and add 3 if >=5
            // These assignments are to the module-level temporary variables.
            adj_thousands = shift_reg[15:12];
            if (adj_thousands >= 5) begin
                adj_thousands = adj_thousands + 3;
            end

            adj_hundreds = shift_reg[11:8];
            if (adj_hundreds >= 5) begin
                adj_hundreds = adj_hundreds + 3;
            end 

            adj_tens = shift_reg[7:4];
            if (adj_tens >= 5) begin
                adj_tens = adj_tens + 3;
            end

            // Preserving the original behavior of adjusting shift_reg[3:0]
            // even if it may contain binary data in initial iterations.
            adj_units = shift_reg[3:0];
            if (adj_units >= 5) begin
                adj_units = adj_units + 3;
            end
            
            // Shift left by 1 after all adjustments, in a single assignment to shift_reg.
            shift_reg = {adj_thousands, adj_hundreds, adj_tens, adj_units} << 1;
        end
        
        // Assign BCD digits from the final shift register state
        thousands = shift_reg[15:12];
        hundreds  = shift_reg[11:8];
        tens      = shift_reg[7:4];
        units     = shift_reg[3:0];
    end
endmodule
