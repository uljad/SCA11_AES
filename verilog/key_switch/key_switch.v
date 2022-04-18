module keySelect(
  input clk,                    // System clock
  input reset,                  // Asynchronous reset
  input [127:0] block,          // input block from rx_shift
  input write_en,               // write enable used to know when to read from rx_shift
  output reg [127:0] pt_block,  // block containing plaintext to be sent to buffer
  output reg [127:0] key_block, // block containing the key (if changed)
  output reg pt_write,          // write enable for fifo register if block is pt
  output reg key_write          // write enable for key register if block is key
);

// state register
reg [1:0] state;
reg [1:0] state_next;

// data register
reg [127:0] block_in;

always @(posedge clk) begin
  if(!reset) begin
    state <= 0;
    state_next <= 0;

    block_in <= 0;

    pt_block <= 0;
    pt_write <= 0;

    key_block <= 0;
    key_write <= 0;
  end

  else begin
    state <= state_next;
    pt_write <= 0;
    key_write <= 0;

    if(state == 0) begin // reading/idle state
      if(write_en) begin
        block_in <= block;
        state_next <= 1;
      end
    end

    if(state == 1) begin  // compare stage
      if(block_in == 128'hDEADBEEFDEADBEEFDEADBEEFDEADBEEF) begin
        state_next <= 2;
      end

      else begin
        pt_block <= block_in;
        pt_write <= 1;
        state_next <= 0;
      end
    end

    if (state == 2) begin // key writing stage
      if(write_en) begin
        key_block <= block;
        key_write <= 1;
        state_next <= 0;
      end
    end
  end
end
endmodule
