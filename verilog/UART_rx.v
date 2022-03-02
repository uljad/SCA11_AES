`include "UART_receiver.v"
`include "sampleTick_generator_rx.v"

module UART_receiver(
  input clk,
  input reset,
  input rx,
  output [7:0] d_out,
  output rx_done
);


sample_ticker_rx sampleTicker(clk, reset, s_tick);
UART_rx RX(clk,
           reset,
           rx,
           s_tick,
           d_out,
           rx_done);

endmodule
