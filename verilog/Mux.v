module Mux #(parameter WIDTH=32)(
    input [WIDTH - 1 : 0] in_0,
    input [WIDTH - 1 : 0] in_1,
    input control,
    output [WIDTH - 1 : 0] out
    );

	assign out = control ? in_1 : in_0;

endmodule
