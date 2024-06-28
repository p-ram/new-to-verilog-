// Code your design here
module ram #(parameter ADDR_SIZE=4,
        parameter DATA_SIZE=32) (
  input clk,
  input [ADDR_SIZE-1:0] addr,
  input [DATA_SIZE-1:0] wr_data,
  input rd_wrb,
  output [DATA_SIZE-1:0] rd_data
);

  reg [DATA_SIZE-1:0] mem [0:(1<<ADDR_SIZE)-1];
  
  always@(posedge clk) begin
    mem[addr] <= rd_wrb ? mem[addr] : wr_data;
  end
  
  assign rd_data = rd_wrb ? mem[addr] : 'h0;
endmodule
