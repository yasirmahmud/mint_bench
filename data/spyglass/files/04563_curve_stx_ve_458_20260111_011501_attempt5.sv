module curve_stx_ve_458_20260111_011501_attempt5 (
  input wire [7:0] data_in,
  output reg [7:0] data_out
);

  // Declare the function itself as 'automatic'.
  // In Verilog-2001, this means variables declared within it (unless explicitly declared 'static')
  // are implicitly 'automatic' (allocated on the stack for each call).
  automatic function [7:0] my_func (input [7:0] val_in);
    // These 'reg' variables are implicitly automatic because the function is automatic.
    // Performing non-blocking assignments ('<=') to these automatic variables within a function
    // is an illegal use (STX_VE_458). Automatic variables are deallocated upon function exit,
    // making scheduled non-blocking updates problematic as they would attempt to write to invalid memory.
    reg [7:0] temp_reg_0; // Implicitly automatic variable: STX_VE_458 violation 1
    reg [7:0] temp_reg_1; // Implicitly automatic variable: STX_VE_458 violation 2
    reg [7:0] temp_reg_2; // Implicitly automatic variable: STX_VE_458 violation 3
    reg [7:0] temp_reg_3; // Implicitly automatic variable: STX_VE_458 violation 4
    reg [7:0] temp_reg_4; // Implicitly automatic variable: STX_VE_458 violation 5

    begin
      // Each non-blocking assignment to an implicitly automatic variable
      // within an automatic function triggers an STX_VE_458 violation.
      temp_reg_0 <= val_in + 0;
      temp_reg_1 <= val_in + 1;
      temp_reg_2 <= val_in + 2;
      temp_reg_3 <= val_in + 3;
      temp_reg_4 <= val_in + 4;

      // To avoid 'unused signal' warnings, all declared automatic variables are used
      // in the function's return value calculation. The result will wrap around if it exceeds 8 bits.
      my_func = temp_reg_0 + temp_reg_1 + temp_reg_2 + temp_reg_3 + temp_reg_4;
    end
  endfunction

  // The function is called in an always_comb block (Verilog-2001 style always @*)
  // to drive the output, ensuring all parts of the module are active and used.
  always @* begin
    data_out = my_func(data_in);
  end

endmodule
