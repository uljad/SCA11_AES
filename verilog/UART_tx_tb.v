`timescale 1ns / 1ns
`include "UART_transmitter.v"
`include "clockDivider.v"

module Top_tb();
  reg clk;
  reg reset;
  reg tx_start;
  wire s_tick;
  reg [7:0] din;
  wire tx_done_tick;
  wire tx;

  clockDiv baud(clk, reset, s_tick);
  UART_tx transmitter(clk, reset, tx_start, s_tick, din, tx_done_tick, tx);


  always @* begin
    #5 clk <= !clk;
  end

  initial begin
    $dumpfile("Top.vcd");
    $dumpvars(0, Top_tb);

    reset <= 1;
    reset <= 0;
    clk <= 0;


    din <= 8'b10010101;
    tx_start <= 1;
    #50;
    tx_start <= 0;

    #100000;

    $finish;
  end
endmodule
