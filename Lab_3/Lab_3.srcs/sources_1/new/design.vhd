--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

--entity adder is
--    generic (n: integer := 6);
--    port(
--        sel:    in std_logic_vector(1 downto 0);
--        a:      in std_logic_vector(n-1 downto 0);
--        b:      in std_logic_vector(n-1 downto 0);
--        r:      out std_logic_vector(n-1 downto 0)
--    );
--end adder;

--architecture dataflow of adder is
--    signal a_long:          unsigned(n downto 0);
--    signal b_long:          unsigned(n downto 0);
--    signal sum_temp:        unsigned(n downto 0); --a_long + b_long
--    signal sub_temp:        unsigned(n downto 0); --a_long + b_complement
--begin
--    a_long          <=      '0' & unsigned(a);
--    b_long          <=      '0' & unsigned(b);
--    sum_temp        <=      a_long + b_long;
--    sub_temp        <=      a_long + (not b_long +1);
    
--    with sel select r <=
--        std_logic_vector(sum_temp(n-1 downto 0)) when "00",
--        "00000" & std_logic(sum_temp(n)) when "01",
--        std_logic_vector(sub_temp(n-1 downto 0)) when "10",
--        "00000" & std_logic(sub_temp(n)) when "11",
--        "000000" when others;
--end dataflow;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder is
    generic (n: integer := 6);
    port (
        a: in std_logic_vector(5 downto 0);
        b: in std_logic_vector(5 downto 0);
        sel: in std_logic_vector(1 downto 0);
        r: out std_logic_vector(5 downto 0)
    );
end entity;

architecture Behavioral of adder is
--    signal notb: unsigned(5 downto 0);
    signal sum: unsigned(6 downto 0);
    signal carry_out: unsigned(5 downto 0);
begin
--    notb <= not unsigned(b);

    process (a, b, sel)
    begin
        case sel is
            when "00" =>
                sum <= ('0' & unsigned(a)) + ('0' & unsigned(b));
            when "01" =>
                sum <= ('0' & unsigned(a)) + ('0' & unsigned(b)); -- prepend 0 to a and b
            when "10" =>
                sum <= ('0' & unsigned(a)) + (not('0' & unsigned(b)) + 1); -- compute two's complement of b
            when "11" =>
                sum <= ('0' & unsigned(a)) + (not('0' & unsigned(b)) + 1); -- prepend 0 to a and two's complement of b
            when others =>
                sum <= "0000000";
        end case;
    end process;

    -- Compute carry_out for sel = "01" and "11"
    carry_out <= "00000" & sum(6) when sel = "01" or sel = "11" else "000000";

    -- Assign output r
    r <= std_logic_vector(sum(5 downto 0)) when sel = "00" or sel = "10" else std_logic_vector(carry_out);

end architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult is
    generic(n: integer := 6);
    port(
        sel:    in std_logic;
        a:      in std_logic_vector(n-1 downto 0);
        b:      in std_logic_vector(n-1 downto 0);
        r:      out std_logic_vector(n-1 downto 0)
    );
end mult;

architecture dataflow of mult is
    signal a_long:          unsigned(n-1 downto 0);
    signal b_long:          unsigned(n-1 downto 0);
    signal temp_mult:       unsigned(2*n-1 downto 0);
begin
--    a_long          <=      (2*n-1 downto n => '0') & unsigned(a);
--    b_long          <=      (2*n-1 downto n => '0') & unsigned(b);

    a_long          <=      unsigned(a);
    b_long          <=      unsigned(b);
    temp_mult       <=      a_long * b_long;
    
    with sel select r <=
        std_logic_vector(temp_mult(n-1 downto 0)) when '0',
        std_logic_vector(temp_mult(2*n-1 downto n)) when '1',
        (others => '0') when others;
end dataflow;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logic_unit is
    generic(n: integer := 6);
    port(
        sel:        in std_logic_vector(1 downto 0);
        a:          in std_logic_vector(n-1 downto 0);
        b:          in std_logic_vector(n-1 downto 0);
        r:          out std_logic_vector(n-1 downto 0)
    );
end logic_unit;

architecture dataflow of logic_unit is
begin
    with sel select r <=
        NOT a when "00",
        a AND b when "01",
        a OR b when "10",
        a XOR b when "11",
        "000000" when others;
end dataflow;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is
    generic(n: integer := 6);
    port(
        sel:        in std_logic_vector(1 downto 0);
        a:          in std_logic_vector(n-1 downto 0);
        b:          in std_logic_vector(n/2-1 downto 0);
        r:          out std_logic_vector(n-1 downto 0)
    );
end shifter;

architecture dataflow of shifter is
    signal a_un:            unsigned(n-1 downto 0);
    signal b_un:            unsigned(n/2-1 downto 0);
    signal a_si:            signed(n-1 downto 0);
    signal left_un:         unsigned(n-1 downto 0);
    signal right_un:        unsigned(n-1 downto 0);
    signal right_si:        signed(n-1 downto 0);
begin
    a_un        <=      unsigned(a);
    b_un        <=      unsigned(b);
    a_si        <=      signed(a);
    left_un     <=      shift_left(a_un, TO_INTEGER(b_un));
    right_un    <=      shift_right(a_un, TO_INTEGER(b_un));
    right_si    <=      shift_right(a_si, TO_INTEGER(b_un));
    
    with sel select r <=
        std_logic_vector(left_un(n-1 downto 0)) when "00" | "01",
        std_logic_vector(right_un(n-1 downto 0)) when "10",
        std_logic_vector(right_si(n-1 downto 0)) when "11",
        (others => '0') when others;
end dataflow;


library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1 is
    generic(n : integer := 6);
    port(
        sel : in std_logic_vector(1 downto 0);
        din0 : in std_logic_vector(n-1 downto 0);
        din1 : in std_logic_vector(n-1 downto 0);
        din2 : in std_logic_vector(n-1 downto 0);
        din3 : in std_logic_vector(n-1 downto 0);
        dout : out std_logic_vector(n-1 downto 0)
        );
end mux_4to1;

architecture dataflow of mux_4to1 is
    begin
        with sel select
            dout <= din0 when "00",
                    din1 when "01",
                    din2 when "10",
                    din3 when others;
end dataflow;