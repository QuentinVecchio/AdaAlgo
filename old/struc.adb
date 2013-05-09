procedure struc is
Programmation
	type Bloc;
	
	type T_Tab_Bloc is array(1..10) of Integer;
	
	type T_elmt is (si, sinonsi, sinon, pour, tq, repeter, affectation, module, commentaire, blocCond, blocCase, defaut);
	
	type Bloc(forme: T_elmt) is record
		case Forme is
			when commentaire 	=> MonCom : chaine;
			when module 		=> MonMod: chaine;
			when affectation 	=> vG, vD : chaine;
			when blocCond 		=> MTab : T_Tab_Bloc;
			when blocCase 		=> 	toto: chaine;
									Liste_case : T_Tab_Bloc;
									case Forme is
										when defaut => null;
										when others => CondCase: chaine;
									end case;
			when others 		=> 	Liste: T_Tab_Bloc;
									case Forme is
										when sinon => null;
										when others => cond: chaine;
									end case;
		end case;
	
	end record;

	begin
	
		put_line("coucou");


end struc;
