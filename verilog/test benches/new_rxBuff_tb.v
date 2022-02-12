`timescale 1ns / 1ns
`include "rx_shift.v"
`include "rx_buffer_2.0.v"

`include "UART_transmitter.v"
`include "UART_receiver.v"

`include "baudGenerator_tx.v"
`include "baudGenerator_rx.v"

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

  reg re;
  wire [127:0] d_out;
  wire shift_done;

  wire empty;
  wire of;

  wire [127:0] aes_block;

  baud_tx transmit_sampler(clk, reset, s_tick_tx);
  baud_rx receive_sampler(clk, reset, s_tick_rx);

  UART_tx transmitter(clk, reset, tx_start, s_tick_tx, din, tx_done_flag, tx);
  UART_rx receiver(clk, reset, tx, s_tick_rx, dout, rx_done_flag);

  rx_shift shifter(clk, reset, dout, rx_done_flag, d_out, shift_done);
  rx_buff buffer(clk, reset, d_out, shift_done, re, aes_block, empty, of);

  always @* begin
    #5 clk <= !clk;
  end

  initial begin
    $dumpfile("Top.vcd");
    $dumpvars(0, Top_tb);

    reset <= 1; // reset everything
    reset <= 0;
    clk <= 0;   // start clock

    din <= 8'h00;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h11;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h22;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h33;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h44;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h55;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h66;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h77;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h88;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h99;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hAA;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hBB;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hCC;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hDD;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hEE;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hFF;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hFF;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hEE;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hDD;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hCC;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hBB;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'hAA;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h99;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h88;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h77;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h66;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h55;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h44;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h33;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h22;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h11;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    din <= 8'h00;
    tx_start <= 1;
    #10;
    tx_start <= 0;
    #10000;

    re <= 1;
    #10;
    re <= 0;
    #1000;

    re <= 1;
    #10;
    re <= 0;
    #1000;

    re <= 1;
    #10;
    re <= 0;
    #10000;

    $finish;
  end
endmodule
