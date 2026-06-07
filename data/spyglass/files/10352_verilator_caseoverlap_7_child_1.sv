module overlap_ex7;
  reg [1:0] sel;
  reg out;

  // To resolve 'undriven sel' violation and demonstrate functionality
  initial begin
    sel = 2'b00;
    #10;
    sel = 2'b01;
    #10;
    sel = 2'b10; // Covered by default
    #10;
    sel = 2'b11; // Covered by default
    #10;
    $finish;
  end

  always @(sel) begin
    case (sel)
      2'b00: out = 1'b0;
      2'b01: out = 1'b1;
      // Removed duplicate '2'b00' case to resolve CASEOVERLAP
      default: out = 1'b0;
    endcase
    // Added $display to resolve 'out' being set but not read
    $display("At time %0t: sel = %b, out = %b", $time, sel, out);
  end
endmodule
