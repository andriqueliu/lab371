library verilog;
use verilog.vl_types.all;
entity rightWater is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        gateR           : in     vl_logic;
        waterLevelsGood : in     vl_logic;
        gondInChamber   : in     vl_logic;
        gondInWater     : out    vl_logic
    );
end rightWater;
