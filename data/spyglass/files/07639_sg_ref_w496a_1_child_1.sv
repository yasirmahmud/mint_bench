module W496a_ex1 (input wire a, output reg out);
  always @(*) begin
    // SpyGlass violations W496a, SYNTH_5034, STARC05-2.10.1.4a/b indicate
    // that a comparison with 'z' (a == 1'bz) will be treated as FALSE during synthesis.
    // Therefore, the original 'if' branch (out = 1) would never be taken in synthesized hardware.
    // To preserve the synthesized functional behavior and resolve the violations,
    // 'out' is always assigned to 0.
    out = 0;
  end
endmodule
