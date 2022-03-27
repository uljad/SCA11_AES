`include "fifo_buffer.v"
`include "rx_shift.v"
`include "tx_shift.v"
`include "UART_receiver.v"
`include "UART_transmitter.v"
`include "sampleTick_generator.v"
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

  sample_ticker s_tick_generator(
    .clk(clk),
    .reset(reset),
    .s_tick(s_tick)
  );

  wire [7:0] rx_to_shiftReg;

  UART_rx receiver(
    .clk(clk),
    .reset(reset),
    .rx(rx),
    .s_tick(s_tick),
    .d_out(rx_to_shiftReg),
    .rx_done_flag(rx_done)
  );

  wire [127:0] rx_shiftReg_to_buffer;

  rx_shift rx_shifter(
    .clk(clk),
    .reset(reset),
    .d_in(rx_to_shiftReg),
    .rx_done(rx_done),
    .d_out(rx_shiftReg_to_buffer),
    .shift_done(rx_write_en)
  );

  wire [127:0] rxBuffer_to_CB;

  fifo rx_buffer(
    .clk(clk),
    .reset(reset),
    .d_in(rx_shiftReg_to_buffer),
    .write_en(rx_write_en),
    .read_en(rx_read_en),
    .d_out(rxBuffer_to_CB),
    .empty(rx_empty),
    .overflow(rx_overflow)
  );

  wire [127:0] ct_CB_to_txBuffer;

  control_block CB(
    .clk(clk),
    .reset(reset),
    .pt(rxBuffer_to_CB),
    .rx_empty(rx_empty),
    .rx_read(rx_read_en),
    .tx_overflow(tx_overflow),
    .tx_write(tx_write_en),
    .ct(ct_CB_to_txBuffer),
    .aes_ready(aes_ready),
    .aes_start(aes_start),
    .pt_to_aes(pt_to_aes),
    .ct_from_aes(ct_from_aes)
  );

  wire [127:0] txBuffer_to_shiftReg;

  fifo tx_buffer(
    .clk(clk),
    .reset(reset),
    .d_in(ct_CB_to_txBuffer),
    .write_en(tx_write_en),
    .read_en(tx_read_en),
    .d_out(txBuffer_to_shiftReg),
    .empty(tx_empty),
    .overflow(tx_overflow)
  );

  wire [7:0] shiftReg_to_tx;

  tx_shift tx_shifter(
    .clk(clk),
    .reset(reset),
    .d_in(txBuffer_to_shiftReg),
    .tx_done(tx_done),
    .buffer_empty(tx_empty),
    .buffer_read(tx_read_en),
    .d_out(shiftReg_to_tx),
    .tx_start(tx_start)
  );

  UART_tx transmitter(
    .clk(clk),
    .reset(reset),
    .tx_start(tx_start),
    .d_in(shiftReg_to_tx),
    .s_tick(s_tick),
    .tx_done_flag(tx_done),
    .tx(tx)
  );

endmodule
