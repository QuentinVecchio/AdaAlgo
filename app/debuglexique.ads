with definitions, mstring, liste, debugalgo, entetelexique;
use definitions, mstring, debugalgo, entetelexique;
package debuglexique is

	--
	--	Représente les différents types de définition que l'on peut avoir
	--
	type T_typeline is (fonction, module, variable, constante, table, structure);



	function debugggageLexique(tab: T_Tab_ligne; descr : in out T_Tab_Ligne) return boolean;

	function donneTypeLigne(ligneCourante: chaine) return T_typeline;




	function debugFunction(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debugVariable(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debugConstante(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debugStructure(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debugTable(L : in chaine; descr: in out T_Tab_Ligne) return boolean;

	function debugmodule(L : in chaine; descr: in out T_Tab_Ligne) return boolean;


end debuglexique;
