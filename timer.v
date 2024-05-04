
module timer#(
  parameter green_timeout = 20, // 20 s
  parameter yellow_timeout  = 5 // 5 s
)(
    input a_second,
    input rst_n,
    input start,

    output [5:0] green_time,
    output [5:0] yellow_time
);

reg [$clog2(green_timeout)-1:0] counter;

always @(a_second or start or negedge rst_n) begin
    if(!rst_n )
        counter = 0;
    else begin 
        if(start) counter = 1;
        else 
        counter = counter + 1; // countT khi bang T-1 thi quaylai gia tri 0 de dem 
    end
end
assign    green_time = (counter == green_timeout - 1);
assign    yellow_time = (counter == yellow_timeout - 1);
endmodule