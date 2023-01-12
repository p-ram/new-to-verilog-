module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter A=0,B=1,C=2;
    reg [1:0]state,next;//if we do not include 2 bits for state, we will only consider states A and B due to state=0 and state=1
    
    //state transitions
    always@(*) begin
        case(state)
            A:next=x?B:A;
            B:next=x?B:C;//B:next=x?A:C;//error When in B, if x=1 then stay at B and not go to A, will solve cases 101...10101
            C:next=x?B:A;
        endcase
    end
    
    //state FF
    always@(posedge clk or negedge aresetn) begin
        if(~aresetn)
            state<=A;
        else
            state<=next;
    end
	
    //output logic - since Mealey, output depends on Input, thus z=x
    always@(*) begin
        if(state==C)
            z=x;
        else
            z=0;
    end
endmodule
