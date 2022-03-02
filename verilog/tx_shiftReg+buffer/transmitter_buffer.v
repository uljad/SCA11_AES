`include "tx_shift.v"
`include "fifo_buffer.v"

module transmitter_buffer(
  input clk,
  input reset,
  input [127:0] block_aes_to_UART_tx,
  input tx_done,
  input write_en,
  output [7:0] byte_shiftReg_to_UART,
  output tx_start,
  output overflow
);

wire [127:0] block_buffer_to_shiftReg;

fifo tx_buffer(clk,
               reset,
               block_aes_to_UART_tx,  // from control block between comm and aes
               write_en,              // also from control block
               read_en,               // from tx_shiftReg
               block_buffer_to_shiftReg,
               empty,
               overflow);

tx_shift tx_shiftReg(clk,
                     reset,
                     block_buffer_to_shiftReg,
                     tx_done,
                     empty,
                     read_en,
                     byte_shiftReg_to_UART,
                     tx_start);

endmodule
