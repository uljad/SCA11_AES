module UART_transmitter(
  input clk,
  input reset,
  input tx_start,
  input [7:0] din,
  output tx_done,
  output tx
);


sample_ticker_tx sampleTicker(clk, reset, s_tick);
UART_tx TX(clk,
           reset,
           tx_start,
           s_tick,
           din,
           tx_done,
           tx);

endmodule
