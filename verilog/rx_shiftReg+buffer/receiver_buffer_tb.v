`timescale 1ns / 1ns
`include "receiver_buffer.v"

`include "UART_rx.v"
`include "UART_tx.v"

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

  reg read_en;
  wire [127:0] d_out;
  wire shift_done;

  wire empty;
  wire of;

  wire [127:0] aes_block;

  UART_transmitter transmitter(clk, reset, tx_start, din, tx_done_flag, tx);
  UART_receiver receiver(clk, reset, tx, dout, rx_done_flag);

  receiver_buffer buff(clk, reset, dout, rx_done_flag, read_en, aes_block, empty, of);

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

    read_en <= 1;
    #10;
    read_en <= 0;
    #100;
    read_en <= 1;
    #10;
    read_en <= 0;

    #100;

    $finish;
  end
endmodule
