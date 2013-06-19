with definitions; use definitions;
package body debug is

	procedure debuggage(tab: in out T_tab_ligne) is
		type_ligne: T_type_ligne;
		tmp : T_tab_ligne := tab;
		erreur : boolean := false;
		nbLigne : integer := 0;
	begin
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
	tmp : chaine := L;
	erreur : boolean := False;
	guillemet : string(1..1);
	i : integer;
begin
	put_line(CreateChaine("Verification de module"));
	guillemet(1) := character'val(34);
	-- ouvire quote mais pas fermé
	-- presence de parentheses
	-- si variables existes


	--Guillemets
	i := strpos(tmp, guillemet(1));
	if i /= 0 Then
		if strpos(substring(tmp, i+1, length(tmp)), guillemet(1)) = 0 then
			put_line(CreateChaine("les guillemets n'ont pas été fermés"));
			erreur := True;
		end if;
	end if;

	--Parenthese
	i := strpos(tmp, '(');
	if i = 0 then
		erreur := erreur AND True;
		put_line(CreateChaine("il n'y a pas de parenthese ouvrante"));

	end if;
	if strpos(tmp, ')') = 0 then
		put_line(CreateChaine("il n'y a pas de parenthese fermente"));
		erreur := erreur AND True;
	end if;
	if i > strpos(tmp, ')') then
		put_line(CreateChaine("Vous avez mal géré vos parenthese"));
		erreur := erreur AND True;
	end if;


	--verification qu'il y ait au moins un parametre
	tmp := substring(tmp, strpos(tmp, '('), strpos(tmp, ')'));
	tmp := trimLeft(tmp);
	tmp := trimRight(tmp);
	if length(tmp) =2 then
		erreur := erreur AND True;
		put_line(CreateChaine("il faut mettre au moins un parametre dans cette fonction"));
	end if;
	return erreur;


end debug_Mod;

function debug_Pour(L : in chaine) return boolean is
	bi, bs : chaine;
	binf, bsup : string(1..10); m,n : integer;
	tmp: chaine := L; 
	inf, sup : integer;
	erreur : boolean := False;
begin
	bi := substring(tmp, strpos(tmp, '-')+1, strpos(tmp, 'a')-1);
        bs := substring(tmp, strpos(tmp, 'a')+1, length(tmp)-6)+" ";
	bi := trimLeft(bi); bs := trimLeft(bs);
	bi := trimRight(bi); bs := trimRight(bs);
	put_line(bi);
	put_line(bs);

	toString(bi, binf, m);
	tostring(bs, bsup, n);	
	
	--ERREUR ICI : raised CONSTRAINT_ERROR : s-valuti.adb:273 explicit raise
	--inf := integer'Value(binf);
	--sup := integer'Value(bsup);

	if inf >= sup then
		put_line(CreateChaine("euh... vous avez mal gérer vous bornes inf et sup"));
		erreur := True;
	end if;
	return erreur;
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
