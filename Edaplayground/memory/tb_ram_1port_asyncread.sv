`timescale 1ns / 1ns

module tb_ram;

  // Parameters
  parameter ADDR_SIZE = 4;
  parameter DATA_SIZE = 32;
  parameter CLK_PERIOD = 10;

  // Testbench signals
  reg clk;
  reg [ADDR_SIZE-1:0] addr;
  reg [DATA_SIZE-1:0] wr_data;
  reg rd_wrb;
  wire [DATA_SIZE-1:0] rd_data;

  // Instantiate the DUT (Device Under Test)
  ram #(
    .ADDR_SIZE(ADDR_SIZE),
    .DATA_SIZE(DATA_SIZE)
  ) uut (
    .clk(clk),
    .addr(addr),
    .wr_data(wr_data),
    .rd_wrb(rd_wrb),
    .rd_data(rd_data)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk = ~clk;
  end

  // Test sequence
  initial begin
    
      // Waveform dump
  $dumpfile("waveform.vcd");
  $dumpvars(0, tb_ram);
    
    // Initialize signals
    addr = 0;
    wr_data = 0;
    rd_wrb = 0;

    // Monitor output
    $monitor("Time = %0t | addr = %0d | wr_data = %0h | rd_wrb = %b | rd_data = %0h", 
              $time, addr, wr_data, rd_wrb, rd_data);

    // Write data to RAM
    @(posedge clk);
    addr = 4'd0; wr_data = 32'h80088008; rd_wrb = 0;
    @(posedge clk);
    addr = 4'd1; wr_data = 32'h40044004; rd_wrb = 0;
    @(posedge clk);
    addr = 4'd2; wr_data = 32'h20022002; rd_wrb = 0;
    @(posedge clk);
    addr = 4'd3; wr_data = 32'h10011001; rd_wrb = 0;

    // Read data from RAM
    
    
    @(posedge clk); addr = 4'd0;rd_wrb = 1;
     $display("Read from addr 0: %h", rd_data);

    @(posedge clk); addr = 4'd1;
    $display("Read from addr 1: %h", rd_data);

    @(posedge clk); addr = 4'd2;
    $display("Read from addr 2: %h", rd_data);

    @(posedge clk); addr = 4'd3;
    $display("Read from addr 3: %h", rd_data);
	@(posedge clk);
    // Finish simulation
    $finish;
  end

endmodule
