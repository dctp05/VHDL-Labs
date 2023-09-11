library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;

entity mult_tb is
end mult_tb;

architecture behavioral of mult_tb is
    file mult_file : text open read_mode is "mult8x8.dat";
    
    constant PERIOD : time := 10 ns;
    
    component mult is
        port(
            clk :   in std_logic;
            a   :   in std_logic_vector(7 downto 0);
            b   :   in std_logic_vector(7 downto 0);
            p   :   out std_logic_vector(15 downto 0)
        );
        
    end component;
    
    signal clk  :   std_logic;
    signal a    :   std_logic_vector(7 downto 0); 
    signal b    :   std_logic_vector(7 downto 0); 
    signal p    :   std_logic_vector(15 downto 0);

begin
    
    mult_tb_inst : mult
    port map(
        clk => clk,
        a   => a,
        b   => b,
        p   => p
    );
    
    clk_gen: process
    begin
        clk <= '0';
        wait for PERIOD/2;
        clk <= '1';
        wait for PERIOD/2;
    end process;
    
    tb: process
        variable cur_line   : integer := 1;
        variable v_line     : line;
        variable v_space    : character;
        variable v_a        : std_logic_vector(7 downto 0);
        variable v_b        : std_logic_vector(7 downto 0);
        variable v_p_exp    : std_logic_vector(15 downto 0);
    begin
        while not endfile(mult_file) loop
            readline(mult_file, v_line);
            hread(v_line, v_a);
            read(v_line, v_space);
            hread(v_line, v_b);
            read(v_line, v_space);
            hread(v_line, v_p_exp);
                   
            a <= v_a;
            b <= v_b;
            
            wait for 2*PERIOD;
            report "v_a = " & integer'image(TO_INTEGER(unsigned(v_a))) &
                   " | v_b =  " & integer'image(TO_INTEGER(unsigned(v_b))) &
                   " | p = " & integer'image(TO_INTEGER(unsigned(p))) &
                   " | v_p_exp = " & integer'image(TO_INTEGER(unsigned(v_p_exp)));

            assert p = v_p_exp
                report "Failure" severity failure;
        
        end loop;
        
        report "Simulation complete!";
        wait;
    end process;
    
end behavioral;
