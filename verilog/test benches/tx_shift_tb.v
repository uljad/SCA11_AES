`timescale 1ns / 1ns
`include "tx_shift.v"
`include "fifo_buffer.v"
`include "UART_transmitter.v"
`include "baudGenerator_tx.v"

module Top_tb();
  reg clk;
  reg reset;

  reg [127:0] din;
  reg ready;
  wire read_en;

  wire [127:0] buff_out;
  wire empty;
  wire overflow;

  wire tx_done;
  wire [7:0] tx_in;
  wire shift_done;
  wire tx_start;

  wire s_tick;
  wire serial;

  buffer fifo(clk, reset, din, ready, read_en, buff_out, empty, overflow);
  tx_shift shifter(clk, reset, buff_out, tx_done, empty, read_en, tx_in, shift_done, tx_start);
  UART_tx tx(clk, reset, tx_start, s_tick, tx_in, tx_done, serial);
  baud_tx baudGen(clk, reset, s_tick);

  always @* begin
    #5 clk <= !clk;
  end

  initial begin
    $dumpfile("Top.vcd");
    $dumpvars(0, Top_tb);

    reset <= 1; // reset everything
    reset <= 0;
    clk <= 0;   // start clock

    #10;

    din <= 128'hAA112233445566778899AABBCCDDEEFF;
    ready <= 1;
    #10;
    ready <= 0;

    #10000000;


    $finish;
  end
endmodule
