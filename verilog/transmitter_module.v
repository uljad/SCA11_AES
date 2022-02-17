`include "transmitter_buffer.v"
`include "UART_tx.v"

module transmitter_module(
  input clk,
  input reset,
  input [127:0] block_aes_to_UART_tx,
  input write_en,
  output tx,
  output overflow
);

wire [7:0] buffer_to_UART_tx;

transmitter_buffer tx_buffer(clk,
                          reset,
                          block_aes_to_UART_tx,
                          tx_done,
                          write_en,
                          buffer_to_UART_tx,
                          tx_start,
                          overflow);

UART_transmitter transmitter(clk,
                             reset,
                             tx_start,
                             buffer_to_UART_tx,
                             tx_done,
                             tx);

endmodule
