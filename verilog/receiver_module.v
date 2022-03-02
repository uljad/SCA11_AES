`include "receiver_buffer.v"
`include "UART_rx.v"

module receiver_module(
  input clk,
  input reset,
  input rx,
  input write_en,
  output [127:0] block_UART_to_aes,
  output empty,
  output overflow
);

wire [7:0] UART_to_buffer;

UART_receiver receiver(clk,
                       reset,
                       rx,
                       UART_to_buffer,
                       rx_done);

receiver_buffer rx_buffer(clk,
                       reset,
                       UART_to_buffer,
                       rx_done,
                       write_en,
                       block_UART_to_aes,
                       empty,
                       overflow);
endmodule
