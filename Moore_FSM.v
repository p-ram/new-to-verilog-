module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  
	
    // A finite state machine is usually coded in three parts:
    //   State transition logic
    //   State flip-flops
    //   Output logic
    // It is sometimes possible to combine one or more of these blobs of code
    // together, but be careful: Some blobs are combinational circuits, while some
    // are clocked (DFFs).
    // Combinational always block for state transition logic. Given the current state and inputs,
    // what should be next state be?
    // Combinational always block: Use blocking assignments.

	parameter A=0,B=1;
    reg state,next;
    
    //state transition logic using comb always block
    always@(*) begin
        case(state) 
            A: next = in?A:B;
            B: next = in?B:A;
        endcase
    end
    
    //sync block for state FF with async reset
    always@(posedge clk or posedge areset) begin
        if(areset)
            state<=B;
        else
            state<=next;
    end
    
    //output logic using combinational assign or always block
    assign out= (state==B);
	
    
endmodule
