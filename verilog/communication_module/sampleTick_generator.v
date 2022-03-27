module sample_ticker(
  input clk,
  input reset,
  output reg s_tick
);

reg [5:0] counter;

always @(posedge clk) begin
  if(!reset) begin
    counter <= 0;
    s_tick <= 0;
  end
  else begin
    counter <= counter + 1;
    s_tick <= 0;
    if(counter == 54) begin // the number in the counter should be set to a particular value
      s_tick <= 1;
      counter <= 0;
    end
  end
end
endmodule

// As per the design in the book "FPGA Prototyping", the receiver should receive
// sampling ticks that are 16x the baud rate, so if the s_tick rate is 9600, the
// receiver should receive sampling ticks at a rate of 153600 or (9600 * 16)
// ticks per second.

// This module is a basic clock divider that receives the system clock and generates
// sample ticks at a rate of 153600 per second. These sampling ticks are not to function
// as the system clock for the receiver, rather they should function as enable signals
