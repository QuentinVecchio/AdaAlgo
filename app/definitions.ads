-----------------------------------------------------------------------------------------
--
--	Paquetage Définitions:
--	Contient toutes les définitions des différents types utilisés dans tout le programme
--	Ces types sont égalements utilisés dans la partie de test
--	Remarque: les types propres à la conversion et la traduction du lexique ne se trouvent pas ici
--
--		@author Nicolas Weissenbach, Matthieu Clin
--		@version 1.0.0.0
--		@date 22-06-2013
--
-----------------------------------------------------------------------------------------

with mstring, liste;
use mstring;
package definitions is

	--
	--	Type d'élément que l'on peut rencontrer dans un algo
	-- 	Remarque: 	- blocCond correspond au bloc de si jusqu'à fsi
	--						- blocCase correspond au bloc de cas parmis jusqu'à fcas.
	--
        type T_elmt is (si, sinonsi, sinon, pour, tq, repeter, affectation, module, commentaire, blocCond, blocCase, defaut, BlocIntCase);

        type T_type_ligne is(commentaire,affectation, module, pour, tq, repeter, cond, jqa, fpour, ftq, sinonsi, sinon, fsi, testcase, lignecas, inconnu);
   
	--
	--	Le type T_Tab_Ligne est une liste de chaine permettant de manipuler le contenu reçu de l'utilisateur
	--	et le contenu qu'on affiche (la traduction en ada).
	--     
	package listeChaine is new liste(chaine, mstring.put_line);
	use listeChaine;
	
	type T_Tab_Ligne is new listeChaine.T_PTR_LISTE;

end definitions;
