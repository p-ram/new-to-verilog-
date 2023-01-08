`default_nettype none
module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);
    integer i;
    reg [7:0] in_p;
    /*delay the input by a clock and check for xor of delayed_input to input
    reasoning for xor
    posedge detection
    	input is 1 and delayed_input is 0
    negedge detection
    	input is 0 and delayed input is 1
    since we need for both edge, xor property is valid 
    */
    always@(posedge clk) begin
        in_p <= in;
        //iterate for all bits
        for(i=0; i<8;i=i+1) begin
            if(in_p[i] ^ in[i]) 
                anyedge[i]=1;
            else
                anyedge[i]=0;
        end
    end

endmodule
