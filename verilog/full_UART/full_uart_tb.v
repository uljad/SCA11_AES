`timescale 1ns / 1ns
`include "UART_rx.v"
`include "UART_tx.v"

module Top_tb();
  reg clk;
  reg reset;

  wire [7:0] d_out;
  wire rx_done;

  wire serial_line;

  UART_receiver receiver(clk, reset, serial_line, d_out, rx_done);

  reg tx_start;
  reg [7:0] d_in;
  wire tx_done;

  UART_transmitter transmitter(clk, reset, tx_start, d_in, tx_done, serial_line);

  always @* begin
    #5 clk <= !clk;
  end

  initial begin
    $dumpfile("Top.vcd");
    $dumpvars(0, Top_tb);

    reset <= 1;
    clk <= 0;

    d_in <= 8'hab;
    tx_start <= 1;
    #10;
    tx_start <= 0;

    #10000;

    $finish;
  end

endmodule
