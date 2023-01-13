/* Generate allows multiple module instantiation or allow conditional module instantiation
eg while building full adders with half adders

Doesnt contain port, specify but other generate blocks allowed
*/

module ha(input a,b,output sum,cout);
endmodule

module fa(input cin,A,B,output Sum,Cout);
  genvar i;
  assign cin=0;
  generate
    for(i=0;i<2;i=i+1) begin
      //ha ha_inst(.a(A)....)  module instantiation also possible
      hua ha_inst(A[i],B[i],Sum[i],Cout[i]);
    end
  endgenerate
endmodule
  
