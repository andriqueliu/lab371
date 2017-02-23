library verilog;
use verilog.vl_types.all;
entity transferProcess is
    generic(
        DELAY           : integer := 75000000
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        timerStart      : in     vl_logic;
        timerComplete   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DELAY : constant is 1;
end transferProcess;
