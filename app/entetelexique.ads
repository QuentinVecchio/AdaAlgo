with simple_io, definitions, mstring, liste, typeEnum;
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

	type T_Tab_Chaine is new listeChaine.T_PTR_LISTE;
	
	--
	--	Fonction qui permet d'extraire la liste des noms d'une ligne donnée
	--	C'est à dire tout les éléments séparées par une virgule entre le début et la première parenthèse
	--	@param ligneCourant, la ligne a analyser
	--	@return T_Tab_Chaine, une liste de l'ensemble des noms trouvés
	--
	function donneListeNom(ligneCourant: chaine) return T_Tab_Chaine;
	
	--
	--	Permet de définir le type de ligne
	--	@param ligneCourant, la ligne a analyser
	--	@return le type de ligne identifié
	--
	function donneTypeLigne(ligneCourant: chaine) return T_typeline;
	
	--
	--	Permet de donner le commentaire d'une ligne donnée si il en existe un
	--	@param ligneCourante, la ligne où se trouve le commentaire
	--	@return chaine, contenant le commentaire
	--
	function donneCommentaire(ligneCourant: chaine) return chaine;
	
	--
	--	Permet de récuperer le type de retour d'une fonction ou le type d'une constante 
	--	(même emplacement dans la chaine)
	--	@param ligneCourant, la ligne a analyser
	--	@return chaine, contenant le type de retour de la fonction ou le type de la constante
	--	@return chaine, une chaine vide si la fonction n'a rien trouvé (= appel dans un mauvais cas)
	--
	function donneType(ligneCourant: chaine) return chaine;
	
	--
	-- 	Permet de récuperer le type d'élément contenu dans une table
	--	@param ligneCourant, la ligne a analyser
	--	@return chaine, contenant le type de valeur contenu dans la table
	function donneTypeEltDeTable(ligneCourant: chaine) return chaine;
	
	--
	--	Permet de récuperer l'ensemble de définition d'un type table
	--	@param ligneCourant, la ligne a analyser
	--	@return chaine, contenant l'ensemble de définition de la table donnée
	--
	function donneEnsDefinition(ligneCourant: chaine) return chaine;
	
	--
	-- Permet de récuperer l'ensemble des données définissant une structure
	--	@param ligneCourant, la ligne a analyser
	--	@return chaine, représentant l'ensemble des constituants de la strcuture
	function donneEltStructure(ligneCourant: chaine) return chaine;
	
	--
	--	Permet de donner le type d'une variable
	--	@param ligneCourant, la ligne a analyser
	--	@return chaine, le type de la variable (entier, reel, caractère..)
	function donneTypeVariable(ligneCourant: chaine) return chaine;
	
	--
	--	Permet de donner la valeur d'une constante
	--	@param ligneCourant, la ligne a analyser
	--	@return chaine, la chaine contenant la valeur de la constante
	function donneValeurConstante(ligneCourant: chaine) return chaine;
	
	--
	--	Permet de construire un élément ligne de type fonction
	--	@param nom, le nom de la fonction
	--	@param commentaire, le commentaire lié a cette fonction
	--	@param typeRetour, le type de la valeur renvoyé par la fonction
	--	@return ligne, une ligne de type fonction avec les champs rempli
	--
	function donnerFonction(nom, commentaire, typeRetour: chaine) return ligne;
	
	--
	--	Permet de construire un élément ligne de type module
	--	@param nom, le nom du module
	--	@param commentaire, le commentaire lié au module
	--	@return ligne, une ligne de type module avec les champs rempli
	--
	function donnerModule(nom, commentaire: chaine) return ligne;
	
	--
	--	Permet de construire un élément ligne de type variable
	--	@param nom, le nom de la variable
	--	@param commentaire, le commentaire lié  a la variable
	--	@param typeValeur, le type de la variable
	--	@return ligne, une ligne de variable avec les champs rempli
	--
	function donnerVariable(nom, commentaire, typeValeur: chaine) return ligne;
	
	--
	--	Permet de construire un élément ligne de constante
	--	@param nom, le nom de la constante
	--	@param commentaire, le commentaire lié a la constante
	--	@param typeValeur, le type de valeur de la constante
	--	@param valeur, la valeur de la constante
	--	@return ligne, une ligne de constante avec les champs rempli
	--
	function donnerConstante(nom, commentaire, typeValeur, valeur: chaine) return ligne;
	
	--
	--	Permet de construire un élément ligne de type table
	--	@param nom, le nom du type table
	--	@param commentaire, le commentaire lié a la table
	--	@param intervalle, les intervalles de définition des dimensions de la table
	--	@param typeElement, le type d'élément dans la table
	--	@return ligne, une ligne de type table avec les champs rempli
	--
	function donnerTable(nom, commentaire, intervalle, typeElement: chaine) return ligne;
	
	--
	--	Permet de construire un élément ligne de type structure
	--	@param nom, le nom de la structure
	--	@param commentaire, le commentaire lié a la structure
	--	@param ensElement, l'ensemble des éléments de la structure
	--	@return ligne, une ligne de type module avec les champs rempli
	--
	function donnerStructure(nom, commentaire, ensElement: chaine) return ligne;
	
	
	
end entetelexique;