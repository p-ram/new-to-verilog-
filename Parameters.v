//understanding verilog parameters
/*
is utilized to reuse module with different spec, eg define bus_width of module to be 32 and later override to make it 64.

2 types
-> Module parameters
   declare: parameter
   override: defparam
   convention: use upper case
   
   
-> Specify parameters
   used for timing and delay values
   declare: specparam
   override: [?]


*/
module example(input in, output out);
parameter foo=7;
parameter bar=5500;
  
  wire [foo-1:0] asd;
  reg [bar-1:0] qwe;
  
  ....
endmodule

//override
module tb();
  
  //module instantiation override, made foo and bar changes
  example #(foo=1,bar=44) eg (/*port list*/);
  
  //using defparam
  defparam foo=1; //overrides foo but keeps bar=5500
  
endmodule

//***************

specify
specparam t_setup=1;
endspecify

module spec_eg(..);
  specparam t_hold=0.1;
endmodule

//--------------------------------------------------------------------------------------------------------------
//using parameters in testbench to generate clk with period of 10ps
`timescale 1ps/1ps //time unit /time precision 
module top_module ( );
    specparam time_period =10; 
    //parameter time_period =10; //this also works but I would prefer using specparam for timescale
	reg clk;
    initial clk =0;
    
    always begin
        #(time_period/2) clk = ~clk;
    end
    
    dut dut_eg(.clk(clk));
    
endmodule
  

  


