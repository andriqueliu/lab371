library verilog;
use verilog.vl_types.all;
entity tow_testbench is
    generic(
        CLOCK_PERIOD    : integer := 100;
        whichClock      : integer := 15
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLOCK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of whichClock : constant is 1;
end tow_testbench;
