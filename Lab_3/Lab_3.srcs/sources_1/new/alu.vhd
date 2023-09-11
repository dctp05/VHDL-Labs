library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        sel:    in std_logic_vector(3 downto 0);
        a:      in std_logic_vector(5 downto 0);
        b:      in std_logic_vector(5 downto 0);
        r:      out std_logic_vector(5 downto 0)
    );
end alu;

architecture structural of alu is

component adder is
    generic (n: integer);
    port(
        sel:    in std_logic_vector(1 downto 0);
        a:      in std_logic_vector(n-1 downto 0);
        b:      in std_logic_vector(n-1 downto 0);
        r:      out std_logic_vector(n-1 downto 0)
    );
end component;

component mult is
    generic(n: integer);
    port(
        sel:    in std_logic;
        a:      in std_logic_vector(n-1 downto 0);
        b:      in std_logic_vector(n-1 downto 0);
        r:      out std_logic_vector(n-1 downto 0)
    );
end component;

component logic_unit is
    generic(n: integer);
    port(
        sel:        in std_logic_vector(1 downto 0);
        a:          in std_logic_vector(n-1 downto 0);
        b:          in std_logic_vector(n-1 downto 0);
        r:          out std_logic_vector(n-1 downto 0)
    );
end component;

component shifter is
    generic(n: integer);
    port(
        sel:        in std_logic_vector(1 downto 0);
        a:          in std_logic_vector(n-1 downto 0);
        b:          in std_logic_vector(n/2-1 downto 0);
        r:          out std_logic_vector(n-1 downto 0)
    );
end component;

component mux_4to1 is
    generic(n : integer);
    port(
        sel  : in std_logic_vector(1 downto 0);
        din0 : in std_logic_vector(n-1 downto 0);
        din1 : in std_logic_vector(n-1 downto 0);
        din2 : in std_logic_vector(n-1 downto 0);
        din3 : in std_logic_vector(n-1 downto 0);
        dout : out std_logic_vector(n-1 downto 0)
        );
end component;

type array_4of6 is array (0 to 3) of std_logic_vector(5 downto 0);
signal mux_in : array_4of6;

begin

adder_inst :    adder
generic map (n => 6)
port map(
        sel     =>      sel(1 downto 0),
        a       =>      a,
        b       =>      b,
        r       =>      mux_in(0)
);

mult_inst :     mult
generic map (n => 6)
port map(
        sel     =>      sel(0),
        a       =>      a,
        b       =>      b,
        r       =>      mux_in(1)
);

logic_unit_inst :   logic_unit
generic map (n => 6)
port map(
        sel     =>      sel(1 downto 0),
        a       =>      a,
        b       =>      b,
        r       =>      mux_in(2)
);

shifter_inst :      shifter
generic map (n => 6)
port map(
        sel     =>      sel(1 downto 0),
        a       =>      a,
        b       =>      b(2 downto 0),
        r       =>      mux_in(3)
);

mux_inst :      mux_4to1
generic map (n => 6)
port map(
        sel     =>      sel(3 downto 2),
        din0    =>      mux_in(0),
        din1    =>      mux_in(1),
        din2    =>      mux_in(2),
        din3    =>      mux_in(3),
        dout    =>      r
);

end structural;





