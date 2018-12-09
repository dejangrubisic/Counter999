----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2017 07:35:13 PM
-- Design Name: 
-- Module Name: dec_counter - Behavioral
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

entity dec_counter is
    Generic(start_num: natural := 0;
            end_num: natural := 9);
    Port ( en : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           pulse0 : out STD_LOGIC;  --pulse after 9
           pulse1 : out STD_LOGIC;  --pulse to indicate final number
           q : out STD_LOGIC_VECTOR (3 downto 0));
end dec_counter;

architecture Behavioral of dec_counter is
	signal counter: unsigned(3 downto 0) := (others => '0');
begin

	process (clk)
	begin
		if(rising_edge(clk))then
			if(reset = '1')then
				counter <= to_unsigned(start_num, 4);
				pulse0 <= '0';
				pulse1 <= '0';
				if(start_num = 9) then
				    pulse0 <= '1';
				end if;
			else
				if(en = '1')then
					counter <= counter + 1;
					pulse0 <= '0';
					pulse1 <= '0';
					if(counter = to_unsigned(9, 4))then
						counter <= (others => '0');
					end if;
					if(counter = to_unsigned(8, 4))then
                        pulse0 <= '1';
                    end if;
                    
                    if(end_num = 0)then
                        if(counter = to_unsigned(9, 4)) then
                            pulse1 <= '1';
                        end if;
                    elsif(counter = to_unsigned(abs(end_num-1) , 4))then
                        pulse1 <= '1';
                    end if;
				else
					counter <= counter;
				end if;
			end if;		
		end if;
	end process;

	q <= std_logic_vector(counter);
end Behavioral;