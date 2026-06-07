module dual_edge_trig_ff(
    input clk, reset, d,
    output reg q
    );
    reg q1, q2;
    
    // Fix for violations 2, 4 (STARC05-2.2.3.3, W415a)
    // The reset condition must take precedence over the data assignment
    always@ (posedge clk)
        begin
            if(reset) q1 <= 1'b0;
            else      q1 <= d;
        end
    
    // Fix for violations 3, 5 (STARC05-2.2.3.3, W415a)
    // The reset condition must take precedence over the data assignment
    always@ (negedge clk)
        begin
            if(reset) q2 <= 1'b0;
            else      q2 <= d; 
        end

    // Fix for violation 1 (STARC05-1.4.3.4) and STX_VE_481:
    // Changed 'always_comb' to 'always @*' for wider tool compatibility (Verilog-2001 equivalent).
    // The output 'q' is changed to 'output reg q' as it is driven from an always block.
    always @* begin
        if (clk) begin
            q = q1;
        } else begin
            q = q2;
        end
    end

endmodule
