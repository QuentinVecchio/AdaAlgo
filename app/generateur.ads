-----------------------------------------------------------------------------------------
--
--	Paquetage generateur:
--
--		Ce paquetage fait le lien entre le fichier d'enregistrement et l'application
--		Cela permet de stocker les algorithmes pour une utilisation ultérieure.
--		
--
--		@author Matthieu Clin
--		@version 1.0.0.0
--		@date 22-06-2013
--
-----------------------------------------------------------------------------------------
with mstring, simple_io, text_io, definitions,debugalgo, analyse, gestionbloc,entetelexique, conversion, entetelexique, debuglexique;
use mstring, simple_io,definitions,debugalgo, analyse, gestionbloc,entetelexique, conversion, entetelexique, debuglexique;

package generateur is

	--
	--	Procédure qui permet d'enregistrer un algorithme
	--	On partage la partie algo de la partie variable avec des balises XML
	--	@param chemin, le chemin ou l'on doit enregistrer le fichier
	--	@param algo, variable, respectivement l'algorithme et les variables utilisées dedans
	--
	procedure enregistrer(chemin: string; algo, variable: T_Tab_ligne);

	procedure enregistrer(chemin, entete: string; algo, variable: T_Tab_ligne);

	--
	--	procédure qui permet de récupérer un algorithme préalablement enregistré
	--	@param chemin, le chemin ou l'on doit trouver le fichier
	--	@param algo, variable, respectivement l'algorithme et les variables utilisées dedans
	--
	procedure ouvrir(chemin: string; algo, variable: in out T_Tab_ligne);

	procedure ouvrir(chemin: string; entete: out chaine; algo, variable: in out T_Tab_ligne);


	--
	--
	--
	procedure generer(entete, lexique, algo: in string; resultat: out chaine; success: out boolean);

	procedure strtolabel(entree: in out T_Tab_ligne; sortie: in out chaine);

	procedure labeltoStr(entree: in out chaine; sortie: out T_Tab_ligne);

	procedure donneSousProgramme(cheminSousProgramme: chaine; resultat: in out T_Tab_ligne; success: out boolean);


end generateur;
