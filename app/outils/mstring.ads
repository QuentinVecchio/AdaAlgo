package mstring is

	type chaine is private;
	subtype l_chaine is Integer range 1..1000;
	subtype indice_chaine is Integer range 0..l_chaine'last;

	--
	--	Creer une chaine à partir d'un string
	--	@param S, le string a transformer en chaine
	--	@return chaine, un élément de type chaîne contenant le string
	--
	function CreateChaine(S: string) return chaine;

	--
	--	Affiche la chaine
	--	@param c, la chaine a afficher
	--
	procedure Put(c: chaine);


	--
	--	Affiche la chaine avec retour à la ligne
	--	@param c, la chaine a afficher
	--
	procedure Put_line(c: chaine);


	--
	--	Recupère une ligne dans la console (s'arrête avec la touche entrée)
	--	@param c, la variable ou sera stockée la chaîne obtenue
	--
	procedure Get_line(c: out chaine);

	--
	--	Donne la longueur de la chaine
	--	@param c, la chaine a manipuler
	--	@return l_chaine, la longueur de la chaine
	--
	function length(c: chaine)return l_chaine;

	--
	--	Concatène une chaine avec un string (l'ajout en fin de chaine);
	--	@param c, la chaine de départ
	--	@param s, le string a ajouter en fin de chaine
	--
	procedure concat(c: in out chaine; s: in string);

	--
	--	Fonction "+" appel concat avec les bons paramêtres (conversion)
	--	il y a : c= chaine et s = string
	--		c + s = c
	--		s + c = c
	--		s + s = c
	--		c + c = c
	--
	function "+"(c: chaine; s: string) return chaine;

	function "+"(s: string; c: chaine) return chaine;

	function "+"(s1, s2: string) return chaine;

	function "+"(c1, c2: chaine) return chaine;

	--
	--	Transforme de chaine vers string
	--	@param c, la chaine a transformer en string
	--	@param s, le string qui contiendra la chaine
	--	@paral l, la longueur de la chaine obtenue
	--
	procedure toString(c: in chaine; s: out string; l: out l_chaine);

	--
	--	Permet de savoir si une chaine donnée contient un motif donnée
	--	@param c, la chaine a tester
	--	@param s, le motif qui peut se trouver dans c
	--	@return vrai, si le motif est dans la chaine
	--	@return faux, si aucune correspondance n'a été trouvée
	--
	function contains(c: chaine; s: string) return boolean;

	--
	--	De même qu'avant mais avec deux chaines
	--	@param c, la chaine a tester
	--	@param s, le motif
	--
	function contains(c, s: chaine) return boolean;

	--
	--	Enleve les espaces à gauche
	--	@param c, la chaine où l'on retire les espaces
	--	@return chaine, la chaine sans les espaces a gauche
	--
	function trimLeft(c: chaine) return chaine;

	--
	--	Enleve les espaces à droite
	--	@param c, la chaine où l'on retire les espaces
	--	@return chaine, la chaine sans les espaces a droite
	--
	function trimRight(c: chaine) return chaine;

	--
	--	Renvoit un morceau de la chaine comprit entre debut et fin
	--	@param c, la chaine où l'on extrait un morceau
	--	@param debut, le début de prélèvement
	--	@param fin, la fin
	--	@return chaine, correspondant a l'intervalle entre debut et fin
	--
	function substring(c: chaine; debut, fin: l_chaine) return chaine;

	--
	--	Permet de remplacer un caractère par un autre de coucou à loulou par exemple, sensible à la casse
	--	@param c, la chaine a modifier
	--	@param caracRecherche, le caractère a rechercher
	--	@param caracRempl, le caractère qui doit remplacer
	--	@return chaine, le resultat obtenu
	--
	function replaceChar(c: chaine; caracRecherche, caracRempl : character) return chaine;

	--
	--	Permet de savoir si une chaine commence par un motif donnée (enlève les espaces dans la chaine)
	--	@param c, la chaine a tester
	--	@param motif, le motif qui devrait commencer la chaine
	--	@return vrai, si la chaine c commence bien par le motif
	--	@return fause, si ce n'est pas le cas
	--
	function startWith(c: chaine; motif: chaine) return boolean;

	--
	--	Idem
	--	@param c, la chaine a tester
	--	@param motif, sous forme de string qui devrait commencer la chaine
	--
	function startWith(c: chaine; motif: string) return boolean;

	--
	--	Renvoit la position de la première occurence d'un caractère dans une chaine
	--	@param c, la chaine a tester
	--	@param motif, le caractère a rechercher
	--	@return 0, si le caractère n'est pas dans la chaine
	--	@return indice_chaine, la position du caractère dans la chaine
	--
	function strpos(c: chaine; motif: character) return indice_chaine;

	
	--
	--	Permet de remplacer un morceau de chaine par un autre
	--	Ex replaceStr("coucou", "ou", hi") donne chichi
	--	@param depart, la chaine a modifier
	--	@param recherche, l'occurence a rechercher
	--	@param remplace, ce qui remplace le motif a chercher dans la chaine
	--	@return chaine, le resultat des modifications
	--
	function replaceStr(depart, recherche, remplace : chaine) return chaine;
	
	function replaceStr(depart,recherche: chaine; remplace: string) return chaine;
	
	function replaceStr(depart: chaine; recherche, remplace: string) return chaine;
	
	function replaceStr(depart, recherche, remplace: string) return chaine;
	
	function replaceStr(depart: chaine; recherche: string; remplace: chaine) return chaine;
	
	function replaceStr(depart: string; recherche: chaine; remplace: string) return chaine;
	
	private

	type chaine(L: l_chaine:= 1) is record
		text: String(1..L);
	end record;
end mstring;