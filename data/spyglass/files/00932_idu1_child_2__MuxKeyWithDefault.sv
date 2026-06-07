module MuxKeyWithDefault #(
    parameter NUM_CASES   = 1,
    parameter KEY_WIDTH   = 1,
    parameter VALUE_WIDTH = 1
) (
    output [VALUE_WIDTH-1:0] out,
    input  [KEY_WIDTH-1:0]   key_in,
    input  [VALUE_WIDTH-1:0] default_value,
    input  [(NUM_CASES * (KEY_WIDTH + VALUE_WIDTH)) - 1 : 0] cases_in
);

    reg [VALUE_WIDTH-1:0] mux_out_reg;

    localparam PAIR_WIDTH = KEY_WIDTH + VALUE_WIDTH;

    // Declare arrays of wires to hold extracted keys and values.
    // These need to be defined at the module level for Verilog-2001 compliance.
    wire [KEY_WIDTH-1:0]   extracted_keys[NUM_CASES-1:0];
    wire [VALUE_WIDTH-1:0] extracted_values[NUM_CASES-1:0];

    // Use a generate block to unroll the extraction of key-value pairs.
    // This allows using localparam for constant bit selections and genvar for loop index,
    // resolving syntax errors related to dynamic part-selects and localparam in procedural blocks.
    genvar i;
    generate
        for (i = 0; i < NUM_CASES; i = i + 1) begin : extract_pair_gen
            // Calculate the MSB and LSB bit positions of the current key-value pair.
            // These localparams are valid within the generate loop as 'i' is a genvar,
            // making the bit-selects constant at elaboration time.
            localparam pair_msb = PAIR_WIDTH * (NUM_CASES - i) - 1;
            localparam pair_lsb = PAIR_WIDTH * (NUM_CASES - i - 1);

            // Extract the key part from the current pair using constant part-select.
            assign extracted_keys[i] = cases_in[pair_msb : pair_msb - KEY_WIDTH + 1];
            // Extract the value part from the current pair using constant part-select.
            assign extracted_values[i] = cases_in[pair_msb - KEY_WIDTH : pair_lsb];
        end
    endgenerate

    always @(*) begin
        mux_out_reg = default_value; // Initialize with default, lowest priority

        // Declare loop variable 'k' before the for loop, as required by Verilog-2001
        // for `for` loops within an `always` block.
        integer k;

        // The 'cases_in' input is packed as {key0, value0, key1, value1, ...}
        // where key0,value0 are at the most significant bits of cases_in.
        // The original code iterates from the first case (k=0) to the last.
        // The last matching case in the loop takes precedence, ensuring the original priority behavior.
        for (k = 0; k < NUM_CASES; k = k + 1) begin
            if (key_in == extracted_keys[k]) begin
                mux_out_reg = extracted_values[k];
            end
        end
    end

    assign out = mux_out_reg;

endmodule
