`include "fifo_buffer.v"
`include "rx_shift.v"
`include "tx_shift.v"
`include "UART_receiver.v"
`include "UART_transmitter.v"
`include "UART_rx.v"
`include "UART_tx.v"
`include "sampleTick_generator_rx.v"
`include "sampleTick_generator_tx.v"
`include "control_block.v"

module comm(
  // board side
  input clk,
  input reset,

  // computer side
  input rx,
  output tx,

  // aes side
  input aes_ready,          // shows us when aes module is idle OR done with previous encryption operation
  output aes_start,         // trigger to start encryption
  output [127:0] pt_to_aes, // plaintext sent to aes
  input [127:0] ct_from_aes // cipher text we get back from aes
);

  wire [7:0] rx_to_shiftReg;

  UART_receiver receiver(clk, reset, rx, rx_to_shiftReg, rx_done);

  wire [127:0] rx_shiftReg_to_buffer;

  rx_shift rx_shifter(clk, reset, rx_to_shiftReg, rx_done, rx_shiftReg_to_buffer, rx_write_en);

  wire [127:0] rxBuffer_to_CB;

  fifo rx_buffer(clk, reset, rx_shiftReg_to_buffer, rx_write_en, rx_read_en, rxBuffer_to_CB, rx_empty, rx_overflow);

  wire [127:0] ct_CB_to_txBuffer;

  control_block CB(clk, reset, rxBuffer_to_CB, rx_empty, rx_read_en, tx_overflow, tx_write_en, ct_CB_to_txBuffer, aes_ready, aes_start, pt_to_aes, ct_from_aes);

  wire [127:0] txBuffer_to_shiftReg;

  fifo tx_buffer(clk, reset, ct_CB_to_txBuffer, tx_write_en, tx_read_en, txBuffer_to_shiftReg, tx_empty, tx_overflow);

  wire [7:0] shiftReg_to_tx;

  tx_shift tx_shifter(clk, reset, txBuffer_to_shiftReg, tx_done, tx_empty, tx_read_en, shiftReg_to_tx, tx_start);

  UART_transmitter transmitter(clk, reset, tx_start, shiftReg_to_tx, tx_done, tx);

endmodule
