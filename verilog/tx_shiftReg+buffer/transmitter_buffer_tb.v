`timescale 1ns / 1ns
`include "transmitter_buffer.v"

`include "UART_tx.v"

module Top_tb();
  reg clk;
  reg reset;


  reg [127:0] block_aes_to_tx_buffer;
  wire [7:0] to_uart_tx;
  reg write_en;

  UART_transmitter transmitter(clk, reset, tx_start, to_uart_tx, tx_done, tx);
  transmitter_buffer buffer(clk, reset, block_aes_to_tx_buffer, tx_done, write_en, to_uart_tx, tx_start, overflow);

  always @* begin
    #5 clk <= !clk;
  end

  initial begin
    $dumpfile("Top.vcd");
    $dumpvars(0, Top_tb);

    reset <= 1; // reset everything
    reset <= 0;
    clk <= 0;   // start clock

    block_aes_to_tx_buffer <= 128'h00112233445566778899aabbccddeeff;
    write_en <= 1;
    #10;
    write_en <= 0;

    #111000;

    $finish;
  end
endmodule
