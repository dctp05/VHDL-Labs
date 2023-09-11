library ieee;
use ieee.std_logic_1164.all;

entity HW3_prob1_tb is
end HW3_prob1_tb;

architecture behavioral of HW3_prob1_tb is

    component controller is
        port(
            clk :   in std_logic;
            rst :   in std_logic;
            a   :   in std_logic;
            b   :   in std_logic;
            x   :   out std_logic;
            y   :   out std_logic;
            z   :   out std_logic
        );
        
    end component;
    
    constant PERIOD : time := 100 ns;

    signal clk :   std_logic;  
    signal rst :   std_logic;  
    signal a   :   std_logic;  
    signal b   :   std_logic;  
    signal x   :   std_logic; 
    signal y   :   std_logic; 
    signal z   :   std_logic;
    
begin
    
    cont_inst: controller
    port map(
        clk => clk,
        rst => rst,
        a   => a,
        b   => b,
        x   => x,
        y   => y,
        z   => z
    );
    
    clk_gen: process
    begin
        clk <= '1';
        wait for PERIOD/2; --wait for 10/2=5 ns
        clk <= '0';
        wait for PERIOD/2;
    end process;
    
    a_gen:  process
    begin
        a <= '1';
        wait for 25 ns;
        a <= '0';
        wait for 50 ns;
        a <= '1';
        wait for 75 ns;
    end process;
    
    tb: process
    begin
        
        rst <= '1';
        b   <= '1';
        
        wait for 50 ns;
        
        rst <= '0';
        b   <= '0';
        
        wait for 100 ns;
        
        b   <= '1';
        
        wait for 75 ns;
        
        b   <= '0';
        
        wait for 50 ns;
        
        b   <= '1';
        
        wait for 75 ns;
        
        b   <= '0';
        
        wait for 100 ns;
        
        b   <= '1';
        
        wait for 60 ns;
        
        b   <= '0';
        
        wait;
    end process;
end behavioral;


library ieee;
use ieee.std_logic_1164.all;

entity HW3_prob3_tb is
end HW3_prob3_tb;

architecture behavioral of HW3_prob3_tb is

    component HW_prob_3 is
        port(
            reset   :   in std_logic;
            clk     :   in std_logic;
            x       :   in std_logic;
            y       :   in std_logic;
            v       :   out std_logic;
            z       :   out std_logic;
            init    :   out std_logic;
            write   :   out std_logic;
            load    :   out std_logic
        );
    end component;

    constant PERIOD : time := 100 ns;
    
    signal reset   :   std_logic;
    signal clk     :   std_logic;
    signal x       :   std_logic;
    signal y       :   std_logic;
    signal v       :   std_logic;
    signal z       :   std_logic;
    signal init    :   std_logic;
    signal write   :   std_logic;
    signal load    :   std_logic;

begin

    cont_inst: HW_prob_3
    port map(
        reset => reset,
        clk   => clk  ,
        x     => x    ,
        y     => y    ,
        v     => v    ,
        z     => z    ,
        init  => init ,
        write => write,
        load  => load
    );
    
    clk_gen: process
    begin
        clk <= '1';
        wait for PERIOD/2; --wait for 10/2=5 ns
        clk <= '0';
        wait for PERIOD/2;
    end process;
    
    tb: process
    begin
    
        reset <= '1';
        x <= '0';
        y <= '0';
        wait for 75 ns;
        
        reset <= '0';
        wait for 25 ns;
        
        wait for 75 ns;
        x <= '1';
        wait for 25 ns;
        
        wait for 75 ns;
        x <= '0';
        wait for 25 ns;
        
        wait for 40 ns;
        y <= '1';
        wait for 10 ns;
        x <= '1';
        wait for 50 ns;
        
        wait for 60 ns;
        y <= '0';
        
        wait;
    end process;
end behavioral;




















