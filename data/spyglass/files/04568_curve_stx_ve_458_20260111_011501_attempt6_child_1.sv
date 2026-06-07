module curve_stx_ve_458_20260111_011501_attempt6 (
  input wire [7:0] control_in,
  input wire [7:0] data_in_a,
  input wire [7:0] data_in_b,
  output reg [7:0] result_out
);

  // An 'automatic' function means its local variables are allocated on the stack
  // and deallocated upon function exit. Performing non-blocking assignments (NBAs) 
  // to such variables is an illegal use (STX_VE_458) as the scheduled update 
  // would attempt to write to invalid memory after the function returns.
  automatic function [7:0] calculate_and_store (
    input [7:0] sel_arg, 
    input [7:0] arg1,
    input [7:0] arg2
  );
    // These 'reg' variables are implicitly automatic because the function is 'automatic'.
    // The non-blocking assignments have been changed to blocking assignments to resolve the STX_VE_458 and WRN_44 violations.
    reg [7:0] temp_val_0;
    reg [7:0] temp_val_1;
    reg [7:0] temp_val_2;
    reg [7:0] temp_val_3;
    reg [7:0] temp_val_4;

    begin
      // Changed non-blocking assignments to blocking assignments to resolve violations.
      temp_val_0 = arg1 + sel_arg; 
      temp_val_1 = arg2 - sel_arg; 
      temp_val_2 = arg1 ^ arg2; 
      temp_val_3 = {arg1[6:0], arg2[7]} + sel_arg[0];
      temp_val_4 = (arg1 > arg2) ? (arg1 + sel_arg) : (arg2 - sel_arg); 
      
      // All temporary variables are used to prevent 'unused signal' warnings.
      calculate_and_store = temp_val_0 + temp_val_1 + temp_val_2 + temp_val_3 + temp_val_4;
    end
  endfunction

  // This always block calls the function to drive the output.
  // The `always @*` syntax (Verilog-2001) creates combinational logic.
  always @* begin
    result_out = calculate_and_store(control_in, data_in_a, data_in_b);
  end

endmodule
