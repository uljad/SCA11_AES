module sample_ticker_tx(
  input clk,
  input reset,
  output reg s_tick
);

reg [7:0] counter;


always @(posedge reset) begin
  counter <= 0;
  s_tick <= 0;
end

always @(posedge clk) begin
  counter <= counter + 1;
  if(counter == 15) begin // the number in the counter should be set to a particular value
    s_tick <= !s_tick;
    counter <= 0;
  end
end

endmodule

// As per the design in the book "FPGA Prototyping", the receiver should receive
// sampling ticks that are 16x the s_tick rate, so if the s_tick rate is 9600, the
// receiver should receive sampling ticks at a rate of 153600 or (9600 * 16)
// ticks per second.

// This module is a basic clock divider that receives the system clock and generates
// sample ticks at a rate of 153600 per second. These sampling ticks are not to function
// as the system clock for the receiver, rather they should function as enable signals
