with definitions, mstring, typeEnum;
use definitions, mstring;

package gestionbloc is

	-- Permet d'affiche le type d'élément pour la fonction afficheElt
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

	liste_deja_cree: exception;
	
	--
	--	Crée une nouvelle liste
	--	peut lancer liste_deja_cree 
	--
	procedure creerListe(L: out T_Tab_Bloc);
	
	--
	--	Renvoit vrai si le bloc est null
	--
	function estVide(L: T_Tab_Bloc)return boolean;
	
	--
	--	Renvoit vrai si dernier element de la liste
	--
	function estFinListe(L: T_Tab_Bloc) return boolean;
	
	--
	--	Ajoute un element en fin de liste
	--
	procedure ajoutElt(L: in out T_Tab_Bloc; elt: Bloc);
	
	--
	-- Affiche tout les éléments du dernier ajouté au premier
	--
	procedure afficheTypeElt(L: in T_Tab_Bloc);
	
	--
	--	Donne le premier élément de la liste, sans l'enlever
	--
	procedure donneTete(L: T_Tab_Bloc; elt: in out Bloc);
	
	--
	--	Enleve le premier élément de la liste
	--
	procedure enleveTete(L: in out T_Tab_Bloc);
	
	
	procedure ajoutCommentaire(L: in out T_Tab_Bloc; com: chaine);
	
	private
	
		--
		-- Modélise l'élément d'une chaine
		--
		type T_Tab_Bloc is record
			
			courant: ACCESS Bloc;
			suivant: T_ACCESS_Tab_Bloc;
			
		end record;	
end gestionbloc;