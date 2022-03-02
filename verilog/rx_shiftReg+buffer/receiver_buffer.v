`include "rx_shift.v"
`include "fifo_buffer.v"

module receiver_buffer(
  input clk,
  input reset,
  input [7:0] byte_UART_rx_to_shiftReg,
  input rx_done,
  input read_en,
  output [127:0] block_buffer_to_aes,
  output empty,
  output overflow
);

wire [127:0] block_shiftReg_to_buffer;

rx_shift rx_shiftReg(clk,
                     reset,
                     byte_UART_rx_to_shiftReg,
                     rx_done,
                     block_shiftReg_to_buffer,
                     shift_done);

fifo rx_buffer(clk,
               reset,
               block_shiftReg_to_buffer,
               shift_done,
               read_en,
               block_buffer_to_aes,
               empty,
               overflow);


endmodule
