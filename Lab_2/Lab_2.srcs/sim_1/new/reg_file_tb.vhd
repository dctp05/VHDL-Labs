library ieee;
use ieee.std_logic_1164.all;

entity reg_file_tb is
end reg_file_tb;

architecture behavioral of reg_file_tb is
    component reg_file is

        port(
            clk, rst, we: in std_logic;
            addr : in std_logic_vector(2 downto 0);
            din: in std_logic_vector(3 downto 0);
            dout: out std_logic_vector(3 downto 0)
            );
    end component;
    
    constant PERIOD : time := 10 ns;
    
    signal clk : std_logic;
    signal rst : std_logic;
    signal we  : std_logic;
    signal addr: std_logic_vector(2 downto 0);
    signal din : std_logic_vector(3 downto 0);
    signal dout: std_logic_vector(3 downto 0);

begin

    reg_file_inst: reg_file
    port map(
        clk     =>   clk ,
        rst     =>   rst ,
        we      =>   we  ,
        addr    =>   addr,
        din     =>   din ,
        dout    =>   dout
    );
    
    clk_gen: process
    begin
        clk <= '0';
        wait for PERIOD/2; --wait for 10/2=5 ns
        clk <= '1';
        wait for PERIOD/2;
    end process;
    
    tb: process
    begin
    
        --disable reset
        rst <= '1';
        
        --Write to registers
        we <= '1';
        
        addr <= "000";
        din <= "0111";
        wait for PERIOD;
        
        addr <= "001";
        din <= "1101";
        wait for PERIOD;
        
        addr <= "010";
        din <= "1001";
        wait for PERIOD;
        
        addr <= "011";
        din <= "1010";
        wait for PERIOD;
        
        addr <= "100";
        din <= "0001";
        wait for PERIOD;
        
        addr <= "101";
        din <= "1101";
        wait for PERIOD;
        
        addr <= "110";
        din <= "1111";
        wait for PERIOD;
        
        addr <= "111";
        din <= "0100";
        wait for PERIOD;
        
        --Read the registers
        we <= '0';
        addr <= "000";
        wait for PERIOD;
        
        addr <= "001";
        wait for PERIOD;
        
        addr <= "010";
        wait for PERIOD;
        
        addr <= "011";
        wait for PERIOD;
        
        addr <= "100";
        wait for PERIOD;
        
        addr <= "101";
        wait for PERIOD;
        
        addr <= "110";
        wait for PERIOD;
        
        addr <= "111";
        wait for PERIOD;
        
        --Reset
        rst <='0';
        wait for 1 ns;
        rst <='1';
        
        --Read the registers
        addr <= "000";
        wait for PERIOD;
        
        addr <= "001";
        wait for PERIOD;
        
        addr <= "010";
        wait for PERIOD;
        
        addr <= "011";
        wait for PERIOD;
        
        addr <= "100";
        wait for PERIOD;
        
        addr <= "101";
        wait for PERIOD;
        
        addr <= "110";
        wait for PERIOD;
        
        addr <= "111";
        wait for PERIOD;
        wait;
        
    end process;
    
end behavioral;



















