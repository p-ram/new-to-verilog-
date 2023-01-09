`default_nettype none
module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 

    always@(posedge clk) begin
        if(load)
            q<=data;
        else begin
            if(~ena)
                q<=q;
            else begin
                case(amount)
                    2'b00: q<=q<<<1;
                    2'b01: q<=q<<<8;
                    /*q >>> 1 and q >>> 8 did not work, not sure why ?
                  logical and arithmetic left shift are same
                  Logical and arithmetic right shift are different because we are preserving MSB bit in arithmetic shift
                    
                  syntax for replication vector concatination -> { {2{0}},1,1} = 0011
                  {5{1'b1}}           // 5'b11111 (or 5'd31 or 5'h1f)
                  {2{a,b,c}}          // The same as {a,b,c,a,b,c}
                  {3'd5, {2{3'd6}}}   // 9'b101_110_110. It's a concatenation of 101 with
                                      // the second vector, which is two copies of 3'b110.
                  */
                    2'b10: q<={q[63],q[63:1]};
                    2'b11: q<={ {8{q[63]}},q[63:8] };
                endcase
            end
        end
    end
endmodule
