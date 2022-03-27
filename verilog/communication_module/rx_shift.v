module rx_shift(
  input clk,                // system clock
  input reset,              // Asynchronous reset
  input [7:0] d_in,          // 8 bits from UART reciever
  input rx_done,            // from UART reciever, used as shift in the 8 incident bits
  output reg [127:0] d_out,  // output block, goes to rx_buffer
  output reg shift_done     // used as a write_en signal to rx_buffer
);

reg [1:0] state;
reg [1:0] state_next;

reg [127:0] data;
reg [127:0] data_next;

reg [3:0] ctr;
reg [3:0] ctr_next;

always @(posedge clk) begin
  if(!reset) begin
    state <= 0;
    state_next <= 0;

    data <= 0;
    data_next <= 0;

    ctr <= 0;
    ctr_next <= 0;

    d_out <= 0;
    shift_done <= 0;
  end
  else begin
    state <= state_next;
    data <= data_next;
    ctr <= ctr_next;
    shift_done <= 0;

    if(state == 0) begin  // idle state
      if(rx_done) begin   // waits on rx_done signal
        state_next <= 1;
        ctr_next <= 0;
        data_next <= d_in; // loads byte into register and goes to next state
      end
    end

    if(state == 1) begin
      if(ctr == 15) begin               // once 16 bytes loaded
        state_next <= 2;
      end else begin
        if(rx_done) begin
          data_next <= data << 8 | d_in; // shifts bytes and appends new one
          ctr_next <= ctr + 1;          // increments counter
        end
      end
    end

    if(state == 2) begin
      shift_done <= 1;                // done signal is asserted and
      state_next <= 0;                // FSM returns to idle state
    end

    d_out <= data;
  end
end
endmodule
