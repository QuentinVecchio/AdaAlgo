with simple_io, mstring;
use simple_io, mstring;


procedure testanalyse is

	type Tabligne is array(Integer range <>) of chaine;
	
	testAlgo : Tabligne:=(		CreateChaine("lire (a, b, c)"),
								CreateChaine("discr <- (b * b) - (4 * a * c)"),

								CreateChaine("si discr < 0 alors"),
								CreateChaine("ecrire ('il n'y a pas de solution dans R')"),
								CreateChaine("SinonSi discr = 0 alors"),
								CreateChaine("res <- (-b)/(2 * a)"),
								CreateChaine("ecrire('la fonction admet une solution : x = ', res)"),
								CreateChaine("Sinon"),
								CreateChaine("racine <- sqrt(discr)"),
								CreateChaine("res1 <- (-b + racine)/(2 * a)"),
								CreateChaine("res2 <- (-b - racine)/(2 * a)"),
								CreateChaine("ecrire ('l'equation admet deux solution : x1 = ', res1, ' et x2 = ', res2)"),
								CreateChaine("fsi"));

	procedure afficheTab(T: Tabligne) is
	
		begin
		
			for I in T'range loop
				put_line(T(I));
			end loop;
	end;

	begin
	
		afficheTab(testAlgo);
		
		
end testanalyse;