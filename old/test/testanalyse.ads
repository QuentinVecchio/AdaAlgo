with simple_io, mstring;
use simple_io, mstring;


package testanalyse is
	type Tabligne is array(Positive range <>) of chaine;
	
	type T_type_ligne is(commentaire,affectation, module, pour, tq, repeter, cond, jqa, fpour, ftq, sinonsi, sinon, fsi, testcase);
	
	testAlgo : Tabligne:=(	CreateChaine("lire (a, b, c)"),
							CreateChaine("discr <- (b * b) - (4 * a * c)"),
							CreateChaine("c: mon premier commentaire"),
							CreateChaine("si discr < 0 alors"),
							CreateChaine("ecrire ('il n'y a pas de solution dans R')"),
							CreateChaine("sinonsi discr = 0 alors"),
							CreateChaine("res <- (-b)/(2 * a)"),
							CreateChaine("ecrire('la fonction admet une solution : x = ', res)"),
							CreateChaine("sinon"),
							CreateChaine("racine <- sqrt(discr)"),
							CreateChaine("res1 <- (-b + racine)/(2 * a)"),
							CreateChaine("res2 <- (-b - racine)/(2 * a)"),
							CreateChaine("ecrire ('l'equation admet deux solution : x1 = ', res1, ' et x2 = ', res2)"),
							CreateChaine("fsi"),
							CreateChaine("pour i de 1 à 15 faire"),
							CreateChaine("fpour"),
							CreateChaine("tq i < 10 faise"),
							CreateChaine("ftq"),
							CreateChaine("repeter"),
							CreateChaine("jusqua i > 10")
							);
							
	procedure afficheTab(T: Tabligne);
	
	function GetType(ligne: chaine)return T_type_ligne;
	
	function testGettype return boolean;
	
	procedure lanceTest;
							

end testanalyse;