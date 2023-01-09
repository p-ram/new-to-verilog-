always@(posedge clk or areset) begin
//Error -> mixed single- and double-edge expressions are not supported  
  
always@(posedge clk and negedge clk) begin
// Error -> event control cannot test for both positive and negative edges of variable "clk"

/*this list tells when to to execute block of code, 2 types
Level sensitive (for combinational circuits).
Edge sensitive (for flip-flops).
*/
