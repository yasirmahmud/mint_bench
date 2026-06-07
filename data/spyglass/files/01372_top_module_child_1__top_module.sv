module top_module(clk,reset);
    input clk;
    input reset;
    
    reg [4:0] n;
    reg[31:0] out;
    // Changed next_in from reg to wire, as it is driven by the fibo_rtl module.
    // This ensures proper connectivity and resolves the undriven 'reg' issue
    // while allowing fibo_rtl to control the 'one_sec' counter.
    wire next_in;
    reg [26:0] one_sec;
    reg next_en;
    
    fibo_rtl d1(
        .clk(clk),
        .n(n),
        .next_en(next_en),
        .out(out),
        .next_in(next_in)
    );
    
    always@(posedge clk)begin
        if(reset)begin
            n <= 'd0;
            next_en <= 1'b0;
            one_sec <= 'd0;
        end
        else begin
            // The 'one_sec' counter increments if 'next_in' is high.
            // As 'fibo_rtl' now drives 'next_in' to 1'b1, this counter will increment every clock cycle.
            if(next_in)
                one_sec <= one_sec + 1'b1;
            
            // This condition checks if the 'next' value of one_sec would be 'd100000000.
            // Note: The 'one_sec' counter itself is not reset in the original design,
            // so it will continue to increment past 'd100000000 until it overflows.
            // This behavior is preserved as per the problem statement.
            if(one_sec + 1'b1 == 'd100000000)begin
                n <= n + 1'b1;
                next_en <= 1'b1;
            end
            else 
                next_en <= 1'b0;
        end
    end
    
endmodule
