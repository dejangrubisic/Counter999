----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2017 07:57:49 PM
-- Design Name: 
-- Module Name: counter999 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter999 is
    Generic(start_num: natural := 21;
            end_num  : natural := 256);
    Port ( en : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           q0 : out STD_LOGIC_VECTOR (3 downto 0);
           q1 : out STD_LOGIC_VECTOR (3 downto 0);
           q2 : out STD_LOGIC_VECTOR (3 downto 0)
           );
end counter999;

architecture Behavioral of counter999 is
    signal pulse0_s, pulse1_s : std_logic := '0';
    signal pulse0_and_pulse1_s_and_en, pulse0_s_and_en: std_logic := '0';
    
    signal pulse_reset0_s, pulse_reset1_s, pulse_reset2_s: std_logic := '0';
    signal reset_all: std_logic := '0';
    
    component dec_counter
    generic(start_num: natural;
            end_num: natural);
    port(   en : in STD_LOGIC;
            reset : in STD_LOGIC;
            clk : in STD_LOGIC;
            pulse0 : out STD_LOGIC;
            pulse1 : out STD_LOGIC;
            q : out STD_LOGIC_VECTOR (3 downto 0)
            );
    end component;
begin

    digit0: dec_counter
        generic map(start_num => start_num rem 10,
                    end_num => end_num rem 10)
        port map (  en => en,
                    reset => reset_all,
                    clk => clk,
                    pulse0 => pulse0_s,
                    pulse1 => pulse_reset0_s,
                    q => q0
                    );
    digit1: dec_counter 
        generic map(start_num => ((start_num rem 100) - (start_num rem 10))/10,
                end_num => ((end_num rem 100) - (end_num rem 10))/10)
        port map (  en => pulse0_s_and_en,
                    reset => reset_all,
                    clk => clk,
                    pulse0 => pulse1_s,
                    pulse1 => pulse_reset1_s,
                    q => q1
                    );
    digit2: dec_counter 
        generic map(start_num => (start_num - (start_num rem 100))/100,
            end_num => (end_num - (end_num rem 100))/100)
        port map (  en => pulse0_and_pulse1_s_and_en ,
                    reset => reset_all,
                    clk => clk,
                    pulse0 => open,
                    pulse1 => pulse_reset2_s,
                    q => q2
                    );
     pulse0_s_and_en <= pulse0_s and en;
     pulse0_and_pulse1_s_and_en <= pulse0_s and pulse1_s and en;
     reset_all <= (pulse_reset0_s and pulse_reset1_s and pulse_reset2_s) or reset;
     
end Behavioral;
