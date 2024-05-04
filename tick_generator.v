module tick_generator #(
  parameter frequency = 50000
)(
  input              clk,
  input              reset,
  output reg         enable
);

  reg [$clog2(frequency)-1:0] count;

  always @ (posedge clk or negedge reset) begin
    if (!reset) begin
      count <= 0;
    end else begin
      count <= (count < frequency - 1) ? count + 1 : 0;
    end
    enable <= (count == frequency - 1) ? 1'b1 : 1'b0;
  end

endmodule
