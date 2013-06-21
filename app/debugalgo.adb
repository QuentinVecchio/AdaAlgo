with definitions; use definitions;
package body debugalgo is

	function debuggageAlgo(tab: in T_tab_ligne; descrErrors : in out T_Tab_Ligne) return boolean is
		type_ligne: T_type_ligne;
		tmp : T_tab_ligne := tab;
		ok, ok2 : boolean := True;

	begin
		
		ok := analyseInclusionBloc(tab, descrErrors);
		if ok then
	 		while NOT estVide(tmp) loop
				if length(trimLeft(trimRight(donne_tete(tmp)))) > 2 then

					ok2 := True;
				        type_ligne := GetType(donne_tete(tmp));

					

					if type_ligne = inconnu then
						Ajout_queue(descrErrors, "Le type de ligne n'a pas ete reconnu : "+ donne_tete(tmp));
						ok2 := False;
					else
					
						case type_ligne is
							when commentaire => NULL;
							when affectation => ok2 := debug_aff(donne_tete(tmp), descrErrors);
							when module      => ok2 := debug_Mod(donne_tete(tmp), descrErrors);
							when pour        => ok2 := debug_Pour (donne_tete(tmp), descrErrors);
							when tq          => ok2 := debug_tq (donne_tete(tmp), descrErrors);
							when repeter     => ok2 := debug_repeter (donne_tete(tmp), descrErrors);
							when cond        => ok2 := debug_cond(donne_tete(tmp), descrErrors);
							when testcase    => ok2 := debug_case(donne_tete(tmp), descrErrors);
							when others      => NULL;  -- sinon, sinonsi ,fsi, fpour, ftq, jusqu'a
						end case;
					end if;
				end if;

		                donne_suivant(tmp);
				ok := ok AND ok2;
		        end loop;
		end if;

		return ok;
	end debuggageAlgo;


	function GetType(ligne: chaine)return T_type_ligne is
                typeligne : T_type_ligne;
		i : integer;
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
                elsif(startWith(ligne, "fcas"))then
                        typeligne:= fcas;
		else
			i := strpos(ligne, '(');
			if i > 0 AND THEN strpos(ligne,')') > 0 then
				if estUneVariable(substring(ligne, 1, i-1)) then
					typeligne := module;
				end if;
			else
				typeligne:= inconnu;
			end if;
			
                end if;
                
                return typeligne;
        end GetType;



