module tx_buff(
  input clk,                // System clock
  input [7:0] din,          // Input data from UART_receivers
  input ready,              // rx_done_flag from UART_receiver
  input reset,              // Asynchronous reset
  input read_en,            // Read enable to read next word from buffer
  output reg [127:0] dout,  // Data out from buffer, 128 bits = size of block for AES
  output empty,             // Empty flag is asserted when buffer has no readable data
  output reg overflow       // Overflow flag is asserted when buffer has no more space
);


endmodule
