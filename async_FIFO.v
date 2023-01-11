//asyncronous FIFO/ Dual clock FIFO- not complete but captures important details 
`default_nettype none
`timescale 1ns/1ps //	time period/time precision #5.000
module top_module(
input [7:0]din,ren,wen,wclk,rclk,
output [7:0]dout,full,empty);

reg [7:0]data[0:7];
reg [3:0]wptr=4'b0;
reg [3:0]rptr=4'b0;
reg [3:0]wdepth;
reg [3:0]rdepth;


//depth for writer and reader. generate full and empty
always@(*) begin
	wdepth=wptr-rptrss;
	rdepth=wptrss-rptr;
	if(wdepth==4'b1000)
		full=1'b1;
	else if(rdepth==4'b0)
		empty=1'b1;
	else begin
		full=1'b0;empty=1'b0;
	end
end

//producer clock side, ignoring reset for wptr
always@(wclk) begin
	//double sync rptrg -> do not mistake it for wptr because we need to sync read pointers with wclk so that we can use it to calculate wdepth
	rptrg_s<=rptrg;
	rptrg_ss<=rptrg_s;
	//instantiate bintogray and graytobin
	bintogray insta1(....);
	graytobin insta2(....);
	
	//write data to FIFO
	if(wen & ~full) begin
		data[wptrss[2:0]]<=din;
		wptrss<=wptrss+1;
	end
end

//reader clock side, ignoring reset
always@(rclk) begin
	//double sync wptr -> see comment in wclk domain
	wptrg_s<=wptrg;
	wptrg_ss<=wptrg_s;
	//instantiate bintogray and graytobin
	bintogray insta1(....);
	graytobin insta2(....);
	//read data from FIFO
	if(ren & ~empty) begin
		dout<=data[rptrss[2:0]];
		rptrss=rptrss+1;		
	end
end

//sequence for wptr-> bin counter-> bin to gray converter -> double sync wptrg -> convert back to bin as wptrss
//below module converts to gray, double sync taken care in Sync blocks above
module bintogray(input [3:0]wptr,[3:0]rptr,output [3:0]wptrg,[3:0]rptrg);

endmodule

//below module converts gray_ss to bin_ss
module graytobin(input [3:0]wptrg_ss,[3:0]rptrg_ss,output [3:0]wptrss,[3:0]rptrss);

endmodule


endmodule
