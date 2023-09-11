library ieee;
use ieee.std_logic_1164.all;

entity alu_tb is
end alu_tb;

architecture behavioral of alu_tb is
    component alu is
        port(
            sel:    in std_logic_vector(3 downto 0);
            a:      in std_logic_vector(5 downto 0);
            b:      in std_logic_vector(5 downto 0);
            r:      out std_logic_vector(5 downto 0)
        );
    end component;
    
    constant PERIOD : time := 10 ns;
    
--    signal clk:     std_logic;
    signal sel:     std_logic_vector(3 downto 0);
    signal a:       std_logic_vector(5 downto 0);
    signal b:       std_logic_vector(5 downto 0);
    signal r:       std_logic_vector(5 downto 0);

begin

    alu_inst:   alu
    port map(
            sel     =>      sel,
            a       =>      a,
            b       =>      b,
            r       =>      r
    );
    
--    clk_gen: process
--    begin
--        clk <= '0';
--        wait for PERIOD/2;
--        clk <= '1';
--        wait for PERIOD/2;
--    end process;
    
    tb: process
    begin

        sel     <=      "0000"; --adder no carry
        a       <=      "000100"; --set a
        b       <=      "000010"; --set b
        wait for PERIOD;
        
        sel     <=      "0001"; --adder carry
        wait for PERIOD;
        sel     <=      "0010"; --sub 
        wait for PERIOD;
        sel     <=      "0011"; --sub borrow
        wait for PERIOD;
        sel     <=      "0100"; --mult lower 6
        wait for PERIOD;
        sel     <=      "0101"; --mult higher 6
        wait for PERIOD;
        sel     <=      "1000"; --not a
        wait for PERIOD;
        sel     <=      "1001"; --a and b
        wait for PERIOD;
        sel     <=      "1010"; --a or b
        wait for PERIOD;    
        sel     <=      "1011"; --a xor b
        wait for PERIOD;
        sel     <=      "1100"; --a << b
        wait for PERIOD;
        sel     <=      "1110"; --a >> b
        wait for PERIOD;
        sel     <=      "1111"; --a >> b signed
        
        
        wait for PERIOD;
        sel     <=      "0000"; --adder no carry
        a       <=      "110001"; --set a
        b       <=      "110010"; --set b
        wait for PERIOD;
        
        sel     <=      "0001"; --adder carry
        wait for PERIOD;
        sel     <=      "0010"; --sub 
        wait for PERIOD;
        sel     <=      "0011"; --sub borrow
        wait for PERIOD;
        sel     <=      "0100"; --mult lower 6
        wait for PERIOD;
        sel     <=      "0101"; --mult higher 6
        wait for PERIOD;
        sel     <=      "1000"; --not a
        wait for PERIOD;
        sel     <=      "1001"; --a and b
        wait for PERIOD;
        sel     <=      "1010"; --a or b
        wait for PERIOD;    
        sel     <=      "1011"; --a xor b
        wait for PERIOD;
        sel     <=      "1100"; --a << b
        wait for PERIOD;
        sel     <=      "1110"; --a >> b
        wait for PERIOD;
        sel     <=      "1111"; --a >> b signed
        wait for PERIOD;
        
        
        sel     <=      "0000"; --adder no carry
        a       <=      "111111"; --set a
        b       <=      "111111"; --set b
        wait for PERIOD;
        
        sel     <=      "0001"; --adder carry
        wait for PERIOD;
        sel     <=      "0010"; --sub 
        wait for PERIOD;
        sel     <=      "0011"; --sub borrow
        wait for PERIOD;
        sel     <=      "0100"; --mult lower 6
        wait for PERIOD;
        sel     <=      "0101"; --mult higher 6
        wait for PERIOD;
        sel     <=      "1000"; --not a
        wait for PERIOD;
        sel     <=      "1001"; --a and b
        wait for PERIOD;
        sel     <=      "1010"; --a or b
        wait for PERIOD;    
        sel     <=      "1011"; --a xor b
        wait for PERIOD;
        sel     <=      "1100"; --a << b
        wait for PERIOD;
        sel     <=      "1110"; --a >> b
        wait for PERIOD;
        sel     <=      "1111"; --a >> b signed
        wait for PERIOD;        
        sel     <=      "0000"; --adder no carry
        a       <=      "000000"; --set a
        b       <=      "000000"; --set b
        wait for PERIOD;                                                                
        wait;
    end process;
    
end behavioral;




















