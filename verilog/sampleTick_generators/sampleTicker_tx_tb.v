`timescale 1ns / 1ns
`include "sampleTick_generator_tx.v"

module Top_tb();
  reg clk;
  reg reset;
  wire s_tick;

  sample_ticker_tx sampler(clk, reset, s_tick);

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
