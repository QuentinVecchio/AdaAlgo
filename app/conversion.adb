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
                        	--when blocCond => 
                      		--when blocCase => conversionCasParmi();                              
				when others => NULL;
			end case;
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
	begin
		if(startWith(m_bloc.MonMod,"LIRE")) then --On teste si c'est le module lire
			Ajout_queue(Ligne,"GET" + substring(m_bloc.MonMod,5,length(m_bloc.MonMod)));
		elsif(startWith(m_bloc.MonMod,"ECRIRE")) then -- On teste si c'est le module ecrire
			Ajout_queue(Ligne,"PUT" + substring(m_bloc.MonMod,6,length(m_bloc.MonMod)));
		end if;
	end conversionModule;

	procedure conversionPour(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
		bi, bs: chaine; --représente respectivement la borne inf et la borne sup de la boucle
		L_courant: chaine;
	begin
		L_courant := m_bloc.CondContinu;
		bi := substring(L_courant, 1, strpos(L_courant, 'a')-1);
		bs := substring(L_courant, strpos(L_courant, 'a')+1, length(L_courant));
		
		bi := trimRight(bi);
		bs := trimLeft(bs);
		
		bi := substring(bi, strpos(bi, ' ')+1, length(bi));
		
		Ajout_queue(Ligne,"FOR I in "+bi+".."+bs+"loop");
		conversionAda(m_bloc.Tab_Bloc, Ligne); 
		Ajout_queue(Ligne,CreateChaine("end loop;"));
	end conversionPour;

	procedure conversionTantque(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
        begin
         --       Ajout_queue(Ligne,"while"+tabBloc.CondContinu+"loop");
                --conversionAda(tabBloc.Tab_Bloc,);
         --       Ajout_queue(Ligne,"end loop;");
         NULL;
        end conversionTantque;

	procedure conversionRepeter(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
        begin
	--	Ajout_queue(Ligne,"loop");
                --conversionAda(tabBloc.Tab_Bloc,);
         --       Ajout_queue(Ligne,"while" + tabBloc.CondContinu +";");
         NULL;
        end conversionRepeter;

	procedure conversionCasParmi(m_bloc : in out Bloc; Ligne : in out T_TAB_LIGNE) is
	begin
		NULL;
		--:= "case" + tabBloc.variableATester + "is"
	end conversionCasParmi;

end conversion;