function debug_aff(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
	ok : boolean := True;
begin
	return ok;
end debug_aff;

function debug_Mod(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
	tmp : chaine := L;
	ok : boolean := True;
	guillemet : string(1..1);
	i : integer;
begin
	guillemet(1) := character'val(34);
	-- ouvire quote mais pas fermé
	-- presence de parentheses
	-- si variables existes


	--Guillemets
	i := strpos(tmp, guillemet(1));
	if i /= 0 Then
		if strpos(substring(tmp, i+1, length(tmp)), guillemet(1)) = 0 then
			Ajout_queue(descr, "Erreur de pairage des guillemets : " + L);
			ok := ok AND False;
		end if;
	end if;

	--Parenthese
	i := strpos(tmp, '(');
	if i = 0 then
		ok := ok AND False;
		Ajout_queue(descr, "Parenthese ouvrante '(' : "+L);

	end if;
	if strpos(tmp, ')') = 0 then
		Ajout_queue(descr, "Parenthese fermante ')' : "+L);
		ok := ok AND False;
	end if;
	if i > strpos(tmp, ')') AND strpos(tmp, '(') /= 0 then
		Ajout_queue(descr, "Erreur de parenthesage : " + L);
		ok := ok AND False;
	end if;


	if ok then
		--verification qu'il y ait au moins un parametre
		tmp := substring(tmp, strpos(tmp, '('), strpos(tmp, ')'));
		tmp := trimLeft(tmp);
		tmp := trimRight(tmp);
		if length(tmp) =2 then
			ok := ok AND False;
			Ajout_queue(descr, "Parametre manquant : "+L);
		end if;
	end if;

	return ok;


end debug_Mod;

function debug_Pour(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
	bi, bs : chaine;
	binf, bsup : string(1..10); m,n : integer;
	tmp: chaine := L; 
	inf, sup : integer;
	ok : boolean := True;
	ss_chaine : T_Tab_Ligne;
begin
	-- Verification de la présence de '<-' 'a' et 'faire'
	SplitChaine(tmp, ss_chaine);
	if (appartient_liste(ss_chaine, CreateChaine("<-")) AND appartient_liste(ss_chaine, CreateChaine("a")) AND appartient_liste(ss_chaine, CreateChaine("faire"))) then
		Ajout_queue(descr, "Condition manquante : " + L);
		ok := ok AND False;
	else
		-- Verification des bornes inf et des bornes sup!

		bi := substring(L, strpos(L, "<-")+2, strpos(L, 'a')-1);
		put_line(bi);
		bs := substring(L, strpos(L, 'a')+1, length(L)-5);
		bi := trimLeft(bi); bs := trimLeft(bs);
		bi := trimRight(bi); bs := trimRight(bs);

		toString(bi, binf, m);
		tostring(bs, bsup, n);	
	
		inf := integer'Value(binf(1..m));
		sup := integer'Value(bsup(1..n));

		if inf >= sup then
			Ajout_queue(descr, "Intervalle mal defini : "+ L);
			ok := False AND ok;
		end if;

	end if;
	return ok;
end debug_Pour;

function debug_repeter(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
begin
	-- Verifier la présence du 'faire'
	return true;
end debug_repeter;

function debug_tq(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
	tmp : chaine := L;
	ss_chaine : T_tab_ligne;
	ok : boolean := True;
begin
	-- Verifier la présence du 'faire'
	-- verifier la présence d'au moins une condition
	SplitChaine(tmp, ss_chaine);
	enleve_enTete(ss_chaine);
	if NOT(donne_queue(ss_chaine) = CreateChaine("faire")) then
		Ajout_queue(descr, "Mot-clef 'faire' manquant : "+L);
		ok := False AND ok;
	else
		enleve_queue(ss_chaine);
		if estVide(ss_chaine) then 
			Ajout_queue(descr, "Condition manquante : "+L);
			ok := False AND ok;
		end if;
	end if;

	return ok;
end debug_tq;

function debug_cond(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
begin
	return True;
end debug_cond;

function debug_case(L : in chaine; descr: in out T_Tab_Ligne) return boolean is
begin
	return True;
end debug_case;


function analyseInclusionBloc(L : in T_Tab_ligne; descr: in out T_Tab_Ligne) return boolean is
	ok : boolean := True;
	tmp : T_Tab_Ligne := L;
	pile_elt : Pile;
begin
	while NOT estVide(tmp) loop
		type_ligne := GetType(donne_tete(tmp));
		if Type_Ligne in cond | lignecas | pour | tq | repeter then
			Ajout_queue(pile_elt, type_ligne);
		end if;

		if Type_Ligne in fsi | jqa | fpour | ftq then
			enleve_queue(pile_elt);
		end if;

		donne_suivant(tmp);
	end loop;
	if NOT estVide(pile_elt) then
		Ajout_queue(descr, CreateChaine("il manque des fermeture de bloque"));
		ok := False;
	end if;
	return ok;
end;

function estUneVariable(ch: chaine) return boolean is
	ok : boolean := True;
	var : chaine := ch;
	Subtype T_CaractMaj is character range 'A'..'Z';
	SubType T_caractMin is character range 'a'..'z';
	i : integer := 2;
	s : string(1..100); l:positive;
begin
	var := trimLeft(var); var := trimRight(var);
	tostring(var, s, l);
	if NOT(s(1) in T_CaractMaj OR s(1) in T_caractMin) then
		ok := False AND ok;
		
	end if;

	while i <= l  AND ok loop
		
		if NOT(s(i) in T_CaractMaj OR s(i) in T_caractMin OR s(i) = '_') then
			ok := False AND ok;	
		else
			ok := True AND ok;	
		end if;	
		i := i +1;
	end loop;		
	return ok;
end estUneVariable;


procedure afficheErrors(descr : T_Tab_ligne) is

begin
	if NOT estVide(descr) then
		put_line(donne_Tete(descr));
		afficheErrors(donne_suivant(descr));
	end if;

end afficheErrors;

procedure SplitChaine(c : in out Chaine; chaineSplit : in out T_Tab_Ligne) is
	i : integer;
begin
	c := trimLeft(c); c:= trimRight(c);
	c := c+' ';
	if length(c) > 0 then
		i := strpos(c, ' ');
		Ajout_queue(chaineSplit, substring(c, 1, i -1));
		if i < length(c) then
			c := substring(c, i+1, length(c));
			SplitChaine(c, chaineSplit);
		end if;
	end if;
end SplitChaine;



end debugalgo;
