module my_module_ex2 (
    input clk,
    input rst_n, // Active-low reset
    output reg my_reg
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        my_reg <= 1'b0; // Initialize my_reg to 0 on reset
    end
    // else begin
    //     my_reg <= my_reg; // my_reg retains its value otherwise, as no other behavior is specified.
    // end
end

endmodule
