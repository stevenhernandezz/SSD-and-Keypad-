library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity decoder is
   port (
       clk : in STD_LOGIC;
       rst: in std_logic;
       Row : in STD_LOGIC_VECTOR (3 downto 0);
       Col : out STD_LOGIC_VECTOR (3 downto 0);
       DecodeOut : out STD_LOGIC_VECTOR (6 downto 0);
       is_a_key_pressed: out std_logic
       );
end decoder;

architecture Behavioral of decoder is

   signal sclk : STD_LOGIC_VECTOR(19 downto 0);
   signal decode_reg: std_logic_vector(6 downto 0);
   signal is_a_key_pressed_reg: std_logic;
begin
   process (clk, rst)
   begin
       if rst = '1' then
           decode_reg <= (others => '0');
           is_a_key_pressed_reg <= '0';
       elsif clk'event and clk = '1' then
           -- 1ms
           if sclk = 100000 then
               --C1
               Col <= "0111";
               sclk <= sclk + 1;
            -- check row pins
           elsif sclk = 100008 then
               --R1
               if Row = "0111" then
                   decode_reg <= "0000001"; --1
                   is_a_key_pressed_reg <= '1';
                   --R2
               elsif Row = "1011" then
                   decode_reg <= "0001000"; --4
                   is_a_key_pressed_reg <= '1';
                   --R3
               elsif Row = "1101" then
                   decode_reg <= "0011111"; --7
                   is_a_key_pressed_reg <= '1';
                   --R4
               elsif Row = "1110" then
                   decode_reg <= "0000000"; --0
                   is_a_key_pressed_reg <= '1';
               else
                   decode_reg <= decode_reg;
                   is_a_key_pressed_reg <= '0';
               end if;
               sclk <= sclk + 1;
                elsif sclk = 200000 then
               --C2
               Col <= "1011";
               sclk <= sclk + 1;
               -- check row pins
                elsif sclk = 200008 then
               --R1
               if Row = "0111" then
                   decode_reg <= "0000010"; --2
                   is_a_key_pressed_reg <= '1';
                   --R2
               elsif Row = "1011" then
                   decode_reg <= "0000101"; --5
                   is_a_key_pressed_reg <= '1';
                   --R3
               elsif Row = "1101" then
                   decode_reg <= "0001000"; --8
                   is_a_key_pressed_reg <= '1';
                   --R4
               elsif Row = "1110" then
                   decode_reg <= "0001111"; --F
                   is_a_key_pressed_reg <= '1';
               else
                   decode_reg <= decode_reg;
                   is_a_key_pressed_reg <= '0';
               end if;
               sclk <= sclk + 1;
                  elsif sclk = 300000 then
               --C3
               Col <= "1101";
               sclk <= sclk + 1;
               -- check row pins
                elsif sclk = 300008 then
               --R1
               if Row = "0111" then
                   decode_reg <= "0000011"; --3  
                   is_a_key_pressed_reg <= '1';
                   --R2
               elsif Row = "1011" then
                   decode_reg <= "0000110"; --6
                   is_a_key_pressed_reg <= '1';
                   --R3
               elsif Row = "1101" then
                   decode_reg <= "0001001"; --9
                   is_a_key_pressed_reg <= '1';
                   --R4
               elsif Row = "1110" then
                   decode_reg <= "0001110"; --E
                   is_a_key_pressed_reg <= '1';
               else
                   decode_reg <= decode_reg;
                   is_a_key_pressed_reg <= '0';
               end if;
               sclk <= sclk + 1;
                 --4ms
           elsif sclk = 400000 then
               --C4
               Col <= "1110";
               sclk <= sclk + 1;
               -- check row pins
               elsif sclk = 400008 then
               --R1
               if Row = "0111" then
                   decode_reg <= "0001010"; --A
                   is_a_key_pressed_reg <= '1';
                   --R2
               elsif Row = "1011" then
                   decode_reg <= "0001011"; --B
                   is_a_key_pressed_reg <= '1';
                   --R3
               elsif Row = "1101" then
                   decode_reg <= "0001100"; --C
                   is_a_key_pressed_reg <= '1';
                   --R4
               elsif Row = "1110" then
                   decode_reg <= "0001101"; --D
                   is_a_key_pressed_reg <= '1';
               else
                   decode_reg <= decode_reg;
                   is_a_key_pressed_reg <= '0';
               end if;
               sclk <= (others=>'0');
           else
               sclk <= sclk + 1;
           end if;
           end if;
   end process;

is_a_key_pressed <= is_a_key_pressed_reg;
DecodeOut <= decode_reg;
end Behavioral;