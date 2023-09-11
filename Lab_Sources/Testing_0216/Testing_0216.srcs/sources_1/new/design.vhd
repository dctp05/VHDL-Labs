library ieee;
use ieee.std_logic_1164.all;

entity fulladd is
    port(
        x: in std_logic;
        y: in std_logic;
        cin: in std_logic;
        s: out std_logic;
        cout: out std_logic
        );
end fulladd;

architecture fulladd_dataflow of fulladd is
begin
    s <= x XOR y XOR cin;
    cout <= (x AND y) OR (cin AND x) OR (cin AND y);
end fulladd_dataflow;


library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
    port(
        w0, w1, s : std_logic;
        f: out std_logic
        );
end mux2to1;

architecture dataflow of mux2to1 is
begin
    f <= w0 when s='0' else w1;
end dataflow;

library ieee;
use ieee.std_logic_1164.all;

entity mux_cascade is
    port(
        w1, w2, w3: in std_logic;
        s1, s2: in std_logic;
        f: out std_logic
        );
end mux_cascade;

architecture dataflow of mux_cascade is
begin
    f <= w1 when s1='1' else
         w2 when s2='1' else
         w3;
end dataflow;


library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
    port(
        w0, w1, w2, w3 : in std_logic;
        s : in std_logic_vector(1 downto 0);
        f : out std_logic
        );
end mux4to1;

architecture dataflow of mux4to1 is
begin
    with s select
        f <= w0 when "00",
             w1 when "01",
             w2 when "10",
             w3 when others;
end dataflow;


library ieee;
use ieee.std_logic_1164.all;

entity dec2to4 is
    port(
        w : in std_logic_vector(1 downto 0);
        En : in std_logic;
        y : out std_logic_vector(3 downto 0)
        );
end dec2to4;

architecture dataflow of dec2to4 is
    signal Enw : std_logic_vector(2 downto 0);
begin
    Enw <= En & w;
    with Enw select
        y <= "0001" when "100",
             "0010" when "101",
             "0100" when "110",
             "1000" when "111",
             "0000" when others;
end dataflow;


library ieee;
use ieee.std_logic_1164.all;

entity priority is
    port(
        w : in std_logic_vector(3 downto 0);
        y : out std_logic_vector(1 downto 0);
        z : out std_logic
        );
end priority;

architecture dataflow of priority is
begin
    y <= "11" when w(3)='1' else
         "10" when w(2)='1' else
         "01" when w(1)='1' else
         "00";
    z <= '0' when w = "0000" else '1';
end dataflow;


library ieee;
use ieee.std_logic_1164.all;

entity bcdtoseg7 is
    port(
        bcd : in std_logic_vector(3 downto 0);
        leds : out std_logic_vector(1 to 7)
        );
end bcdtoseg7;

architecture dataflow of bcdtoseg7 is
begin
    with bcd select
               --abcdefg
        leds <= "1111110" when "0000",
                "0110000" when "0001",
                "1101101" when "0010",
                "1111001" when "0011",
                "0110011" when "0100",
                "1011011" when "0101",
                "1011111" when "0110",
                "1110000" when "0111",
                "1111111" when "1000",
                "1111011" when "1001",
                "-------" when others;
end dataflow;


library ieee;
use ieee.std_logic_1164.all;

entity dlatch is
    port(
        d, clock : in std_logic;
        q : out std_logic
        );
end dlatch;

architecture behavioral of dlatch is
begin
    process(d, clock)
    begin
        if clock='1' then
            q <= d;
        end if;
    end process;
end behavioral;


library ieee;
use ieee.std_logic_1164.all;

entity flipflop is
    port(
        d, clock : in std_logic;
        q : out std_logic
        );
end flipflop;

architecture behavioral of flipflop is
begin
    process(clock)
    begin
        if clock'event and clock='1' then
            q <= d;
        end if;
    end process;
end behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity upcount is
    generic(n: integer:=4);
    port(clock, resetn, e : in std_logic;
         q : out std_logic_vector(n-1 downto 0)
         );
end upcount;

architecture behavior of upcount is
    signal count : std_logic_vector(n-1 downto 0);
begin
    process(clock, resetn)
    begin
        if resetn='0' then
            count <= (others => '0');
        elsif(clock'event and clock = '1') then
            if e='1' then
                count <= count + 1;
            else
                count <= count;
            end if;
        end if;
     end process;
     q <= count;
end behavior;


library ieee;
use ieee.std_logic_1164.all;

entity startrun is
    port(
        start, stop, clock : in std_logic;
        run : out std_logic
        );
end startrun;

architecture behavioral of startrun is
begin
    process(clock)
    begin
        if clock'event and clock='1' then
            if start = '1' then
                run <= '1';
            elsif stop = '1' then
                run <= '0';
            end if;
        end if;
    end process;
end behavioral;













        