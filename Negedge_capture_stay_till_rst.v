`default_nettype none
module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] in_p;
    integer i;
    //sync reset, negedge capture (detect and stay at 1 till reset)
    //delay input and check for input =0 and in_p =1
    always@(posedge clk) begin
        in_p <= in;
        //iterate all bits of input
        for(i=0;i<32;i=i+1) begin
            //sync reset
            if(reset)
                out=0;
            else begin
            	if(in[i]==0 && in_p[i]==1)
                	out[i]=1;
                else
                    out[i]=out[i];
            end
        end
    end
       
endmodule
