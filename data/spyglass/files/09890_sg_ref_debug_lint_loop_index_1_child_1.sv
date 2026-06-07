module DEBUG_LINT_LOOP_INDEX_ex1;
 integer unsigned_idx;
 integer signed_limit;
 initial begin
  signed_limit = 10;
  for (unsigned_idx = 0; unsigned_idx < signed_limit; unsigned_idx = unsigned_idx + 1) begin end
 end
endmodule
