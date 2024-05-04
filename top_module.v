module top_module#(
    parameter CLK_FREQ = 50000,
    parameter green_timeout = 20,
    parameter yellow_timeout  = 10
)(
    input clk,
    input rst_n,
    input sensor ,
    output [2:0] light_r,
    output [2:0] light_h
);

 wire  a_second,enable_h,enable_n,start_h,start_n,start;
 wire [5:0] green_time;
 wire [5:0] yellow_time;


 tick_generator #(
    .frequency(CLK_FREQ)
 ) tick (
    .clk(clk),
    .reset(rst_n),
    .enable(a_second)
 );

 timer #(
    .green_timeout(green_timeout),
    .yellow_timeout(yellow_timeout)
 )time1 (
    .rst_n(rst_n),
    .a_second(a_second),
    .start(start),
    .green_time(green_time),
    .yellow_time(yellow_time)
 );

 highway_fsm highway(
    .clk(clk),
    .rst_n(rst_n),
    .car(sensor),
    .green_time(green_time),
    .yellow_time(yellow_time),
    .enable_h(enable_h),

    .enable_n(enable_n),
    .start_h(start_h),
    .light_h(light_h)
 );

  countryroad_fsm country (
    .clk(clk),
    .rst_n(rst_n),
    .car(sensor),
    .green_time(green_time),
    .yellow_time(yellow_time),
    .enable_n(enable_n),

    .enable_h(enable_h),
    .start_n(start_n),
    .light_r(light_r)
 );

   assign start = start_h | start_n;
   
endmodule

