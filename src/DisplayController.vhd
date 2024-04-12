library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity DisplayController is
   port (
       --output from the Decoder
       DispVal : in STD_LOGIC_VECTOR (6 downto 0);
       --controls which digit to display
       segOut : out STD_LOGIC_VECTOR (6 downto 0));
end DisplayController;

architecture Behavioral of DisplayController is
begin
 -- only display the leftmost digit
  with DispVal select
    segOut <=  "1111110" when "0000000", -- 0
               "0110000" when "0000001", -- 1
               "1101101" when "0000010", -- 2
               "1111001" when "0000011", -- 3
               "0110011" when "0000100", -- 4
               "1011011" when "0000101", -- 5
               "1011111" when "0000110", -- 6
               "1110000" when "0000111", -- 7
               "1111111" when "0001000", -- 8
               "1111011" when "0001001", -- 9
               "1110111" when "0001010", -- A
               "0011111" when "0001011", -- b
               "1001110" when "0001100", -- C
               "0111101" when "0001101", -- d
               "1001111" when "0001110", -- E
               "1000111" when "0001111", -- F
               "0000000" when others;


end Behavioral;
