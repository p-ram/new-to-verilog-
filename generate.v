/* Generate allows multiple module instantiation or allow conditional module instantiation
eg while building full adders with half adders

Doesnt contain port, specify but other generate blocks allowed
*/
//Create a 100-bit binary ripple-carry adder by instantiating 100 full adders
`default_nettype none
module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );

    genvar i;
    generate
        fa inst0(.A(a[0]),.B(b[0]),.Cin(cin),.Cout(cout[0]),.Sum(sum[0]));
      /*
        for(i=1;i<100;i=i+1) begin
            fa ins1(.A(a[i]),.B(b[i]),.Cin(cout[i-1]),.Cout(cout[i]),.Sum(sum[i])); 
        end
      Error (10644): Verilog HDL error at driver.v(63): this block requires a name
      Solution-> for(i=1;i<100;i=i+1) begin: generate_fa      
      */
        for(i=1;i<100;i=i+1) begin: generate_fa
            fa ins1(.A(a[i]),.B(b[i]),.Cin(cout[i-1]),.Cout(cout[i]),.Sum(sum[i])); 
        end
    endgenerate
endmodule

module fa(input A,B,Cin,
          output Cout,Sum);
    assign Sum=A^B^Cin;
    assign Cout=(A&B)|Cin&(A^B); //error : was doing Cout=(A&B)+Cin&(A^B); 
endmodule
  
