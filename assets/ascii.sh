#! /bin/bash

source ./assets/set_color.sh


function display_ascii_art()
{
	cat << "EOF"
                                                 
 @@@@@@@  @@@ @@@  @@@@@@@   @@@@@@@@  @@@@@@@   
@@@@@@@@  @@@ @@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  
!@@       @@! !@@  @@!  @@@  @@!       @@!  @@@  
!@!       !@! @!!  !@   @!@  !@!       !@!  @!@  
!@!        !@!@!   @!@!@!@   @!!!:!    @!@!!@!   
!!!         @!!!   !!!@!!!!  !!!!!:    !!@!@!    
:!!         !!:    !!:  !!!  !!:       !!: :!!   
:!:         :!:    :!:  !:!  :!:       :!:  !:!  
 ::: :::     ::     :: ::::   :: ::::  ::   :::  
 :: :: :     :     :: : ::   : :: ::    :   : :  
                                                 
                                        
 @@@@@@    @@@@@@@   @@@@@@   @@@  @@@  
@@@@@@@   @@@@@@@@  @@@@@@@@  @@@@ @@@  
!@@       !@@       @@!  @@@  @@!@!@@@  
!@!       !@!       !@!  @!@  !@!!@!@!  
!!@@!!    !@!       @!@!@!@!  @!@ !!@!  
 !!@!!!   !!!       !!!@!!!!  !@!  !!!  
     !:!  :!!       !!:  !!!  !!:  !!!  
    !:!   :!:       :!:  !:!  :!:  !:!  
:::: ::    ::: :::  ::   :::   ::   ::  
:: : :     :: :: :   :   : :  ::    :   
                                        
EOF

	echo -e "\nWelcome to this utility for monitoring information of certain addresses in the internet space."
	echo "$(set_color "yellow")P.S:$(set_color "*") On the fact of using this utility: You are solely responsible for Your actions."
	echo -e "\n@All right reserved"
}
