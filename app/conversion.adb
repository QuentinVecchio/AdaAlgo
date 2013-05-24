package body conversion is

	procedure conversionAda(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE) is
	begin
		case Forme is
			when commentaire  => conversionCommentaire();
                        when module  => conversionModule();
                        when affectation => conversionAffectation();
                        when pour => conversionPour();
			when tq => conversionTantque();
			when repeter => conversionRepeter();
                        --when blocCond => 
                      	when blocCase => conversionCasParmi();                              
		end case;
	end conversionAda;
	
	procedure conversionCommentaire(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE) is
		--eltAda :chaine := "--" + eltAlgo;
	begin
		--:= "--" + tabBloc.MonCom;
	end conversionCommentaire;
	
	procedure conversionAffectation(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE) is
	begin
		--:= tabBloc.vG + ":=" + tabBloc.vD + ";";
	end conversionAffectation;

	procedure conversionModule(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE) is
	begin
		--if(tabBloc.MonMod(1..4) = "LIRE" OR tabBloc.MonMod(1..4) = "lire") then --On teste si c'est le module lire
			--:= "GET" + tabBloc.MonMod(5..tabBloc.MonMod'Last);
		--elsif(tabBloc.MonMod(1..5) = "ECRIRE" OR tabBloc.MonMod(1..5) = "ecrire") then -- On teste si c'est le module ecrire
			--:= "PUT" + tabBloc.MonMod(6..tabBloc.MonMod'Last);
		--endif;
	end conversionModule;

	procedure conversionPour(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE) is
	begin
		--:= "FOR I in " + tabBloc.Intervalle +"loop";
		--conversionAda(tabBloc.Tab_Bloc,);
		--:= "end loop;";
	end conversionPour;

	procedure conversionTantque(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE) is
        begin
                --:= "while" + tabBloc.CondContinu + "loop";
                --conversionAda(tabBloc.Tab_Bloc,);
                --:= "end loop;";
        end conversionTantque;

	procedure conversionRepeter(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE) is
        begin
		--:= "loop"
                --conversionAda(tabBloc.Tab_Bloc,);
                --:= "while" + tabBloc.CondContinu +";";
        end conversionRepeter;

	procedure conversionCasParmi(tabBloc : in out T_TAB_BLOC; tabLigne : out T_TAB_LIGNE) is
	begin
		--:= "case" + tabBloc.variableATester + "is"
	end conversionCasParmi;

end conversion;
