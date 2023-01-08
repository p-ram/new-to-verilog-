`default_nettype none
module top_module (
    input clk,
    input d,
    output q
);
    /*
    always@(posedge clk) begin
       q<=d; 
    end
    always@(negedge clk) begin
        q<=d;
    end
    Error -> Can't resolve multiple constant drivers for net "q"
    ----------xxxx---------
    always@(posedge clk or negedge clk) begin
       q<=d; 
    end
    Error -> event control cannot test for both positive and negative edges of variable "clk"
    
    
    Solution
                          mux
    D------posedge_DFF-----|1\
       |                   |  |----- out
       |___negedge_DFF-----|0/  
                      clk__|
    
    
    */
    reg q1,q2;
    always@(posedge clk) begin
       q1<=d; 
    end
    
    always@(negedge clk) begin
       q2<=d; 
    end
    
    always@(*) begin
        if(clk)
            q=q1;
        else
            q=q2;             
    end

endmodule
