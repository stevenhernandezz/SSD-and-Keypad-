library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity ssd_keypad_top is
   port (
       clk : in STD_LOGIC;
       btn : in STD_LOGIC_VECTOR(3 downto 0);
       an : out STD_LOGIC; -- Controls which position of the seven segment display to display
       seg : out STD_LOGIC_VECTOR (6 downto 0);
       sw : in STD_LOGIC_VECTOR(3 downto 0);
       led : out STD_LOGIC_VECTOR(3 downto 0)
   );
end ssd_keypad_top;

architecture Behavioral of ssd_keypad_top is

   constant clk_freq : INTEGER := 50_000_000;
   constant stable_time : INTEGER := 10;

   component debounce
       generic (
           clk_freq : INTEGER := clk_freq;
           stable_time : INTEGER := stable_time
       );
       port (
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           button : in STD_LOGIC;
           result : out STD_LOGIC
       );
   end component;

   component single_pulse_detector
       generic (
           detect_type : STD_LOGIC_VECTOR(1 downto 0) := "00"
       );
       port (
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           input_signal : in STD_LOGIC;
           output_pulse : out STD_LOGIC
       );
   end component;

   component DisplayController is
       port (
           DispVal : in STD_LOGIC_VECTOR (3 downto 0); -- Output from the decoder
           segOut : out STD_LOGIC_VECTOR (6 downto 0) -- Controls which digit to display
       );
   end component;

   component decoder is
       port (
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           Row : in STD_LOGIC_VECTOR (3 downto 0);
           Col : out STD_LOGIC_VECTOR (3 downto 0);
           DecodeOut : out STD_LOGIC_VECTOR (3 downto 0);
           is_a_key_pressed : out STD_LOGIC
       );
   end component;

   signal rst : STD_LOGIC;
   signal disp_opt : STD_LOGIC;
   signal disp_toggle : STD_LOGIC;
   signal disp_sel : STD_LOGIC;
   signal decode_out : STD_LOGIC_VECTOR(3 downto 0);
   signal is_key_pressed : STD_LOGIC;

begin
   rst <= btn(0);
   an <= disp_sel;
   led <= sw;

   db1 : debounce port map(clk => clk, rst => rst, button => btn(1), result => disp_opt);
   pd1 : single_pulse_detector port map(clk => clk, rst => rst, input_signal => disp_opt, output_pulse => disp_toggle);
   ssd1 : DisplayController port map(DispVal => sw, segOut => seg);

   decoder_inst : decoder port map (clk => clk,rst => rst,Row => sw,Col => open,DecodeOut => decode_out,is_a_key_pressed => is_key_pressed);

   process (rst, disp_toggle)
   begin
       if rst = '1' then
           disp_sel <= '0';
       elsif disp_toggle = '1' then
           disp_sel <= not disp_sel;
       end if;
   end process;

end Behavioral;
