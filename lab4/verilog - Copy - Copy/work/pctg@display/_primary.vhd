library verilog;
use verilog.vl_types.all;
entity pctgDisplay is
    port(
        HEX5            : out    vl_logic_vector(6 downto 0);
        address         : in     integer
    );
end pctgDisplay;
