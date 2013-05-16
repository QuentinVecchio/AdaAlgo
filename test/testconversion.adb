with simple_io, conversion, definitions, mstring,gestionBloc, typeEnum;
use simple_io, conversion, definitions, mstring,gestionBloc;


procedure testconversion is

	function testConversionCommentaire return boolean is
		aReussi: boolean := true;
		T: T_Tab_Bloc;
		L: T_Tab_Ligne;
		res: chaine := createChaine("--Je suis un commentaire:)");
		begin
			creerListe(T);
			ajoutCommentaire(T, createChaine("Je suis un commentaire:)"));
			conversionCommentaire(T,L);
			if(donne_tete(L) = res)then
				Put_line("Conversion d'un commentaire réussi !");
			else
				Put_line("==>Erreur de conversion:");
				Put_line("Attendu: "+ res);
				Put_line("Reçu:    "+ donne_tete(L));
				aReussi := false;
			end if;
		
		return aReussi;
	end testConversionCommentaire;

	begin
		Put_line("Début de test du fichier conversion.adb");
		if(testConversionCommentaire)then
			Put_line("Test de conversionCommentaire reussi avec succes");
		else
			Put_line("Il reste encore des erreurs dans conversionCommentaire");
		end if;
end testconversion;