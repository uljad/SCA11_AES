`include "receiver_module.v"
`include "transmitter_module.v"
`include "fifo_buffer.v"

module wrapper(
  input clk,
  input reset,
  input rx,
  input read_en,
  input [127:0] aes_to_UART,
  input write_en,
  output [127:0] UART_to_aes,
  output rx_overflow,
  output tx_overflow,
  output tx
);

receiver_module receiver(clk,
                         reset,
                         rx,
                         read_en,
                         UART_to_aes,
                         empty,
                         rx_overflow);

transmitter_module transmitter(clk,
                               reset,
                               aes_to_UART,
                               write_en,
                               tx,
                               tx_overflow);

endmodule
