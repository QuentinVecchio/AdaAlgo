package Tableau is

	type Bloc is private;
	type T_Tab_Bloc is array(1..10) of Bloc;


	





	private
		type Bloc(forme: T_elmt) is record
			case Forme is
				when commentaire 	=> MonCom : chaine;
				when module 		=> MonMod: chaine;
				when affectation 	=> vG, vD : chaine;
				when blocCond 		=> MTab : T_Tab_Bloc;
				when blocCase 		=> toto: chaine;
							   Liste_case : T_Tab_Bloc;
							   case Forme is
							   	   when defaut => null;
								   when others => CondCase: chaine;
							   end case;
				when others 		=> Liste: T_Tab_Bloc;
							   case Forme is
								   when sinon => null;
								   when others => cond: chaine;
							   end case;
			end case;
	
		end record;


end Tableau;
