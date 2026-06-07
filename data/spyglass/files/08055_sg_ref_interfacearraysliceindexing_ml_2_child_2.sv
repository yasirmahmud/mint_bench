interface my_if;
 logic a;
endinterface

// Define a struct to encapsulate the virtual interface handle.
// This addresses the ELAB_6312 violation by providing a 'supported variable type'
// for array declaration, while preserving the functional intent of holding
// virtual interface handles.
typedef struct {
  virtual my_if handle;
} virtual_my_if_handle_s;

module my_module_ex2;
 // Declare an array of the struct containing virtual interface handles
 virtual_my_if_handle_s if_arr[4];
 virtual_my_if_handle_s v_if_slice[2];

 initial begin
  // This assignment now works with arrays of structs, maintaining functional behavior
  v_if_slice = if_arr[1 +: 2];
 end

endmodule
