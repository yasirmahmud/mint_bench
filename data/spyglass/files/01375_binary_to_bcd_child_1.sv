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

    always @(*) begin
        // Initialize shift register with binary input.
        // The original `{12'd0, binary}` when assigned to `shift_reg[15:0]`
        // implies `shift_reg = { (16-BIN_WIDTH){1'b0}, binary }` for BIN_WIDTH <= 16.
        // This explicit form ensures the behavior is preserved and clear.
        shift_reg = { (16-BIN_WIDTH){1'b0}, binary };
        
        // Perform Double Dabble
        for (i = 0; i < BIN_WIDTH; i = i + 1) begin
            // Temporary registers to hold the adjusted BCD parts before the shift.
            // This prevents multiple assignments to `shift_reg` within the same
            // combinational always block's loop iteration, resolving W415a violations.
            reg [3:0] adj_thousands;
            reg [3:0] adj_hundreds;
            reg [3:0] adj_tens;
            reg [3:0] adj_units;

            // Check each BCD digit and add 3 if >=5
            // These assignments are to local temporary variables.
            adj_thousands = shift_reg[15:12];
            if (adj_thousands >= 5) begin
                adj_thousands = adj_thousands + 3;
            end

            adj_hundreds = shift_reg[11:8];
            if (adj_hundreds >= 5) begin
                adj_hundreds = adj_hundreds + 3;
            } 

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
