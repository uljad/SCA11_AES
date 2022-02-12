`timescale 1ns / 1ns
`include "clockDivider.v"

module Top_tb();
  reg clk;
  reg reset;
  wire baud;

  clockDiv divider(clk, reset, baud);

  always @* begin
    #5 clk <= !clk;
  end

  initial begin
    $dumpfile("Top.vcd");
    $dumpvars(0, Top_tb);

    reset <= 1;
    clk <= 0;

    #1000;
    
    $finish;
  end
endmodule
