module pad_display(
    input clk,
    input reset_n, // Added synchronous reset input
    input [0:2] pad,
    output [0:3] pad_pos_out,
    output [7:0] dig,
    output [7:0] ssd
    );


    //oscillator devide
    reg [17:0] div;
    reg clk_r; //refresh clock
    always @(posedge clk) begin
        if (!reset_n) begin // Synchronous active-low reset
            div <= 18'd0;
            clk_r <= 1'b0;
        end else begin
            if (div < 18'd208_333) begin //480Hz 
                div <= div + 1;
            end
            else begin
                div <= 18'd0;
            end
            clk_r <= div[17];
        end
    end


    //ABCD refresh
    reg [1:0] signal; // Removed initial assignment
    always @(posedge clk_r) begin
        if (!reset_n) begin // Synchronous active-low reset
            signal <= 2'b00;
        end else begin
            if(signal == 2'b11) begin
                signal <= 2'b00; // Changed to non-blocking assignment
            end
            else begin
                signal <= signal + 1;
            end
        end
    end
    
    reg [0:3] pad_pos; // Removed initial assignment
    always @(*) begin
        case(signal)
            2'b00: pad_pos = 4'b1000;
            2'b01: pad_pos = 4'b0100;
            2'b10: pad_pos = 4'b0010;
            2'b11: pad_pos = 4'b0001;
            default: pad_pos = 4'b0000; // Default case for full combinational coverage
        endcase
    end


    //SSD LUT
    // Original ssd_lut array and initial block removed.
    // The LUT logic is now directly embedded in the ssd_current combinational block.


    //EFG detection
    reg [7:0] ssd_current;
    always @(*) begin
        case(pad_pos)
            4'b1000: begin
                if(pad[0] == 1'b1) begin // Pad 1 (Index 0 in original LUT)
                    ssd_current = 8'b1001111_1;
                end
                else if(pad[1] == 1'b1) begin // Pad 2 (Index 1)
                    ssd_current = 8'b0010010_1;
                end
                else if(pad[2] == 1'b1) begin // Pad 3 (Index 2)
                    ssd_current = 8'b0000110_1;
                end
                else begin
                    ssd_current = 8'b1111111_1; // All segments off
                end
            end
            4'b0100: begin
                if(pad[0] == 1'b1) begin // Pad 4 (Index 3)
                    ssd_current = 8'b1001100_1;
                end
                else if(pad[1] == 1'b1) begin // Pad 5 (Index 4)
                    ssd_current = 8'b0100100_1;
                end
                else if(pad[2] == 1'b1) begin // Pad 6 (Index 5)
                    ssd_current = 8'b0100000_1;
                end
                else begin
                    ssd_current = 8'b1111111_1; // All segments off
                end
            end
            4'b0010: begin
                if(pad[0] == 1'b1) begin // Pad 7 (Index 6)
                    ssd_current = 8'b0001111_1;
                end
                else if(pad[1] == 1'b1) begin // Pad 8 (Index 7)
                    ssd_current = 8'b0000000_1;
                end
                else if(pad[2] == 1'b1) begin // Pad 9 (Index 8)
                    ssd_current = 8'b0000100_1;
                end
                else begin
                    ssd_current = 8'b1111111_1; // All segments off
                end
            end
            4'b0001: begin
                if(pad[0] == 1'b1) begin // Pad * (Index 9)
                    ssd_current = 8'b0000000_0;
                end
                else if(pad[1] == 1'b1) begin // Pad 0 (Index 10)
                    ssd_current = 8'b0000001_1;
                end
                else if(pad[2] == 1'b1) begin // Pad # (Index 11)
                    ssd_current = 8'b0011100_1;
                end
                else begin
                    ssd_current = 8'b1111111_1; // All segments off
                end
            end
            default: begin // Default case for full combinational coverage
                ssd_current = 8'b1111111_1; // All segments off
            end
        endcase
    end

    //output
    assign pad_pos_out = pad_pos;
    assign dig = 8'b0111_1111;
    assign ssd = ssd_current;

endmodule
