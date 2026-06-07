module cast_const_ex19;
  class Alpha;
  endclass
  class Beta extends Alpha;
  endclass
  initial begin
    Alpha a_inst;
    Beta b_inst = new();
    a_inst = b_inst; // Upcast
    if (!$cast(a_inst, b_inst)) begin // Always succeeds (redundant cast of upcasted object)
      $display("Cast failed");
    end
  end
endmodule
