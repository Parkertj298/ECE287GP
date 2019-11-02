library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

ENTITY simonClassic IS
port (clock, b0, b1, b2, b3 : IN STD_LOGIC; l0, l1,l2,l3 : OUT STD_LOGIC);
END simonClassic;

ARCHITECTURE behavior OF simonClassic IS
signal counter : STD_LOGIC_VECTOR(2 downto 0);
signal randNum : STD_LOGIC_VECTOR(2 downto 0);
signal CLK_1HZ : STD_LOGIC;
signal numOfMoves : STD_LOGIC_VECTOR(9 downto 0);
signal simonVector : STD_LOGIC_VECTOR (0 to 1);
signal numOfInputs : STD_LOGIC;
signal userFinishedInput : STD_LOGIC;
signal patternIncremented : STD_LOGIC;
signal patternDisplayed : STD_LOGIC;
BEGIN --behavior
randCounter : process
BEGIN -- randCounter: this will be the counter that will generate a random number
if clock'event and clock = '1' then  -- rising clock edge
if counter < "100" then   -- Binary value is 4
counter <= counter + 1;
else
counter <= (others => '0');
end if;
end if;
END process randCounter;
patternCreator : process -- will be adding one value (two bits) to the simonVector after a signal is changed
variable index : unsigned(10 downto 0);
BEGIN
if userFinishedInput = '0' then
 randNum <= counter;
 index := STD_LOGIC_VECTOR(resize(unsigned(numOfMoves), index'length)) + unsigned(numOfMoves);
 simonVector(index) <= randNum(0);
 simonVector(index +1) <= randNum(1);
 numOfMoves <= numOfMoves + 1;
 userFinishedInput <= '1';
 patternIncremented <= '1';
END if;
END PROCESS patternCreator;
displayPattern : process -- this will be responsible for displayign the pattern when a new element has been added
BEGIN
if patternIncremented = '1' then
  for ii in 0 to numOfMoves - 1 loop
    if simonVector((2*ii) to (2*ii) + 1) = "00" then
l0 <= '1';
l0 <= '0' after 1 s;
 elsif simonVector((2*ii) to (2*ii) + 1) = "01" then
     l1 <= '1';
l1 <= '0' after 1 s;
 elsif simonVector((2*ii) to (2*ii) + 1) = "10" then
     l2 <= '1';
l2 <= '0' after 1 s;
 elsif simonVector((2*ii) to (2*ii) + 1) = "11" then
     l3 <= '1';
l3 <= '0' after 1 s;
 end if;
 wait for 0.5 s;
END loop;
patternIncremented <= '1';
patternDisplayed <= '1';
END if;
END process displayPattern;
userInput : process
BEGIN -- userInput
if patternDiplayed = '1' then
if b1 = '0' then
userFinishedInput <= '0';
END if;
END if;
END PROCESS userInput;
END behavior;
