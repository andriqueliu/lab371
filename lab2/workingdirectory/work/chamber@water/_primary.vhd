library verilog;
use verilog.vl_types.all;
entity chamberWater is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        increase        : in     vl_logic;
        decrease        : in     vl_logic;
        rightGood       : out    vl_logic;
        leftGood        : out    vl_logic
    );
end chamberWater;
