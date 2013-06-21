package body conversion is

        procedure conversionAda(listeBloc : in out T_TAB_BLOC; listeLigne : in out T_TAB_LIGNE) is
                elt : Bloc; 
        begin
                while (estVide(listeBloc) = FALSE) loop
                        donneTete(listeBloc,elt);--On affecte le bloc a analyser à elt
                        case elt.Forme is
                                when commentaire  => conversionCommentaire(elt,listeLigne);
                                when module  => conversionModule(elt,listeLigne);
                                when affectation => conversionAffectation(elt,listeLigne);
                                when pour => conversionPour(elt,listeLigne);
                                when tq => conversionTantque(elt,listeLigne);
                                when repeter => conversionRepeter(elt,listeLigne);
                                when blocCond => conversionCond(elt,listeLigne);
                                when si=> conversionSi(elt,listeLigne);
                                when sinonsi=> conversionSinonsi(elt,listeLigne);
                                when sinon=> conversionSinon(elt,listeLigne);
                                when blocCase => conversionCasParmi(elt, ListeLigne);
                                when BlocIntCase => conversionCasParmisInt(elt, ListeLigne);
                                when others =>null;
                        end case;
                        enleveTete(listeBloc);
                end loop;
        end conversionAda;
        
        procedure conversionCommentaire(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
        begin
                Ajout_queue(Ligne,"--" + m_bloc.MonCom);
        end conversionCommentaire;
        
        procedure conversionAffectation(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
        begin
                Ajout_queue(Ligne,m_bloc.vG + ":=" + m_bloc.vD + ";");
        end conversionAffectation;

        procedure conversionModule(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
		parametre : T_TAB_LIGNE;
		L_courant : chaine;
		module : chaine;
		existe_apres:boolean:=true;
		i : integer;
		guillemet : string(1..1);
		var : chaine;
        begin
		guillemet(1) := character'val(34);
                if(StartWith(m_bloc.MonMod,"lire")) then --On teste si c'est le module lire
                      L_courant := substring(m_bloc.MonMod, 6, length(m_bloc.MonMod)-1)+",";
			Module := CreateChaine("get");
                elsif(startWith(m_bloc.MonMod,"ecrire")) then -- On teste si c'est le module ecrire
                        L_courant := substring(m_bloc.MonMod, 8, length(m_bloc.MonMod)-1)+",";
			Module := CreateChaine("put");
		else
			Module := substring(m_bloc.MonMod, 1, strpos(m_bloc.MonMod, '(')-1);
			L_courant := substring(m_bloc.MonMod, length(module)+2, strpos(m_bloc.MonMod, ')')-1);
			Ajout_queue(parametre, L_courant);
                end if;
		
		if Module in createChaine("get") | createChaine("put") then
			while (existe_apres) loop
				i := strpos(L_courant, ',');
				if (i=length(L_courant)) then
					existe_apres:=False;
					if startWith(L_courant, guillemet) then
					
						var := substring(L_courant, 2, length(L_courant));

						var := substring(var, 1, strpos(var, guillemet(1))-1);

						Ajout_queue(parametre, guillemet+var+guillemet);
						L_courant := substring(L_courant, length(var), length(L_courant));
					else
						Ajout_queue(parametre,substring(L_courant,1,i-1));
						var := substring(L_courant,1,i-1);
					end if;
				
				else
					existe_apres:=true;
					if startWith(L_courant, guillemet) then
						var := substring(L_courant, 2, length(L_courant));

						var := substring(var, 1, strpos(var, guillemet(1))-1);

						Ajout_queue(parametre, guillemet+var+guillemet);
						L_courant := substring(L_courant, length(var), length(L_courant));
					L_courant := substring(L_courant, strpos(L_courant, guillemet(1))+2, length(L_courant));	
					else
						var := substring(L_courant,1,i-1);
						Ajout_queue(parametre, var);
						L_courant := substring(L_courant, length(var)+2, length(L_courant));
					end if;
				
					L_courant := trimLeft(L_courant);
				end if;

			end loop;
		end if;

		while NOT estVide(parametre) loop
			Ajout_queue(Ligne, Module+"("+donne_tete(parametre)+");");
			enleve_enTete(parametre);
		end loop;
		
        end conversionModule;

        procedure conversionPour(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
                bi, bs: chaine; --représente respectivement la borne inf et la borne sup de la boucle
                L_courant: chaine;
		variable : chaine;
        begin
                L_courant := m_bloc.CondContinu;
		variable := substring(L_courant, 1, strpos(L_courant, '<')-1);
                bi := substring(L_courant, strpos(L_courant, '-')+1, strpos(L_courant, 'a')-1);
                bs := substring(L_courant, strpos(L_courant, 'a')+1, length(L_courant))+" ";
                
                bi := trimRight(bi);
                bs := trimLeft(bs);
                
                bi := substring(bi, strpos(bi, ' ')+1, length(bi));
                
                Ajout_queue(Ligne,"for "+variable+" in "+bi+".."+bs+" loop");
                conversionAda(m_bloc.Tab_Bloc, Ligne); 
                Ajout_queue(Ligne,CreateChaine("end loop;"));
        end conversionPour;

        procedure conversionTantque(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
		L_courant : chaine := m_bloc.CondContinu;
        begin
		L_courant := replaceStr(L_courant, " ou ", " or ");
		L_courant := replaceStr(L_courant, " et ", " and ");
                Ajout_queue(Ligne,"while "+L_courant+" loop");
                conversionAda(m_bloc.Tab_Bloc, Ligne);
                Ajout_queue(Ligne,CreateChaine("end loop;"));
         NULL;
        end conversionTantque;

        procedure conversionRepeter(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
		L_courant : chaine :=  m_bloc.CondContinu;
        begin
		L_courant := replaceStr(L_courant, " ou ", " or ");
		L_courant := replaceStr(L_courant, " et ", " and ");
                Ajout_queue(Ligne,CreateChaine("loop"));
                conversionAda(m_bloc.Tab_Bloc, Ligne);
                Ajout_queue(Ligne,"exit when "+ L_courant +";");
                Ajout_queue(ligne,CreateChaine("end loop;"));
         NULL;
        end conversionRepeter;
        
        
        procedure conversionCond(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is 
        begin
                conversionAda(m_bloc.MTab, Ligne);
                Ajout_queue(Ligne, CreateChaine("end if;"));
        end conversionCond;

        
        procedure conversionSi(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
		L_courant : chaine := m_bloc.cond;
        begin
		L_courant := replaceStr(L_courant, " ou ", " or ");
		L_courant := replaceStr(L_courant, " et ", " and ");
                Ajout_queue(Ligne, "if "+L_courant+" then");
                conversionAda(m_bloc.Liste, Ligne);
        end conversionSi;
        
        procedure conversionSinonSi(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
		L_courant : chaine := m_bloc.cond;
        begin
		L_courant := replaceStr(L_courant, " ou ", " or ");
		L_courant := replaceStr(L_courant, " et ", " and ");
                Ajout_queue(Ligne, "if "+L_courant+" then");
                conversionAda(m_bloc.Liste, Ligne);
        end conversionSinonSi;
        
        procedure conversionSinon(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
        begin
                Ajout_queue(Ligne, CreateChaine("else"));
                conversionAda(m_bloc.Liste, Ligne);
        end conversionSinon;

        procedure conversionCasParmi(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
        begin
                Ajout_queue(Ligne, "case "+m_bloc.variableATester+" is");
                conversionAda(m_bloc.Liste_case, Ligne);
                Ajout_queue(Ligne, CreateChaine("end case;"));
        end conversionCasParmi;
        
        procedure conversionCasParmisInt(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is 
        
        begin
                Ajout_queue(Ligne, "when "+m_bloc.condCase+" => ");
                conversionAda(m_bloc.instructCase, Ligne);
        end conversionCasParmisInt;

end conversion;
