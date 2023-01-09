`default_nettype none
module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
	
    integer i;
    always@(posedge clk) begin
        if(load)
            q<=data;
        else begin
            //rotate left
            if(ena==2'b10) begin
                q[0]<=q[99];
                q[99:1]<=q[98:0];
            end
            //rotate right
            else if(ena==2'b01) begin
                q[99]<=q[0];
                q[98:0]<=q[99:1];
            end
            else if(ena==2'b00 | ena==2'b11)
                q<=q;
        end
    end
endmodule
