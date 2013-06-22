with simple_io, mstring, definitions, liste, entetelexique, typeenum;
use simple_io, mstring, definitions, entetelexique;

procedure testentetelexique is
  testlexique: T_Tab_Ligne;
  resultat:T_tab_Lexique;
  resultat_conv:T_Tab_Ligne;
		exemple1:chaine :=createchaine("module RempliTab( ↓N:entier; ↓T:reel; ↓a:booleen; ↓ ↑b:chaine)");
	   exemple_fonction:chaine:=createchaine("fonction PosMin ( ↓N, M:entier; ↓T:T_Tabcar; ↓imax,imin:entier) entier");
 	resultat_exemple:chaine;
	begin
	put_line("Traduction de: "+ exemple_fonction);
 	conversionEntete(exemple_fonction,resultat_exemple);
 	Put_line(resultat_exemple);	
	new_line;

	put_line("Traduction de: "+ exemple1);
 	conversionEntete(exemple1,resultat_exemple);
 	Put_line(resultat_exemple);

end testentetelexique;
