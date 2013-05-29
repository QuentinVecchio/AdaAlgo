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
                      		when blocCase => conversionCasParmi();                              
			end case;
		end loop;
	end conversionAda;
	
	procedure conversionCommentaire(Bloc : in out Bloc; Ligne : out T_TAB_LIGNE) is
	begin
		Ajout_queue(Ligne,"--" + Bloc.MonCom);
	end conversionCommentaire;
	
	procedure conversionAffectation(Bloc : in Bloc; Ligne : out T_TAB_LIGNE) is
	begin
		Ajout_queue(Ligne,tabBloc.vG + ":=" + tabBloc.vD + ";");
	end conversionAffectation;

	procedure conversionModule(Bloc : in Bloc; Ligne : out T_TAB_LIGNE) is
	begin
		--if(tabBloc.MonMod(1..4) = "LIRE" OR tabBloc.MonMod(1..4) = "lire") then --On teste si c'est le module lire
			--:= "GET" + tabBloc.MonMod(5..tabBloc.MonMod'Last);
		--elsif(tabBloc.MonMod(1..5) = "ECRIRE" OR tabBloc.MonMod(1..5) = "ecrire") then -- On teste si c'est le module ecrire
			--:= "PUT" + tabBloc.MonMod(6..tabBloc.MonMod'Last);
		--endif;
	end conversionModule;

	procedure conversionPour(Bloc : in Bloc; tabLigne : out T_TAB_LIGNE) is
	begin
		--:= "FOR I in " + tabBloc.CondContinu(9)+".."+tabBloc.CondContinu(9) +"loop";
		--conversionAda(tabBloc.Tab_Bloc,);
		--:= "end loop;";
	end conversionPour;

	procedure conversionTantque(Bloc : in Bloc; tabLigne : out T_TAB_LIGNE) is
        begin
                --:= "while" + tabBloc.CondContinu + "loop";
                --conversionAda(tabBloc.Tab_Bloc,);
                --:= "end loop;";
        end conversionTantque;

	procedure conversionRepeter(Bloc : in Bloc; tabLigne : out T_TAB_LIGNE) is
        begin
		--:= "loop"
                --conversionAda(tabBloc.Tab_Bloc,);
                --:= "while" + tabBloc.CondContinu +";";
        end conversionRepeter;

	procedure conversionCasParmi(Bloc : in Bloc; tabLigne : out T_TAB_LIGNE) is
	begin
		--:= "case" + tabBloc.variableATester + "is"
	end conversionCasParmi;

end conversion;
