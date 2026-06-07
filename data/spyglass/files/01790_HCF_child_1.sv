module HCF#(parameter N= 8)
    ( input clk,
      input reset,
      input start, // Rising edge of start initiates computation
      input [N-1:0] in1,
      input [N-1:0] in2,
      output reg [N-1:0] HCF,
      output reg HCF_done ); // Indicates when HCF is valid

    reg [N-1:0] i1_reg;
    reg [N-1:0] i2_reg;

    // States for the FSM
    localparam [1:0] S_IDLE    = 2'b00;
    localparam [1:0] S_COMPUTE = 2'b01;

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S_IDLE;
            i1_reg <= '0;
            i2_reg <= '0;
            HCF <= '0;
            HCF_done <= 1'b0;
        end else begin
            case (state)
                S_IDLE: begin
                    HCF_done <= 1'b0; // Clear done when in IDLE
                    if (start) begin
                        i1_reg <= in1;
                        i2_reg <= in2;
                        if (in1 == in2) begin
                            HCF <= in1;
                            HCF_done <= 1'b1;
                            state <= S_IDLE; // Done immediately if inputs are already equal
                        end else begin
                            state <= S_COMPUTE;
                        end
                    end else begin
                        state <= S_IDLE; // Stay in IDLE if start not asserted
                    end
                end
                S_COMPUTE: begin
                    if (i1_reg != i2_reg) begin
                        if (i1_reg > i2_reg) begin
                            i1_reg <= i1_reg - i2_reg;
                        end else begin // i2_reg > i1_reg
                            i2_reg <= i2_reg - i1_reg;
                        end
                        state <= S_COMPUTE; // Continue computing next cycle
                    end else begin // i1_reg == i2_reg, computation is complete
                        HCF <= i1_reg; // Store the result
                        HCF_done <= 1'b1; // Signal completion
                        state <= S_IDLE; // Go back to IDLE
                    end
                end
                default: begin // Defensive default
                    state <= S_IDLE;
                    HCF_done <= 1'b0;
                end
            endcase
        end
    end
endmodule
