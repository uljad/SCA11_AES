`timescale 1ns / 1ns
`include "UART_transmitter.v"
`include "UART_receiver.v"
`include "baudGenerator_rx.v"
`include "baudGenerator_tx.v"

module Top_tb();
  reg clk;
  reg reset;

  reg [7:0] din;
  wire [7:0] dout;

  wire s_tick_tx;
  wire s_tick_rx;

  wire tx_done_flag;
  wire rx_done_flag;

  reg tx_start;
  wire tx;

  baud_tx transmit_sampler(clk, reset, s_tick_tx);
  baud_rx receive_sampler(clk, reset, s_tick_rx);

  UART_tx transmitter(clk, reset, tx_start, s_tick_tx, din, tx_done_flag, tx);
  UART_rx receiver(clk, reset, tx, s_tick_rx, dout, rx_done_flag);

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
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'b11001101;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;


    $finish;
  end
endmodule
