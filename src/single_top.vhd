library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity single_top is
    port (
        clk : in STD_LOGIC;
        btn : in STD_LOGIC_VECTOR(3 downto 0);
        sw : in STD_LOGIC_VECTOR(3 downto 0);
        led : out STD_LOGIC_VECTOR(3 downto 0);
        seg : out STD_LOGIC_VECTOR(6 downto 0);
        chip_sel : out STD_LOGIC;
        keypad : inout STD_LOGIC_VECTOR(7 downto 0)
    );
end entity single_top;

architecture Behavioral of single_top is

      constant clk_freq : INTEGER := 125000000;
    constant stable_time : INTEGER := 10;

    signal rst : STD_LOGIC;
    signal btn1_debounce : STD_LOGIC;
    signal btn1_pulse : STD_LOGIC;
    signal c_sel : STD_LOGIC;
    signal keypad_w : STD_LOGIC_VECTOR(7 downto 0);
    signal is_a_key_pressed : STD_LOGIC;
    signal decoder_out : STD_LOGIC_VECTOR(6 downto 0);
    signal signal1 : std_logic_vector(6 downto 0);
    signal signal2: std_logic_vector(6 downto 0);
    signal signal_reg: std_logic_vector(6 downto 0);
    signal display_out: std_logic_vector(6 downto 0);
    signal toggle_btn: std_logic;
    
begin

--decoder
    dc_inst1: entity work.decoder
        port map (
            clk => clk,
            rst => rst,
            col => keypad_w(3 downto 0),
            row => keypad_w(7 downto 4),
            decodeout => decoder_out,
            is_a_key_pressed => is_a_key_pressed
        );
--display
    ssd_i: entity work.DisplayController
        port map (
            DispVal => decoder_out,
            segOut => display_out
        );
--debounce
    db_inst1: entity work.debounce
        generic map (
            clk_freq => clk_freq,
            stable_time => stable_time
        )
        port map (
            clk => clk,
            rst => rst,
            button => btn(1),
            result => btn1_debounce
        );

    pls_inst_1: entity work.single_pulse_detector
        generic map (
            detect_type => "00"
        )
        port map (
            clk => clk,
            rst => rst,
            input_signal => btn1_debounce,
            output_pulse => btn1_pulse
        );
--chip select 
    process (rst, btn1_pulse)
    begin
    --chip sel low
        if rising_edge(rst) then
            c_sel <= '0';
        end if;
        
        if rising_edge(btn1_pulse) then
        --chip sel on btn pulse
            c_sel <= not c_sel;
        end if;
    end process;

--getting digit 
    process(clk, rst, sw, btn1_pulse, display_out) 
begin
    if rising_edge(clk) then
        if rst = '1' then
            signal1 <= (others => '0');
            --signal2 <= (others => '0');
            toggle_btn <= '1';  
        else
            if btn1_pulse = '0' then
                if sw = "0001" then 
                    signal1 <= display_out;  
                    --signal2 <= display_out;
                    end if;
                end if;
            end if;
        end if;
end process;


 
--displaying based on chip select
process (clk, rst, sw, c_sel, signal1, signal2) 
begin 
    if rising_edge(clk) then
        if rst = '1' then
            signal_reg <= (others => '0');
        else 
            if sw = "0000" then 
                signal_reg <= signal1;
            else 
                if c_sel = '1' then
                    signal_reg <= signal1;
                end if;
            end if;
        end if;
    end if;    
end process;

    --assignments 
    seg <= signal_reg;
    chip_sel <= c_sel;
    keypad_w <= keypad;
    rst <= btn(0);

end architecture Behavioral;