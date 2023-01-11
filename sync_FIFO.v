//synchronous FIFO using n+1 bit pointer 
`default_nettype none
module top_module(
input [7:0] data_in,wen, clk,ren,
output [7:0] dout, full,empty);

reg [7:0] data [0:7]; //8 locations each of 8bits
reg wenq =1'b0;
reg renq =1'b0;
reg [3:0] wptr=4'b0;
reg [3:0] rptr=4'b0;
reg [3:0] depth;


//depth calculation
always@(*) begin
	depth=wptr-rptr;
	if(depth ==4'b1000)
		full=1'b1;
	else if(depth ==4'b0)
		empty=1'b1;
	else begin
		full=1'b0;
		empty=1'b0;
		end
end


always@(posedge clk) begin //dint use reset to make wptr and rptr zero
	if(~full & wen)
		wenq<=1'b1;
	else if(~empty & ren)
		renq<=1'b1;
	else begin
		wenq<=1'b0;
		renq<=1'b0;
		end
	//write data to FIFO
	if(wenq) begin
		data[wptr[2:0]]<=data_in;
		wptr<=wptr+1'b1;
		end
	//read data from FIFO
	else if(rptr) begin
		dout<=data[rptr[2:0]];
		rptr<=rptr+1'b1;
	end
end
endmodule
