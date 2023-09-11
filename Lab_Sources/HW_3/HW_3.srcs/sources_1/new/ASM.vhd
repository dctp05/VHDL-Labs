library ieee;
use ieee.std_logic_1164.all;

entity controller is
    port(
        clk :   in std_logic;
        rst :   in std_logic;
        a   :   in std_logic;
        b   :   in std_logic;
        x   :   out std_logic;
        y   :   out std_logic;
        z   :   out std_logic
    );
    
end controller;

architecture mixed of controller is

    type FSM_state is (S0, S1, S2, S3, S4);
    signal State: FSM_state;
    
begin
    FSM:    process(clk, rst)
    begin
        if(rst = '1') then
            state <= S0;
        elsif rising_edge(clk) then
            case State is
                when S0 =>
                    if a = '1' then
                        State <= S1;
                    else
                        State <= S0;
                    end if;
                when S1 =>
                    State <= S2;
                when S2 =>
                    if a = '1' then
                        State <= S3;
                    else
                        State <= S4;
                    end if;
                when S3 =>
                    if b = '1' then
                        State <= S4;
                    else
                        State <= S2;
                    end if;
                when S4 =>
                    if a = '1' then
                        State <= S1;
                    elsif b = '1' then
                        State <= S3;
                    else
                        State <= S0;
                    end if;
            end case;
        end if;
    end process;
    
    x <= '1' when (State = S1 and a = '0') or 
                  (State = S2 and a = '1') or 
                  (State = S4 and a = '0') else '0';
    y <= '1' when (State = S2) or 
                  (State = S3 and b = '1') or 
                  (State = S4) else '0';
    z <= '1' when (State = S1 and a = '0') or 
                  (State = S2 and a = '0') or 
                  (State = S3 and b = '0') or
                  (State = S4 and a = '0' and b = '1') else '0';
end mixed;


library ieee;
use ieee.std_logic_1164.all;

entity HW_prob_3 is
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
end HW_prob_3;

architecture mixed of HW_prob_3 is

    type ASM_state is (S0, S1, S2, S3, S4);
    signal State: ASM_state;
    
begin
    FSM:    process(clk, reset)
    begin
        if(reset = '1') then
            State <= S0;
        elsif rising_edge(clk) then
            case State is
                when S0 =>
                    if x = '0' then
                        State <= S0;
                    else
                        State <= S1;
                    end if;
                when S1 =>
                    if x = '0' then
                        State <= S1;
                    else
                        State <= S2;
                    end if;
                when S2 =>
                    if y = '1' then
                        State <= S3;
                    else
                        State <= S4;
                    end if;
                when S3 =>
                    if x = '1' then
                        State <= S4;
                    elsif y = '1' then
                        State <= S2;
                    else
                        State <= S1;
                    end if;
                when S4 =>
                    State <= S2;
            end case;
        end if;
    end process;
    
    v       <= '1' when (State = S1 and x = '0') or 
                        (State = S2 and y = '0') else '0';
    z       <= '1' when (State = S3 and x = '0' and y = '0') or 
                        (State = S2) else '0';
    init    <= '1' when State = S0 else '0';
    write   <= '1' when State = S3 else '0';
    load    <= '1' when State = S4 else '0';
end mixed;


library ieee;
use ieee.std_logic_1164.all;

entity HW_prob_4 is
    port(
        rst     :   in std_logic;
        clk     :   in std_logic;
        a       :   in std_logic;
        b       :   in std_logic;
        p       :   out std_logic;
        r       :   out std_logic;
        y       :   out std_logic
    );
end HW_prob_4;

architecture mixed of HW_prob_4 is

    type ASM_state is (S0, S1, S2, S3, S4);
    signal State: ASM_state;
    
begin
    FSM:    process(clk, rst)
    begin
        if rst = '0' then
            State <= S0;
        elsif rising_edge(clk) then
            case State is
                when S0 =>
                    if a = '1' then
                        State <= S1;
                    else
                        State <= S0;
                    end if;
                when S1 =>
                    if b = '0' then
                        State <= S2;
                    else
                        State <= S1;
                    end if;
                when S2 =>
                    if b = '1' then
                        State <= S3;
                    else
                        State <= S2;
                    end if;
                when S3 =>
                    if b = '1' then
                        State <= S4;
                    else
                        State <= S2;
                    end if;
                when S4 =>
                    if b = '1' then
                        State <= S1;
                    elsif a = '1' then
                        State <= S2;
                    else
                        State <= S0;
                    end if;
            end case;
        end if;    
    end process;
    
    p <= '1' when (State = S1) or 
                  (State = S3) else '0';
    r <= '1' when (State = S1 and b = '0') or 
                  (State = S2 and b = '1') or 
                  (State = S3 and b = '1') or 
                  (State = S4 and b = '0') else '0';
    y <= '1' when (State = S4 and b = '0' and a = '1') else '0'; 
end mixed;
                        
                












