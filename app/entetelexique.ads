-----------------------------------------------------------------------------------------
--
--	Paquetage entetelexique:
--
--		Paquetaque regroupant toutes les fonctionnalités de gestion du lexique de l'algorithme.
--		Le lexique est représenté sous forme de liste où chaque ligne de cette liste réprésente
--		une variable.
--
--		@author Cindy Binder
--		@version 1.0.0.0
--		@date 22-06-2013
--
-----------------------------------------------------------------------------------------
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
	type ligne (Forme: T_typeline := variable) is record
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

	procedure affiche(elt: ligne);
	
	package listeLexique is new liste(ligne, affiche);
	use listeLexique;

	type T_tab_Lexique is new listeLexique.T_PTR_LISTE;	
	
	type T_Tab_Chaine is new listeChaine.T_PTR_LISTE;
	
	-- Fonction qui permet de changer les appelations des différents types.
	-- par exemple, dans le langage algorithmique, "chaine" se traduit "string" en Ada.
	--@param ligneEntree, la ligne à analyser
	--@return chaine, cette meme ligne mais convertie en Ada.
	function ChangementdeType(ligneEntree:chaine) return chaine;
	
	--
	-- Procedure qui convertie l'en-tête d'une fonction ou d'un module en Ada.
	-- Elle prend en entrée la ligne a étudiée (donc l'en-tête) qui est en langage algorithmique, puis elle récupère sa traduction en langage Ada.
	procedure conversionEntete(ligneCourante:chaine;ligneConvertie: out chaine);
	
	--
	-- Procedure qui analyse le lexique sous forme algorithmique et le stocke en mémoire.
	-- Cette procédure prend en entrée la liste représentant le lexique tel qu'il est dans l'algorithme.
	--Elle retourne une liste sous forme algorithmique qui sera stockée en mémoire.
	--
	procedure analyseLexique(listeLexique: T_Tab_ligne; resLexique: out T_tab_Lexique);
	
	--
	-- Procedure qui convertie le lexique sous forme algorithme en déclarations Ada.
	-- Elle prend en entrée la liste stockée en mémoire sous forme algorithmique (liste résultat de la procédure "analyseLexique". 
	-- Elle retourne une liste de déclarations Ada. C'est la traduction en Ada du Lexique de l'algorithme.
	procedure conversionLexique(Lexique: T_tab_Lexique; resultat: out T_tab_ligne);
	
	--
	--	Fonction qui permet d'extraire la liste des noms d'une ligne donnée
	--	C'est à dire tous les éléments séparées par une virgule entre le début et la première parenthèse
	--	@param ligneCourante, la ligne à analyser
	--	@return T_Tab_Chaine, une liste de l'ensemble des noms trouvés
	--
	function donneListeNom(ligneCourante: chaine) return T_Tab_Chaine;
	
	--
	-- Procedure qui recherche une variable dans une liste sous forme algorithmique de variable.
	-- Elle prend en entrée la liste des variables, la variable recherchée.
	-- Elle retourne un booléen disant si oui ou non la variable existe, et si elle existe, elle dit son type.
	
	procedure variableExiste(listedesvariables:T_tab_Lexique; variable:chaine; existe:out boolean; type_variable: out chaine);
	
	--
	-- Fonction qui permet de donner le nom d'une variable.
	-- @param ligneCourante, la ligne à analyser
	-- @return chaine contenant le nom de la variable.
	
	function donneNom(ligneCourante: chaine) return chaine;
	
	--
	--	Permet de définir le type de ligne
	--	@param ligneCourante, la ligne à analyser
	--	@return le type de ligne identifié
	--
	function donneTypeLigne(ligneCourante: chaine) return T_typeline;
	
	-- 
	--	Permet de donner le commentaire d'une ligne donnée si il en existe un
	--	@param ligneCourantee, la ligne où se trouve le commentaire
	--	@return chaine, contenant le commentaire
	--
	function donneCommentaire(ligneCourante: chaine) return chaine;
	
	--
	--	Permet de récuperer le type de retour d'une fonction ou le type d'une constante 
	--	(même emplacement dans la chaine)
	--	@param ligneCourante, la ligne à analyser
	--	@return chaine, contenant le type de retour de la fonction ou le type de la constante
	--	@return chaine, une chaine vide si la fonction n'a rien trouvé (= appel dans un mauvais cas)
	--
	function donneType(ligneCourante: chaine) return chaine;
	
	--
	-- 	Permet de récuperer le type d'élément contenu dans une table
	--	@param ligneCourante, la ligne à analyser
	--	@return chaine, contenant le type de valeur contenu dans la table
	function donneTypeEltDeTable(ligneCourante: chaine) return chaine;
	
	--
	--	Permet de récuperer l'ensemble de définition d'un type table
	--	@param ligneCourante, la ligne à analyser
	--	@return chaine, contenant l'ensemble de définition de la table donnée
	--
	function donneEnsDefinition(ligneCourante: chaine) return chaine;
	
	--
	-- Permet de récuperer l'ensemble des données définissant une structure
	--	@param ligneCourante, la ligne à analyser
	--	@return chaine, représentant l'ensemble des constituants de la strcuture
	function donneEltStructure(ligneCourante: chaine) return chaine;
	
	--
	--	Permet de donner le type d'une variable
	--	@param ligneCourante, la ligne à analyser
	--	@return chaine, le type de la variable (entier, réel, caractère..)
	function donneTypeVariable(ligneCourante: chaine) return chaine;
	
	--
	--	Permet de donner la valeur d'une constante
	--	@param ligneCourante, la ligne à analyser
	--	@return chaine, la chaine contenant la valeur de la constante
	function donneValeurConstante(ligneCourante: chaine) return chaine;
	
	--
	--	Permet de construire un élément ligne de type fonction
	--	@param nom, le nom de la fonction
	--	@param commentaire, le commentaire lié a cette fonction
	--	@param typeRetour, le type de la valeur renvoyé par la fonction
	--	@return ligne, une ligne de type fonction avec les champs remplis
	--
	function donnerFonction(nom, commentaire, typeRetour: chaine) return ligne;
	
	--
	--	Permet de construire un élément ligne de type module
	--	@param nom, le nom du module
	--	@param commentaire, le commentaire lié au module
	--	@return ligne, une ligne de type module avec les champs remplis
	--
	function donnerModule(nom, commentaire: chaine) return ligne;
	
	--
	--	Permet de construire un élément ligne de type variable
	--	@param nom, le nom de la variable
	--	@param commentaire, le commentaire lié  a la variable
	--	@param typeValeur, le type de la variable
	--	@return ligne, une ligne de variable avec les champs remplis
	--
	function donnerVariable(nom, commentaire, typeValeur: chaine) return ligne;
	
	--
	--	Permet de construire un élément ligne de constante
	--	@param nom, le nom de la constante
	--	@param commentaire, le commentaire lié a la constante
	--	@param typeValeur, le type de valeur de la constante
	--	@param valeur, la valeur de la constante
	--	@return ligne, une ligne de constante avec les champs remplis
	--
	function donnerConstante(nom, commentaire, typeValeur, valeur: chaine) return ligne;
	
	--
	--	Permet de construire un élément ligne de type table
	--	@param nom, le nom du type table
	--	@param commentaire, le commentaire lié a la table
	--	@param intervalle, les intervalles de définition des dimensions de la table
	--	@param typeElement, le type d'élément dans la table
	--	@return ligne, une ligne de type table avec les champs remplis
	--
	function donnerTable(nom, commentaire, intervalle, typeElement: chaine) return ligne;
	
	--
	--	Permet de construire un élément ligne de type structure
	--	@param nom, le nom de la structure
	--	@param commentaire, le commentaire lié a la structure
	--	@param ensElement, l'ensemble des éléments de la structure
	--	@return ligne, une ligne de type module avec les champs remplis
	--
	function donnerStructure(nom, commentaire, ensElement: chaine) return ligne;
	
	
	
end entetelexique;
