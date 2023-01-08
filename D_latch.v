//D latch, use with caution
//warning message
/*
Quartus messages
Info (10041): Inferred latch for "q" at top_module.v(8) File: /home/h/work/hdlbits.8867932/top_module.v Line: 8
Unless you intentionally wanted to create a latch, this warning usually indicates a bug in a combinational always block. Make sure every variable is assigned a value in all cases so the previous value does not need to be remembered. Possible ways to achieve this include assigning a default value to variables at the top of the always block, using a default case, or having an else clause.
*/
module top_module (
    input d, 
    input ena,
    output q);
	
    //latches are level senstitive, so in always block use level sensitive lists
    always@(*) begin
        if (ena)
            q<=d; //since sequential elements use non-blocking
    end
endmodule
