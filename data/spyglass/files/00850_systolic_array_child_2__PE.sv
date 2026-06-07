module PE (
    input wire clk,
    input wire reset,
    input wire control,         // 1: load weights, 0: data flow
    input wire [7:0] data_in,
    input wire [7:0] weight_in_top,
    input wire [15:0] acc_in,
    output reg [7:0] data_out,
    output reg [15:0] acc_out,
    output reg [7:0] weight_out
);

    reg [7:0] r_weight_stored; // Register to store the weight for MAC operation

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_weight_stored <= 8'd0;
            data_out <= 8'd0;
            weight_out <= 8'd0;
            acc_out <= 16'd0;
        end else begin
            // Data propagates horizontally (1 cycle delay)
            data_out <= data_in;

            // Weight propagates vertically (1 cycle delay)
            weight_out <= weight_in_top;

            if (control) begin
                // Load weight into the PE when control is high
                r_weight_stored <= weight_in_top;
                // During weight loading, acc_out should propagate acc_in with 1 cycle delay.
                acc_out <= acc_in; 
            end else begin // Fixed: Changed 'else {' to 'else begin' for correct Verilog syntax
                // In data flow mode, perform Multiply-Accumulate
                // acc_out = acc_in + (data_in * stored_weight) with 1 cycle delay
                acc_out <= acc_in + (data_in * r_weight_stored);
            end // Fixed: Changed '}' to 'end' to close the 'else begin' block
        end
    end

endmodule
