// ---------------------------------------- TASK -------------------------------------------------
/* Basic Rules
2 types - inside module and sepetate file
includes timing delay, posedge negedge
Any number of input and output
Use both local(output valid only after completion) and global variable
Can call another task or function
task cannot be used within an expression

*/

module task_global(input a,output b);
  reg b;//important when calling task from seperate file using `include "mytask.v"
  task add;
    begin
      b=a+1;
    end
  endtask
endmodule

module task_local();
  task add_local;
    input a;
    output b;
    begin
      b=a+1;
    end
  endtask
endmodule

module task_calling(input a,output b);
  reg b;
  `include "task_global.v" //no ";"
  always@(*) begin
    add(a,b)
  end
endmodule
     
// --------------------------------- FUNCTION --------------------------------------
/* Mainly used for modeling combinational logic
same as task except function can drive only one output(can have multiple inputs) and cannot have timing delays */
module my_function();
  input a;
  function sub;
    begin
      sub=a-1;
    end
  endfunction
endmodule
\
module function_call(input a,output b);
  reg b;
  `include "my_function.v" // no ";"
  assign b=(sub(a)==0); //function can be used as expression
endmodule
  
  
    

    
