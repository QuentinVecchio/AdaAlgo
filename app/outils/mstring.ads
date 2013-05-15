package mstring is

	type chaine is private;
	subtype l_chaine is Integer range 1..1000;
	subtype indice_chaine is Integer range 0..l_chaine'last;

	--
	--	Creer une chaine à partir d'un string
	--
	function CreateChaine(S: string) return chaine;

	--
	--	Affiche la chaine
	--
	procedure Put(c: chaine);


	--
	--	Affiche la chaine avec retour à la ligne
	--
	procedure Put_line(c: chaine);


	--
	--	Recupère une ligne dans la console (s'arrête avec la touche entrée)
	--
	procedure Get_line(c: out chaine);

	--
	--	Donne la longueur de la chaine
	--
	function length(c: chaine)return l_chaine;

	--
	--	Concatène une chaine avec un string (l'ajout en fin de chaine);
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
	--	l contient la longueur de la chaine
	--
	procedure toString(c: in chaine; s: out string; l: out l_chaine);

	--
	--	Renvoit vrai si la chaine contient le motif s, faux sinon
	--
	function contains(c: chaine; s: string) return boolean;

	--
	--	De même qu'avant mais avec deux chaines
	--
	function contains(c, s: chaine) return boolean;

	--
	--	Enleve les espaces à gauche
	--
	function trimLeft(c: chaine) return chaine;

	--
	--	Enleve les espaces à droite
	--
	function trimRight(c: chaine) return chaine;

	--
	--	Renvoit un morceau de la chaine comprit entre debut et fin
	--
	function substring(c: chaine; debut, fin: l_chaine) return chaine;

	--
	--	Permet de remplacer un caractère par un autre de coucou à loulou par exemple, sensible à la casse
	--
	function replaceChar(c: chaine; caracRecherche, caracRempl : character) return chaine;

	--
	--	Renvoit vrai si la chaine commence par le motif (ne compte pas les espaces à gauche)
	--
	function startWith(c: chaine; motif: chaine) return boolean;

	--
	--	Idem
	--
	function startWith(c: chaine; motif: string) return boolean;

	--
	--	Renvoit la position de la première occurence d'un caractère dans une chaine
	--
	function strpos(c: chaine; motif: character) return indice_chaine;

	
	--
	--	Permet de remplacer un morceau de chaine par un autre
	--	Ex replaceStr("coucou", "ou", hi") donne chichi
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