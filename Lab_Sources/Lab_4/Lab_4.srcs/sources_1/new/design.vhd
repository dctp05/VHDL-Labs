library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port(
        a   :   in std_logic;
        b   :   in std_logic;
        cin :   in std_logic;
        sum :   out std_logic;
        cout:   out std_logic
    );
end full_adder;

architecture dataflow of full_adder is
begin
    sum <= (a xor b) xor cin;
    cout <= b when (a xor b) = '0' else cin;
end dataflow;


library ieee;
use ieee.std_logic_1164.all;

entity carry_save_mult is
    generic(n : integer := 8);
    port(
        a   :   in std_logic_vector(n-1 downto 0);
        b   :   in std_logic_vector(n-1 downto 0);
        p   :   out std_logic_vector(2*n-1 downto 0)
    );
end carry_save_mult;

architecture structural of carry_save_mult is
    component full_adder is
        port(
            a   :   in std_logic;
            b   :   in std_logic;
            cin :   in std_logic;
            sum :   out std_logic;
            cout:   out std_logic
        );
    end component;
    
    type arr2d is array (integer range <>) of std_logic_vector(n-1 downto 0);
    signal ab   :   arr2d(0 to n-1);
    
    signal FA_a     :   arr2d(0 to n-2);   
    signal FA_b     :   arr2d(0 to n-2);
    signal FA_cin   :   arr2d(0 to n-2);
    signal FA_sum   :   arr2d(0 to n-2);
    signal FA_cout  :   arr2d(0 to n-2);

begin
    gen_ab_rows: for i in 0 to n-1 generate
        gen_ab_cols: for j in 0 to n-1 generate
            ab(i)(j) <= a(i) and b(j);
        end generate;
    end generate;
    
    gen_FA_rows: for i in 0 to n-2 generate
        gen_FA_cols: for j in 0 to n-1 generate
            FA_inst : full_adder
            port map(
                a   =>  FA_a(i)(j),
                b   =>  FA_b(i)(j),
                cin =>  FA_cin(i)(j),
                sum =>  FA_sum(i)(j),
                cout=>  FA_cout(i)(j)                
            );
        end generate;
    end generate;
    
    FA_a(0)     <=      '0' & ab(0)(n-1 downto 1);
    FA_b(0)     <=      ab(1)(n-1 downto 0);
    FA_cin(0)   <=      ab(2)(n-2 downto 0) & '0';
    
    gen_FA_ins: for i in 1 to n-3 generate
        FA_a(i)     <=      ab(i+1)(n-1) & FA_sum(i-1)(n-1 downto 1);
        FA_b(i)     <=      FA_cout(i-1)(n-1 downto 0);
        FA_cin(i)   <=      ab(i+2)(n-2 downto 0) & '0';
    end generate;
    
    FA_a(n-2)       <=      ab(n-1)(n-1) & FA_sum(n-3)(n-1 downto 1);
    FA_b(n-2)       <=      FA_cout(n-3)(n-1 downto 0);
    FA_cin(n-2)     <=      FA_cout(n-2)(n-2 downto 0) & '0';
    
    p(0)    <=      ab(0)(0);
    
    gen_p_n2: for i in 1 to n-2 generate
        p(i)    <=  FA_sum(i-1)(0);
    end generate;
    
    gen_p_2n2: for i in n-1 to 2*n-2 generate
        p(i)    <=  FA_sum(n-2)(i-n+1);
    end generate;
    
    p(2*n-1)    <=  FA_cout(n-2)(n-1);

end structural;


library ieee;
use ieee.std_logic_1164.all;

entity mult is
    port(
        clk :   in std_logic;
        a   :   in std_logic_vector(7 downto 0);
        b   :   in std_logic_vector(7 downto 0);
        p   :   out std_logic_vector(15 downto 0)
    );
    
end mult;

architecture structural of mult is

    component carry_save_mult is
        generic(n : integer);
        port(
            a   :   in std_logic_vector(n-1 downto 0);
            b   :   in std_logic_vector(n-1 downto 0);
            p   :   out std_logic_vector(2*n-1 downto 0)
        );
    end component;

    signal a_reg  : std_logic_vector(7 downto 0);
    signal b_reg  : std_logic_vector(7 downto 0);
    signal p_s    : std_logic_vector(15 downto 0);
    
begin
    csm_inst: carry_save_mult
    generic map (n => 8)
    port map(
        a   =>  a_reg,
        b   =>  b_reg,
        p   =>  p_s
    );
    
    reg_mult: process(clk)
    begin
        if rising_edge(clk) then
            a_reg <= a;
            b_reg <= b;
            p <= p_s;
        end if;
    end process;

end structural;