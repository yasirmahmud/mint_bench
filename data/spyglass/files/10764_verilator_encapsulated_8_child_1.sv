module example_08;
  class BaseClass;
    protected int protected_q[$] = {32'd70, 32'd71};

    // Public getter method to safely access protected_q elements
    function int get_protected_q_element(int index);
      if (index >= 0 && index < protected_q.size()) begin
        return protected_q[index];
      end else begin
        $error("Error: Index %0d out of bounds for protected_q (size %0d). Returning default value.", index, protected_q.size());
        return 0; // Return a default value or error indication
      end
    endfunction
  endclass

  class AnotherClass;
    function void access_protected_queue(BaseClass base_obj);
      // Access protected_q via the public getter method provided by BaseClass
      $display("Accessing protected_q[0]: %0d", base_obj.get_protected_q_element(0));
    endfunction
  endclass

  initial begin
    BaseClass base = new();
    AnotherClass another = new();
    another.access_protected_queue(base);
  end
endmodule
