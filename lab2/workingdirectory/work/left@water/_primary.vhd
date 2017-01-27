library verilog;
use verilog.vl_types.all;
entity leftWater is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        gateL           : in     vl_logic;
        waterLevelsGood : in     vl_logic;
        gondInChamber   : in     vl_logic;
        gondInWater     : out    vl_logic
    );
end leftWater;
