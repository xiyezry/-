library verilog;
use verilog.vl_types.all;
entity Shifter is
    port(
        orignial        : in     vl_logic_vector(31 downto 0);
        index           : in     vl_logic_vector(4 downto 0);
        right           : in     vl_logic;
        arith           : in     vl_logic;
        result          : out    vl_logic_vector(31 downto 0)
    );
end Shifter;
