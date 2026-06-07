module bin_BCD(input [7:0]in, output reg [3:0] b0,b1,b2,output reg[11:0] BCD);
    integer i;
    reg [3:0] current_b0_internal, current_b1_internal, current_b2_internal;
    // Declare temporary registers at the module or always block scope
    reg [3:0] dabble_val_b0;
    reg [3:0] dabble_val_b1;
    reg [3:0] dabble_val_b2;

always@(in)
begin
	current_b0_internal = 0;
    current_b1_internal = 0;
    current_b2_internal = 0;

    for(i=0; i<8; i=i+1)
    begin
        // Assign values to temporary registers at the beginning of each iteration
        // These temporary registers hold the dabble-adjusted values for the current iteration
        dabble_val_b0 = current_b0_internal;
        dabble_val_b1 = current_b1_internal;
        dabble_val_b2 = current_b2_internal;

        if(dabble_val_b0 > 4) dabble_val_b0 = dabble_val_b0 + 3;
        if(dabble_val_b1 > 4) dabble_val_b1 = dabble_val_b1 + 3;
        if(dabble_val_b2 > 4) dabble_val_b2 = dabble_val_b2 + 3;

        // Perform the shift stage and assign to the internal registers for the next iteration.
        // This ensures a single assignment to current_bX_internal within this loop iteration.
        {current_b2_internal, current_b1_internal, current_b0_internal} = {dabble_val_b2, dabble_val_b1, dabble_val_b0, in[7-i]};
    end

    // Assign the final computed values to the output registers after the loop completes.
    b0 = current_b0_internal;
    b1 = current_b1_internal;
    b2 = current_b2_internal;
    BCD= {current_b2_internal, current_b1_internal, current_b0_internal};
end
endmodule
