with definitions; use definitions;
package body debug is

	procedure debuggage(tab: in out T_tab_ligne) is
		type_ligne: T_type_ligne;
		tmp : T_tab_ligne := tab;
		erreur : boolean := false;
		nbLigne : integer := 0;
	begin
		if estUneVariable(CreateChaine("pa-tati")) then
			put_line(CreateChaine("C'est une chaine"));
		else
			put_line(createchaine("bon ben tant pis"));
		end if;
 		while NOT estVide(tmp) loop
			if length(trimLeft(trimRight(donne_tete(tmp)))) > 2 then
				nbLigne := nbLigne + 1;
		                type_ligne := GetType(donne_tete(tmp));
				if type_ligne = inconnu then
					put_line("le type de ligne n'a pas ete reconnu, a la ligne : "+integer'image(nbLigne)+" ,copie de la ligne "+ donne_tete(tmp));
					erreur := true;
				else
				        case type_ligne is
				                when commentaire => NULL;
				                when affectation => erreur := debug_aff(donne_tete(tmp));
				                when module      => erreur := debug_Mod(donne_tete(tmp));
				                when pour        => erreur := debug_Pour (donne_tete(tmp));
				                when tq          => erreur := debug_tq (donne_tete(tmp));
				                when repeter     => erreur := debug_repeter (donne_tete(tmp));
				                when cond        => erreur := debug_cond(donne_tete(tmp));
				                when testcase    => erreur := debug_case(donne_tete(tmp));
				                when others      => EXIT;  -- sinon, sinonsi ,fsi, fpour, ftq, jusqu'a
				        end case;
					if erreur then
						put_line("il y a une erreur a la ligne : "+integer'image(nbLigne)+" copie de la ligne "+ donne_tete(tmp));
					end if;
				end if;
			end if;
                        donne_suivant(tmp);
                end loop;
	end debuggage;


	function GetType(ligne: chaine)return T_type_ligne is
                typeligne : T_type_ligne;
        begin
                if(startWith(ligne, "c:"))then
                        typeligne:= commentaire;
                elsif(contains(ligne, ":"))then
                        typeligne:= lignecas;
                elsif(startWith(ligne, "pour"))then
                        typeligne:= pour;
                elsif(contains(ligne, "<-"))then
                        typeligne:= affectation;
                elsif(startWith(ligne, "sinonsi"))then
                        typeligne := sinonsi;
                elsif(startWith(ligne, "fcas"))then
                        typeligne := sinonsi;
                elsif(startWith(ligne, "sinon"))then
                        typeligne := sinon;
                elsif(startWith(ligne, "si"))then
                        typeligne:= cond;
                elsif(startWith(ligne, "fsi"))then
                        typeligne:= fsi;
                elsif(startWith(ligne, "lire") or else startWith(ligne, "ecrire"))then
                        typeligne:= module;

                elsif(startWith(ligne, "fpour"))then
                        typeligne:= fpour;
                elsif(startWith(ligne, "ftq"))then
                        typeligne:= ftq;
                elsif(startWith(ligne, "tq"))then
                        typeligne:= tq;
                elsif(startWith(ligne, "repeter"))then
                        typeligne:= repeter;
                elsif(startWith(ligne, "jqa"))then
                        typeligne:= jqa;
                elsif(startWith(ligne, "cas"))then
                        typeligne:= testcase;
		else
			typeligne:= inconnu;
                end if;
                
                return typeligne;
        end GetType;



function debug_aff(L : in chaine) return boolean is
begin
	return False;
end debug_aff;

function debug_Mod(L : in chaine) return boolean is
begin
	return False;
end debug_Mod;

function debug_Pour(L : in chaine) return boolean is
begin
	return False;
end debug_Pour;

function debug_tq(L : in chaine) return boolean is
begin
	return False;
end debug_tq;

function debug_repeter(L : in chaine) return boolean is
begin
	return False;
end debug_repeter;

function debug_cond(L : in chaine) return boolean is
begin
	return False;
end debug_cond;

function debug_case(L : in chaine) return boolean is
begin
	return False;
end debug_case;



function estUneVariable(ch: chaine) return boolean is
	ok : boolean := True;
	Subtype T_CaractMaj is character range 'A'..'Z';
	SubType T_caractMin is character range 'a'..'z';
	i : integer := 2;
	s : string(1..100); l:positive;
begin
	tostring(ch, s, l);
	
	if s(1) in T_CaractMaj OR s(1) in T_caractMin then
		ok := true AND ok;
	end if;

	while i <= l  and ok loop
		if s(i) in T_CaractMaj OR s(i) in T_caractMin OR s(i) = '_' then
			ok := true;
		else
			ok := false;			
		end if;
		i := i +1;
	end loop;
	return ok;
end estUneVariable;

end debug;
