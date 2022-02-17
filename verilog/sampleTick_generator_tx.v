module sample_ticker_tx(
  input clk,
  input reset,
  output reg baud
);

reg [7:0] counter;


always @(posedge reset) begin
  counter <= 0;
  baud <= 0;
end

always @(posedge clk) begin
  counter <= counter + 1;
  if(counter == 15) begin // the number in the counter should be set to a particular value
    baud <= !baud;
    counter <= 0;
  end
end

endmodule

// As per the design in the book "FPGA Prototyping", the receiver should receive
// sampling ticks that are 16x the baud rate, so if the baud rate is 9600, the
// receiver should receive sampling ticks at a rate of 153600 or (9600 * 16)
// ticks per second.

// This module is a basic clock divider that receives the system clock and generates
// sample ticks at a rate of 153600 per second. These sampling ticks are not to function
// as the system clock for the receiver, rather they should function as enable signals
