library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity counter999_tb is
end;

architecture bench of counter999_tb is

  component counter999
      Generic(start_num: natural := 95;
              end_num  : natural := 105);
      Port ( en : in STD_LOGIC;
             reset : in STD_LOGIC;
             clk : in STD_LOGIC;
             q0 : out STD_LOGIC_VECTOR (3 downto 0);
             q1 : out STD_LOGIC_VECTOR (3 downto 0);
             q2 : out STD_LOGIC_VECTOR (3 downto 0)
             );
  end component;

  signal en: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal clk: STD_LOGIC;
  signal q0: STD_LOGIC_VECTOR (3 downto 0);
  signal q1: STD_LOGIC_VECTOR (3 downto 0);
  signal q2: STD_LOGIC_VECTOR (3 downto 0) ;

begin

  -- Insert values for generic parameters !!
  uut: counter999 generic map ( start_num => 95,
                                end_num   => 105 )
                     port map ( en        => en,
                                reset     => reset,
                                clk       => clk,
                                q0        => q0,
                                q1        => q1,
                                q2        => q2 );

  clk_stimulus: process
  begin
    clk <= '0';
    wait for 50 ns;
    clk <= '1';
    wait for 50 ns;
    
  end process;

    stimulus: process
    begin
        reset <= '1' , '0' after 200 ns;
        
        en <= '0', '1' after 500 ns, '0' after 800 ns, '1' after 1200 ns;
        
        
        wait;
    end process;
    

end;