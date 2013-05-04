with definitions, mstring, typeEnum;
use definitions, mstring;

package gestionbloc is

	package AfficheT_elt is new typeEnum(T_elmt);
	use AfficheT_elt;
	
	
	-- type contenant la liste des blocs 
	type T_Tab_Bloc is private;

	-- pointeur pour définition récursive
	type T_ACCESS_Tab_Bloc is ACCESS T_Tab_Bloc;
	
	-- type bloc regroupant tout les types que l'on peut rencontrer dans un algo
	type Bloc(Forme: T_elmt) is record
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

	procedure creerListe(L: out T_Tab_Bloc);
	
	function estVide(L: T_Tab_Bloc)return boolean;
	
	procedure ajoutElt(L: in out T_Tab_Bloc; elt: Bloc);
	
	procedure afficheTypeElt(L: in T_Tab_Bloc);
	
	procedure donneTete(L: T_Tab_Bloc; elt: in out Bloc);
	
	private
	
		type T_Tab_Bloc is record
			
			courant: ACCESS Bloc;
			suivant: T_ACCESS_Tab_Bloc;
			
		end record;	
end gestionbloc;