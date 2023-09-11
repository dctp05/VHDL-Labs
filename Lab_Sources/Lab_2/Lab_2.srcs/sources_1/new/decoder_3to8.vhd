library ieee;
use ieee.std_logic_1164.all;

entity decoder_3to8 is
    port(
        en : in std_logic;
        din : in std_logic_vector(2 downto 0);
        dout : out std_logic_vector(7 downto 0)
    );
end decoder_3to8;

architecture dataflow of decoder_3to8 is
    signal en_din : std_logic_vector(3 downto 0);
begin
    en_din <= en & din;
    with en_din select
        dout <= "00000001" when "1000",
                "00000010" when "1001",
                "00000100" when "1010",
                "00001000" when "1011",
                "00010000" when "1100",
                "00100000" when "1101",
                "01000000" when "1110",
                "10000000" when "1111",
                "00000000" when others;
end dataflow;