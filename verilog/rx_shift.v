module rx_shift(
  input clk,
  input reset,
  input [7:0] din,
  input rx_done,
  output reg [127:0] dout,
  output reg shift_done
);

reg state;
reg state_next;

reg [127:0] data;
reg [127:0] data_next;

reg [3:0] ctr;
reg [3:0] ctr_next;

always @(reset) begin
  state <= 0;
  state_next <= 0;

  data <= 0;
  data_next <= 0;

  ctr <= 0;
  ctr_next <= 0;

  dout <= 0;
  shift_done <= 0;
end

always @(posedge clk) begin
  state <= state_next;
  data <= data_next;
  ctr <= ctr_next;
  shift_done <= 0;

  if(state == 0) begin  // idle state
    if(rx_done) begin   // waits on rx_done signal
      state_next <= 1;
      ctr_next <= 0;
      data_next <= din; // loads byte into register and goes to next state
    end
  end

  if(state == 1) begin
    if(ctr == 15) begin               // once 16 bytes loaded
      shift_done <= 1;                // done signal is asserted and
      state_next <= 0;                // FSM returns to idle state
    end else begin
      if(rx_done) begin
        data_next <= data << 8 | din; // shifts bytes and appends new one
        ctr_next <= ctr + 1;          // increments counter
      end
    end
  end

  dout <= data;
end
endmodule
