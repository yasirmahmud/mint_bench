module cast_const_ex4;
  class Animal;
    function new();
      $display("Animal constructor called");
    endfunction
  endclass
  class Dog extends Animal;
    function new();
      super.new();
      $display("Dog constructor called");
    endfunction
  endclass
  initial begin
    Dog my_dog = new();
    Animal pet;
    pet = my_dog;
    $display("Successfully assigned Dog object to Animal handle using static assignment.");
  end
endmodule
