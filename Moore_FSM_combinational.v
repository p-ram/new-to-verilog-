`default_nettype none
module top_module(
    input in,
    input [1:0] state,//important for comb FSM
    output [1:0] next_state,//important for comb FSM, we declare reg state,next for sync FSM; no clk either in ports
    output out); //

    parameter A=0, B=1, C=2, D=3;
    //reg rstate;//since combinational Moore FSM, no need state transition
    
    //state transitions
    always@(*) begin
        case(state)
            A: next_state=~in?A:B;
            B: next_state=~in?C:B;
            C: next_state=~in?A:D;
            D: next_state=~in?C:B;
        endcase
    end
       
    //output
    assign out =(state==D);
	
endmodule
