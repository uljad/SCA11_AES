module tx_shift(
  input clk,
  input reset,
  input [127:0] d_in,
  input tx_done,
  input buffer_empty,
  output reg buffer_read,
  output reg [7:0] d_out,
  output reg tx_start
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

    tx_start <= 0;
    buffer_read <= 0;
  end
  else begin
    state <= state_next;
    data <= data_next;
    ctr <= ctr_next;
    tx_start <= 0;
    buffer_read <= 0;

    if(state == 0) begin  // idle state
      if(!buffer_empty) begin
        buffer_read <= 1;
        state_next <= 1;
      end
    end

    if(state == 1) begin  // loading state
      data_next <= d_in;
      state_next <= 2;
    end

    if(state == 2) begin  // start state
      tx_start <= 1;
      data_next <= data << 8;
      ctr_next <= 0;
      state_next <= 3;
    end

    if (state == 3) begin // shift state
      if(ctr == 15) begin
        state_next <= 0;
      end else begin
        if(tx_done) begin
          data_next <= data << 8;
          ctr_next <= ctr + 1;
          tx_start <= 1;
        end
      end
    end

    d_out <= data[127:120];
  end
end
endmodule
