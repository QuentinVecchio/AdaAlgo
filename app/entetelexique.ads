with simple_io, definitions, mstring, typeEnum;
use simple_io, definitions, mstring;

package entetelexique is
	--
	--	Représente les différents types de définition que l'on peut avoir
	--
	type T_typeline is (fonction, module, variable, constante, table, structure);

	--
	--	Représentation en mémoire des données sous forme d'une structure
	--	Chaque élément a au minimum un nom et un commentaire
	--	fonction, variable et constante ont en plus un type, qu'il renvoit pour la fonction, qu'il est pour les deux autres
	--	La constante a également une valeur par défaut
	--	Le type structure a quant à lui un ensemble de paramêtres
	--	Le type table a un intervale, et un type d'élément qu'il contient
	--	Pour les autres (module), il n'y a rien de plus de particulier
	--
	type ligne (Forme: T_typeline) is record
		commentaire	: chaine;
		nom			: chaine;
		
		case Forme is
			when fonction | variable | constante =>	leType: chaine;
														case Forme is
															when constante 	=> valeur: chaine;
															when others		=> null;
														end case;
			when structure 	=> ensElement : chaine;
			when table 		=>	intervalle, typeElement : chaine;
			when others		=> null;
		end case;
	end record;

	function donnerFonction(nom, commentaire, typeRetour: chaine) return ligne;
	
	
end entetelexique;