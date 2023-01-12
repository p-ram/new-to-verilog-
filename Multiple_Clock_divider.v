//not tested and not complete code, used for interview prep. Ignoring reset to make code easier to follow
//clock frequency by even number : rising edge of clock 
//freq divider/2
always@(posedge clk) begin
  if(reset)
     out<=1'b0;
  else
    out<=~out; // logic : ~Q is given to D
end


//freq divided by 4
//Option1: produce clk/2 and give that as clk input to "clk divider/2 circuit"
always@(posedge clk) begin
  div2<=~div2;
end
always@(posedge div2) begin //important to remember not to make mistake "posedge clk"
  div4<=div4;
end
//option2: make counter and count till 2 and then reset out
//   _   _   _   _
// _| |_| |_| |_| |_
// _____________|-------
reg count=2'b0;
always@(posedge clk) begin
  if(count==2'b10)
    out<=~out;
  else
    count<=count+2'b1;
end

//Summary freq divider by even number (2*N)
reg count=2'b0;
always@(posedge clk) begin
  if(count==N)
    out<=~out;
  else
    count<=count+2'b1;
end

//freq divider by odd number "N"
always@(posedge clk) begin
  if(pos_count==N-1)
    pos_count=0;
  else
    pos_count=pos_count+1;
end
always@(negedge clk) begin
  if(neg_count==N-1)
    neg_count=0;
  else
    neg_count=neg_count+1;
end
out=((pos_count> (N>>1)) | (neg_count> (N>>1)) ); // count the number of posedge or count negedge 
/* clock /3
 _   _   _   
| |_| |_| |_ 
 _____
|     |_____
# pos_edge count =2 or neg_edge count=2

*/





